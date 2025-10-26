# DriveGo - Database Auto-Setup Guide

This guide explains how the DriveGo application **automatically creates database tables** when running on any device.

## Quick Start (Automatic Setup)

### Prerequisites
- MySQL Server 8.0+ installed and running
- Java 17+ installed
- Maven 3.6+ installed

### Setup Steps

1. **Create the database** (only this is manual):
   ```sql
   CREATE DATABASE DriveGo2;
   ```

2. **Update database credentials** in `src/main/resources/application.yml`:
   ```yaml
   spring:
     datasource:
       username: root           # Your MySQL username
       password: YourPassword   # Your MySQL password
   ```

3. **Run the application**:
   ```bash
   mvn spring-boot:run
   ```

**That's it!** All tables will be created automatically! ✨

## What Happens Automatically

When you start the application:

### ✅ Tables Created Automatically
- `users` - User accounts
- `roles` - User roles (ADMIN, USER)
- `users_roles` - User-role assignments
- `vehicles` - Vehicle inventory
- `car_bookings` - Customer bookings
- `payments` - Payment transactions  
- `bank_transfer_receipts` - Receipt uploads
- `payment_methods` - Payment options
- `reports` - Generated reports
- All other necessary tables

### ✅ Initial Data Inserted Automatically
- Default roles: `ROLE_USER`, `ROLE_ADMIN`
- Payment methods: PayPal, Visa, MasterCard, HSBC Debit

## How It Works

### Automatic Table Creation
The application uses **Hibernate DDL Auto** configured in `application.yml`:

```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: update  # Creates/updates tables automatically
```

**What `update` does:**
- Creates tables if they don't exist
- Updates table structure if entities change
- **Preserves existing data** (safe to use)
- No manual SQL scripts needed!

### Automatic Data Initialization  
Initial data is loaded from `src/main/resources/data.sql`:

```yaml
spring:
  sql:
    init:
      mode: always            # Run SQL on startup
      continue-on-error: true # Don't fail if data exists
```

## Configuration for Different Environments

### Development (Current Setup)
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: update  # Auto-create/update tables
```
**Best for:** Local development, testing

### Production (Recommended)
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: validate  # Only check schema, don't modify
```
**Best for:** Live servers (use database migrations)

### Testing
```yaml
spring:
  jpa:
    hibernate:
      ddl-auto: create-drop  # Fresh DB each test run
```
**Best for:** Unit/integration tests

## Database Setup on Another Device

### Option 1: Automatic (Recommended)

1. Install MySQL
2. Create database: `CREATE DATABASE DriveGo2;`
3. Update `application.yml` with your MySQL credentials
4. Run: `mvn spring-boot:run`
5. Done! Tables created automatically

### Option 2: Manual (If needed)

If you want to create tables manually:

1. Export schema from development:
   ```bash
   mysqldump -u root -p --no-data DriveGo2 > schema.sql
   ```

2. Import on new device:
   ```bash
   mysql -u root -p DriveGo2 < schema.sql
   ```

3. Update `application.yml`:
   ```yaml
   spring:
     jpa:
       hibernate:
         ddl-auto: validate  # Don't auto-create
   ```

## Using Environment Variables (Production)

Don't hardcode passwords! Use environment variables:

### application.yml
```yaml
spring:
  datasource:
    url: ${DB_URL:jdbc:mysql://localhost:3306/DriveGo2?useSSL=false&serverTimezone=UTC}
    username: ${DB_USERNAME:root}
    password: ${DB_PASSWORD}
```

### Set environment variables

**Linux/Mac:**
```bash
export DB_URL=jdbc:mysql://localhost:3306/DriveGo2
export DB_USERNAME=drivego_user
export DB_PASSWORD=SecurePassword123
```

**Windows:**
```cmd
set DB_URL=jdbc:mysql://localhost:3306/DriveGo2
set DB_USERNAME=drivego_user
set DB_PASSWORD=SecurePassword123
```

## Troubleshooting

### ❌ "Unknown database 'DriveGo2'"
**Solution:** Create the database manually:
```sql
CREATE DATABASE DriveGo2;
```

### ❌ "Access denied for user 'root'@'localhost'"
**Solution:** Check username/password in `application.yml`

### ❌ "Communications link failure"
**Solutions:**
1. Ensure MySQL is running: `sudo systemctl status mysql` (Linux)
2. Check MySQL port (default: 3306)
3. Verify firewall allows MySQL connections

### ❌ Tables not created
**Solutions:**
1. Check `ddl-auto` is set to `update`
2. View application logs for errors
3. Verify MySQL user has CREATE privilege:
   ```sql
   GRANT CREATE ON DriveGo2.* TO 'root'@'localhost';
   FLUSH PRIVILEGES;
   ```

### ❌ "Duplicate entry" errors on startup
**Normal!** The `data.sql` uses `INSERT IGNORE`, so duplicate entries are safely skipped.

## Database Backup & Restore

### Backup Database
```bash
# Schema + Data
mysqldump -u root -p DriveGo2 > drivego_backup.sql

# Schema only
mysqldump -u root -p --no-data DriveGo2 > drivego_schema.sql
```

### Restore Database
```bash
# Create database first
mysql -u root -p -e "CREATE DATABASE DriveGo2;"

# Restore
mysql -u root -p DriveGo2 < drivego_backup.sql
```

## Security Best Practices

### 1. Create Dedicated Database User
```sql
CREATE USER 'drivego_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON DriveGo2.* TO 'drivego_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Use Different Credentials per Environment
- Development: Local MySQL root user
- Production: Dedicated user with limited privileges
- Never commit passwords to Git!

### 3. Secure Production Database
```sql
-- Grant only necessary privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON DriveGo2.* TO 'prod_user'@'%';
-- No DROP, CREATE for production user
```

## Verification

After starting the application, verify tables were created:

```sql
USE DriveGo2;
SHOW TABLES;

-- Should show:
-- bank_transfer_receipts
-- car_bookings
-- payment_methods
-- payments
-- reports
-- roles
-- users
-- users_roles
-- vehicles
-- (and others)
```

Check initial data:
```sql
SELECT * FROM roles;
-- Should show ROLE_USER and ROLE_ADMIN

SELECT * FROM payment_methods;
-- Should show PayPal, Visa, MasterCard, etc.
```

## Summary

✅ **Tables**: Created automatically by Hibernate  
✅ **Initial Data**: Loaded automatically from `data.sql`  
✅ **Safe**: `ddl-auto: update` preserves existing data  
✅ **No Manual SQL**: Just create the database and run!  

**You only need to:**
1. Create empty database: `CREATE DATABASE DriveGo2;`
2. Configure credentials in `application.yml`
3. Run the application: `mvn spring-boot:run`

Everything else happens automatically! 🚀

---

**Last Updated**: October 2025  
**Application**: DriveGo Car Rental System  
**Spring Boot Version**: 3.3.3
