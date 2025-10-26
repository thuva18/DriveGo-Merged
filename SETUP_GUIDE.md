# 🚗 DriveGo Application - Complete Setup Guide

## Overview
This guide will help you set up and run the DriveGo Car Rental Management System on a fresh PC from scratch.

---

## 📋 Prerequisites Installation

### 1. Install Java 17 JDK
**Required**: Java 17 or higher

**Download Options:**
- Oracle JDK: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
- OpenJDK (Free): https://adoptium.net/

**Installation Steps:**
1. Download Java 17 JDK for your operating system
2. Install following the installer instructions
3. Verify installation:
```bash
java -version
javac -version
```
Expected output: `java version "17.x.x"`

### 2. Install Apache Maven
**Required**: Maven 3.6 or higher

**Download:** https://maven.apache.org/download.cgi

**Installation Steps:**
1. Download Maven binary zip file
2. Extract to a folder (e.g., `C:\Program Files\Apache\maven` on Windows)
3. Add Maven `bin` directory to your system PATH
4. Verify installation:
```bash
mvn -version
```

### 3. Install MySQL Database
**Required**: MySQL 8.0 or higher

**Installation by OS:**

**Windows:**
1. Download MySQL Installer: https://dev.mysql.com/downloads/installer/
2. Run installer and select "Developer Default"
3. Set root password (remember this!)
4. Complete installation

**macOS (using Homebrew):**
```bash
brew install mysql
brew services start mysql
```

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo mysql_secure_installation
```

**Verify MySQL Installation:**
```bash
mysql --version
```

---

## 🗄️ Database Setup

### 1. Connect to MySQL
```bash
mysql -u root -p
```
Enter your root password when prompted.

### 2. Create Database and User
```sql
-- Create the database
CREATE DATABASE DriveGo2;

-- Create a dedicated user (optional but recommended)
CREATE USER 'drivego_user'@'localhost' IDENTIFIED BY 'SecurePassword123!';

-- Grant privileges
GRANT ALL PRIVILEGES ON DriveGo2.* TO 'drivego_user'@'localhost';
FLUSH PRIVILEGES;

-- Verify database creation
SHOW DATABASES;

-- Exit MySQL
EXIT;
```

**Note**: If you prefer using root user, make sure you know the root password.

---

## 📁 Project Setup

### 1. Download/Clone Project
- Download the DriveGo project files
- Extract to a folder (e.g., `C:\Projects\DriveGoMergedBase-java17`)

### 2. Navigate to Project Directory
```bash
cd /path/to/DriveGoMergedBase-java17
```

### 3. Configure Database Connection
Edit the file: `src/main/resources/application.yml`

**For Root User (Current Config):**
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/DriveGo2?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
    driver-class-name: com.mysql.cj.jdbc.Driver
    username: root
    password: YOUR_ROOT_PASSWORD  # Replace with your actual root password
```

**For Dedicated User:**
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/DriveGo2?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
    driver-class-name: com.mysql.cj.jdbc.Driver
    username: drivego_user
    password: SecurePassword123!  # Replace with your chosen password
```

---

## 🚀 Running the Application

### 1. Install Dependencies
```bash
# Navigate to project directory
cd DriveGoMergedBase-java17

# Clean and install dependencies
mvn clean install

# If tests fail, skip them
mvn clean install -DskipTests
```

### 2. Start the Application
**Option 1: Direct Run (Recommended for development)**
```bash
mvn spring-boot:run
```

**Option 2: Build and Run JAR**
```bash
# Build the JAR file
mvn clean package -DskipTests

# Run the JAR
java -jar target/drivego-merged-base-1.0-SNAPSHOT.jar
```

**Option 3: Background Execution**
```bash
# Run in background (Linux/macOS)
nohup mvn spring-boot:run > app.log 2>&1 &

# View logs
tail -f app.log
```

### 3. Verify Application Started
```bash
# Check if application is responding
curl -I http://localhost:8080

# Expected response: HTTP/1.1 200
```

---

## 🌐 Access the Application

### Main URLs:
- **Homepage**: http://localhost:8080
- **Admin Dashboard**: http://localhost:8080/dashboard  
- **Customer Login**: http://localhost:8080/login
- **Customer Registration**: http://localhost:8080/register

### Default Admin Credentials:
- **Username**: admin
- **Password**: admin

---

## ✅ Verification Steps

### 1. Check Database Tables
After the application starts, verify tables were created:
```sql
mysql -u root -p DriveGo2

-- List all tables
SHOW TABLES;

-- Check specific tables
DESCRIBE users;
DESCRIBE vehicles;
DESCRIBE bookings;

