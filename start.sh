#!/bin/bash
set -e

PORT="${PORT:-80}"

echo "Configuring Apache for port ${PORT}..."
sed -i "s/Listen [0-9]\+/Listen ${PORT}/g" /etc/apache2/ports.conf
sed -i "s/<VirtualHost \*:[0-9]\+>/<VirtualHost \*:${PORT}>/g" /etc/apache2/sites-available/000-default.conf

# Check whether to use built-in MariaDB or external database
if [ -z "$DB_SERVER" ] || [ "$DB_SERVER" = "localhost" ] || [ "$DB_SERVER" = "127.0.0.1" ]; then
    echo "Using local MariaDB database..."
    mkdir -p /var/run/mysqld
    chown -R mysql:mysql /var/run/mysqld
    chmod 777 /var/run/mysqld

    /etc/init.d/mariadb start

    # Wait for MariaDB to start up
    RETRIES=15
    until mysqladmin ping --silent || [ $RETRIES -eq 0 ]; do
        echo "Waiting for MariaDB to be ready ($RETRIES retries left)..."
        sleep 1
        RETRIES=$((RETRIES-1))
    done

    # Ensure root has access without unix_socket blocking
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('');" 2>/dev/null || true
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" 2>/dev/null || true
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION;" 2>/dev/null || true
    mysql -e "FLUSH PRIVILEGES;" 2>/dev/null || true

    # Initialize sms_db if it doesn't exist
    if ! mysql -u root -e "USE sms_db;" 2>/dev/null; then
        echo "Creating sms_db database..."
        mysql -u root -e "CREATE DATABASE IF NOT EXISTS sms_db;"
        if [ -f "/var/www/html/database/sms_db.sql" ]; then
            echo "Importing database/sms_db.sql..."
            mysql -u root sms_db < /var/www/html/database/sms_db.sql
            echo "Initial database imported successfully."
        fi
    else
        echo "Database sms_db already exists."
    fi
else
    echo "Using external MySQL database at ${DB_SERVER}:${DB_PORT:-3306}..."
fi

# Ensure uploads directory is writable
mkdir -p /var/www/html/uploads
chown -R www-data:www-data /var/www/html/uploads
chmod -R 777 /var/www/html/uploads

echo "Starting Apache web server on port ${PORT}..."
exec apache2-foreground
