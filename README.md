# Stock Management System (SMS) - Render Ready 🚀

PHP and MySQL based Stock Management System, pre-configured for **1-Click / Docker deployment on Render**.

---

## ⚡ Quick Deploy on Render (Render pe Deploy Kaise Karein)

### Step 1: Push Changes to GitHub
Is repository ko apne GitHub account par push karein:
```bash
git add .
git commit -m "feat: configure docker and render deployment"
git push origin main
```

---

### Step 2: Create Web Service on Render
1. [Render.com](https://render.com) par login ya sign up karein.
2. Dashboard par jakar **New +** button par click karein aur **Web Service** chunein.
3. Apna GitHub repository connect karein (`StockMangementSystem`).
4. Settings check karein:
   - **Name**: `stock-management-system` (ya koi bhi manpasand naam)
   - **Region**: Oregon ya Frankfurt (koi bhi)
   - **Runtime**: **Docker** (Render Dockerfile ko khud detect kar lega)
   - **Instance Type**: **Free**
5. **Create Web Service** button par click karein!

> 💡 **Bonus Feature (Auto Setup)**: Is Docker container me MariaDB pehle se included hai. Jaise hi Render container start hoga, ye automatically `sms_db` database create karke sample data import kar dega. Aapko alag se database configure karne ki zaroorat nahi hai!

---

## 🔐 Default Login Credentials
Deployment complete hone ke baad Render URL open karein:
- **URL**: `https://<your-service-name>.onrender.com`
- **Username**: `admin`
- **Password**: `admin123`

---

## 🗄️ (Optional) External Cloud Database Setup (Permanent Storage)
Render ka free tier 15 minutes inactive hone ke baad sleep par chala jata hai aur container restart hone par local changes reset ho sakte hain. Agar aap data hamesha ke liye permanently save rakhna chahte hain:

1. [TiDB Cloud](https://tidbcloud.com) ya [Aiven](https://aiven.io) par ek free MySQL database banayein.
2. Us database me `database/sms_db.sql` import karein.
3. Render Dashboard me **Environment Variables** add karein:
   - `DB_SERVER`: Aapke database ka host (e.g. `gateway01.us-east-1.prod.aws.tidbcloud.com`)
   - `DB_PORT`: `4000` ya `3306`
   - `DB_USERNAME`: Database username
   - `DB_PASSWORD`: Database password
   - `DB_NAME`: Database name (e.g. `sms_db`)
   - `BASE_URL`: (Optional) `https://<your-service-name>.onrender.com/`

Jab `DB_SERVER` external set hoga, container local MariaDB run nahi karega aur seedhe aapke cloud database se connect ho jayega!
