FROM php:8.2-apache

# Install MariaDB, GD, MySQLi and required utilities
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip \
    && a2enmod rewrite headers \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Low-memory configuration for MariaDB (fits within Render 512MB RAM free tier)
RUN echo "[mysqld]\n\
performance_schema = OFF\n\
innodb_buffer_pool_size = 32M\n\
innodb_log_buffer_size = 4M\n\
key_buffer_size = 16M\n\
max_connections = 30\n" > /etc/mysql/conf.d/lowram.cnf

# Configure Apache Directory permissions and AllowOverride
RUN echo '<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/override.conf \
    && a2enconf override

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . /var/www/html/

# Fix line endings on start.sh and make executable
RUN sed -i 's/\r$//' /var/www/html/start.sh \
    && chmod +x /var/www/html/start.sh

# Ensure proper permissions for web server and uploads
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 777 /var/www/html/uploads

# Expose default port
EXPOSE 80

# Run entrypoint script
CMD ["/var/www/html/start.sh"]

