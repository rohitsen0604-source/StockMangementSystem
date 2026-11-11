# 📦 Stock Management System (SMS) - Render Ready 🚀

A full-featured **Stock Management System** built with **PHP** and **MySQL / MariaDB**, pre-configured with **Docker** for seamless 1-Click deployment on [Render](https://render.com).

---

## 🔑 Login Credentials (Sabhi ID & Passwords)

Database me pre-configured sabhi accounts ke login credentials neeche diye gaye hain:

| # | Role / Account Type | Name | Username | Password | Access Level |
|---|---------------------|------|----------|----------|--------------|
| 1 | **Super Admin** (Primary) | Administrator Admin | `admin` | `admin123` | Full Access (All modules, settings, users) |
| 2 | **Admin** (Secondary) | Claire Blake | `cblake` | `cblake` | Full Access (Admin operations) |
| 3 | **Staff / Cashier** | John Smith | `jsmith` | `jsmith` | Staff / POS / Sales & Operations |

> 📌 **Login URL**: `https://<your-render-url>/admin` ya `http://localhost/admin`

---

## 🗄️ Database Credentials (Default)

Docker container aur local XAMPP ke default database credentials:

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| **DB Host** (`DB_SERVER`) | `localhost` ya `127.0.0.1` | Local MariaDB server |
| **DB Port** (`DB_PORT`) | `3306` | Default MySQL/MariaDB port |
| **DB Name** (`DB_NAME`) | `sms_db` | Database schema name |
| **DB Username** (`DB_USERNAME`) | `root` | Root database user |
| **DB Password** (`DB_PASSWORD`) | *(blank / koi password nahi)* | Default empty password |

---

## ⚡ 1-Click Deploy on Render (Render pe Deploy Kaise Karein)

### Option 1: 1-Click Direct Deploy (Sabse Tez)
Neeche diye gaye link par click karein aur Render par direct deploy karein:

👉 **[Deploy to Render](https://render.com/deploy?repo=https://github.com/rohitsen0604-source/StockMangementSystem)**

---

### Option 2: Render Dashboard se Manual Deploy

1. [Render.com](https://render.com) par login karein.
2. Dashboard me **New +** ➔ **Web Service** par click karein.
3. Apna repository choose karein: `rohitsen0604-source/StockMangementSystem`.
4. Settings check karein:
   - **Name**: `stock-management-system`
   - **Region**: Oregon ya Frankfurt (koi bhi)
   - **Branch**: `main`
   - **Runtime / Environment**: **Docker** *(Render Dockerfile ko auto-detect karega)*
   - **Plan**: **Free**
5. **Create Web Service** button dabayein!

> 💡 **Self-Contained Database**: Docker container me MariaDB pehle se shamil hai. Container start hote hi ye automatically `sms_db` database create karke `database/sms_db.sql` ka sample data import kar deta hai. Alag se database banane ki koi zaroorat nahi hai!

---

## ⚙️ Environment Variables (Optional)

Agar aap koi external cloud database (jaise [TiDB Cloud](https://tidbcloud.com) ya [Aiven](https://aiven.io)) use karna chahte hain taaki data permanent persist rahe:

| Variable | Default | Example for Cloud DB | Description |
|----------|---------|----------------------|-------------|
| `DB_SERVER` | `localhost` | `gateway01.us-east-1.prod.aws.tidbcloud.com` | Database Hostname |
| `DB_PORT` | `3306` | `4000` ya `3306` | Database Port |
| `DB_USERNAME` | `root` | `2xxxxxx.root` | Database Username |
| `DB_PASSWORD` | *(empty)* | `AapkaPassword` | Database Password |
| `DB_NAME` | `sms_db` | `sms_db` | Database Name |
| `BASE_URL` | Auto-detected | `https://stock-management-system.onrender.com/` | Custom Domain / App URL |

---

## 💻 Local Setup (XAMPP Users)

1. Is repository ko apne `htdocs` folder me clone ya download karein.
2. XAMPP Control Panel me **Apache** aur **MySQL** start karein.
3. Browser me `http://localhost/phpmyadmin` open karein.
4. Ek naya database banayein jiska naam ho: `sms_db`.
5. `database/sms_db.sql` file ko `sms_db` database me **Import** karein.
6. Browser me open karein: `http://localhost/StockMangementSystem/` ya `http://localhost/StockMangementSystem/admin/`.
7. Login karein `admin` / `admin123` ke saath.

---

## ✨ Features

- 📊 **Dashboard**: Real-time sales, purchase orders, receiving, and stocks analytics
- 🛒 **Purchase Orders**: Manage POs, track vendor orders and approval states
- 📦 **Receiving Management**: Receive inventory against POs, calculate tax & discounts
- 🔄 **Back Orders & Returns**: Manage partial shipments and vendor returns
- 💰 **Sales Management**: Point of Sale style sales billing and invoice generation
- 🏷️ **Item & Supplier Management**: Comprehensive catalog with pricing, units, and supplier contacts
- 👥 **User Management**: Multi-user role-based access control (Admins & Staff)
- ⚙️ **System Settings**: Store logo, cover photo, system title customization
