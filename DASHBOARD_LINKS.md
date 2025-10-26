# 🚗 DriveGo Dashboard Links

## 🎯 Main Dashboard
**Primary Link:** http://localhost:8080/dashboard

Alternative: http://localhost:8080/

## 📋 All Application Links

### Core Features
- **📊 Dashboard** - http://localhost:8080/dashboard
- **📅 Bookings** - http://localhost:8080/bookings
- **🚙 Vehicles** - http://localhost:8080/vehicles
- **👥 Customers** - http://localhost:8080/customers
- **💳 Payments** - http://localhost:8080/payments
- **👤 Users** - http://localhost:8080/users

### Reports & Analytics
- **📈 Reports (Generate)** - http://localhost:8080/reports
- **📋 Reports Management** - http://localhost:8080/reports/manage
- **➕ Create New Report** - http://localhost:8080/reports/new

### API Endpoints
- **GET All Reports** - http://localhost:8080/api/reports
- **POST Create Report** - http://localhost:8080/api/reports
- **GET Report by ID** - http://localhost:8080/api/reports/{id}
- **PUT Update Report** - http://localhost:8080/api/reports/{id}
- **DELETE Report** - http://localhost:8080/api/reports/{id}

## 🚀 How to Run the Application

### Step 1: Set Database Credentials
You need to set your MySQL username and password as environment variables:

```bash
export DB_USER=your_mysql_username
export DB_PASS=your_mysql_password
```

For example, if your MySQL credentials are:
- Username: `root`
- Password: `yourpassword`

Then run:
```bash
export DB_USER=root
export DB_PASS=yourpassword
```

### Step 2: Make Sure MySQL is Running
Ensure MySQL is running on your system:
```bash
mysql.server start  # For macOS
# or
brew services start mysql  # If installed via Homebrew
```

### Step 3: Run the Application
```bash
cd /Users/ravinduhettiarachchi/Documents/DriveGoMergedBase-java17
mvn spring-boot:run
```

Or set credentials and run in one command:
```bash
export DB_USER=root DB_PASS=yourpassword && mvn spring-boot:run
```

### Step 4: Access the Application
Once the application starts successfully, open your browser and go to:
**http://localhost:8080**

You'll see a beautiful home page with links to all features!

## 🔧 Troubleshooting

### Issue: "Access denied for user"
- Check your MySQL credentials
- Make sure the user has proper permissions
- Try connecting to MySQL manually: `mysql -u root -p`

### Issue: "Cannot connect to database"
- Ensure MySQL is running
- Check if port 3306 is available
- Verify the database connection in application.yml

### Issue: Database doesn't exist
The application will automatically create the `drivego` database if it doesn't exist (thanks to `createDatabaseIfNotExist=true` in the connection URL).

## 📝 Configuration
Database configuration is in: `src/main/resources/application.yml`

Current settings:
- **Port:** 8080
- **Database:** drivego (auto-created)
- **Hibernate DDL:** update (auto-creates tables)
- **MySQL URL:** jdbc:mysql://localhost:3306/drivego

## 🎨 Features of the Home Page
The home page at http://localhost:8080 provides:
- Beautiful gradient design
- Quick access cards to all modules
- API endpoint links
- Responsive layout
- Hover effects on cards

Enjoy using DriveGo! 🚗✨

