# DriveGo - Quick Setup Guide for Other Devices

## ⚡ 3-Step Setup

### Step 1: Install Requirements
- MySQL 8.0+
- Java 17+
- Maven 3.6+

### Step 2: Create Database
```sql
CREATE DATABASE DriveGo2;
```

### Step 3: Update Configuration
Edit `src/main/resources/application.yml`:
```yaml
spring:
  datasource:
    username: your_mysql_username
    password: your_mysql_password
```

### Run Application
```bash
mvn spring-boot:run
```

## ✨ What Happens Automatically

✅ All database tables are created automatically  
✅ Initial data (roles, payment methods) inserted automatically  
✅ No manual SQL scripts needed  
✅ Safe - preserves existing data if tables already exist  

## 🔧 Configuration Changes Made

### 1. Hibernate DDL Auto (application.yml)
**Before:** `ddl-auto: none` (manual table creation required)  
**Now:** `ddl-auto: update` (automatic table creation)

### 2. SQL Initialization (application.yml)
**Added:**
```yaml
spring:
  sql:
    init:
      mode: always
      continue-on-error: true
```

### 3. Initial Data Script (data.sql)
Created `src/main/resources/data.sql` with:
- Default roles (ROLE_USER, ROLE_ADMIN)
- Payment methods (PayPal, Visa, MasterCard, etc.)

## 📋 Tables Created Automatically

When you run the application, these tables will be created:

| Table Name | Description |
|-----------|-------------|
| `users` | User accounts |
| `roles` | User roles (Admin, User) |
| `users_roles` | User-role mapping |
| `vehicles` | Vehicle inventory |
| `car_bookings` | Booking records |
| `payments` | Payment transactions |
| `bank_transfer_receipts` | Receipt files |
| `payment_methods` | Payment options |
| `reports` | Generated reports |

## 🔒 Security Note

**For production deployment:**
1. Use environment variables for database credentials
2. Create a dedicated MySQL user (not root)
3. Change `ddl-auto` to `validate` (prevents auto schema changes)

See `DATABASE_SETUP.md` for detailed instructions.

## ❓ Common Issues

**"Unknown database 'DriveGo2'"**  
→ Create database: `CREATE DATABASE DriveGo2;`

**"Access denied"**  
→ Check username/password in `application.yml`

**"Tables not created"**  
→ Check that `ddl-auto: update` in `application.yml`

---

For complete documentation, see **DATABASE_SETUP.md**