EXIT;
```

### 2. Application Health Check
```bash
# Check application status
curl http://localhost:8080

# Check server logs
tail -20 app.log | grep "Started DriveGoApplication"
```

### 3. Access Web Interface
1. Open browser and go to http://localhost:8080
2. You should see the DriveGo homepage
3. Try accessing admin dashboard: http://localhost:8080/dashboard

---

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. Port 8080 Already in Use
```bash
# Find process using port 8080
lsof -ti:8080

# Kill the process
kill -9 $(lsof -ti:8080)

# Or change port in application.yml
server:
  port: 8081
```

#### 2. Database Connection Failed
- Verify MySQL is running: `systemctl status mysql` (Linux) or `brew services list | grep mysql` (macOS)
- Check database exists: `mysql -u root -p -e "SHOW DATABASES;"`
- Verify credentials in `application.yml`
- Check database URL format

#### 3. Java Version Issues
```bash
# Check Java version
java -version

# Set JAVA_HOME if needed (Linux/macOS)
export JAVA_HOME=/path/to/java17

# Windows
set JAVA_HOME=C:\Program Files\Java\jdk-17
```

#### 4. Maven Build Fails
```bash
# Clear Maven cache
mvn dependency:purge-local-repository

# Retry build
mvn clean install -DskipTests
```

#### 5. Application Won't Start
1. Check `app.log` for error messages
2. Verify all prerequisites are installed
3. Ensure database is running and accessible
4. Check firewall settings for port 8080

---

## 📊 Features Available

### Customer Features:
- Vehicle browsing and booking
- User registration and login  
- Booking management
- Contact system with messaging
- Profile management

### Admin Features:
- Dashboard with analytics
- Vehicle management
- Booking management
- User management
- Payment processing
- Report generation with charts
- Message management

### Technical Features:
- Modern responsive UI with animations
- Form validation
- Chart visualization (revenue, fleet, customer reports)
- File upload support
- Session management
- CSRF protection

---

## 🔄 Stopping the Application

### If Running in Foreground:
Press `Ctrl + C`

### If Running in Background:
```bash
# Find the process
ps aux | grep spring-boot

# Kill by process name
pkill -f spring-boot:run

# Or kill by port
kill -9 $(lsof -ti:8080)
```

---

## 📝 Configuration Options

### Common Application Settings:
Edit `src/main/resources/application.yml`:

```yaml
server:
  port: 8080  # Change application port

spring:
  datasource:
    url: jdbc:mysql://localhost:3306/DriveGo2  # Database URL
    username: root  # Database username
    password: your_password  # Database password
  
  jpa:
    hibernate:
      ddl-auto: update  # Options: create, update, validate, create-drop
    show-sql: true  # Set to false to hide SQL logs
```

---

## 🆘 Support Commands

```bash
# Check application status
curl -I http://localhost:8080

# View recent logs
tail -50 app.log

# Check database connectivity
mysql -u root -p DriveGo2 -e "SELECT 1;"

# Check Java processes
jps -v

# Check port usage
netstat -tlnp | grep :8080

# Full application restart
pkill -f spring-boot:run
mvn spring-boot:run
```

---

## 📚 Additional Notes

### Database Auto-Creation:
- The application automatically creates all necessary tables
- Uses Hibernate with `ddl-auto: update`
- No manual table creation required

### Sample Data:
- Application starts with empty database
- You can create admin users and sample data through the web interface
- Or insert test data directly into MySQL

### Security:
- Application includes basic security configurations
- Admin credentials are configurable
- CSRF protection enabled
- Session management included

---

## ✅ Quick Start Checklist

- [ ] Java 17 installed and verified
- [ ] Maven installed and verified
- [ ] MySQL installed and running
- [ ] Database `DriveGo2` created
- [ ] Database user configured
- [ ] Project files downloaded
- [ ] `application.yml` configured with correct database credentials
- [ ] Dependencies installed (`mvn clean install`)
- [ ] Application started (`mvn spring-boot:run`)
- [ ] Application accessible at http://localhost:8080
- [ ] Database tables created automatically
- [ ] Admin dashboard accessible

---

## 🎯 Success Indicators

✅ **Application Started Successfully:**
- Console shows "Started DriveGoApplication in X.XXX seconds"
- HTTP 200 response from http://localhost:8080
- Database tables visible in MySQL

✅ **Features Working:**
- Homepage loads with navigation
- Admin dashboard accessible
- User registration/login functional
- Database queries in logs show table access

---

**Support**: If you encounter issues, check the troubleshooting section or examine the `app.log` file for detailed error messages.

**Version**: DriveGo v1.0 - Car Rental Management System
**Last Updated**: October 2025