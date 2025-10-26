#!/bin/bash
# ============================================
# Test Script: Fresh Database Setup
# ============================================
# This script demonstrates automatic table creation with sample data

echo "================================================"
echo " DriveGo - Fresh Database Setup Test"
echo "================================================"

# MySQL connection details (update these)
MYSQL_USER="root"
MYSQL_PASSWORD="Ravindu@333"
DB_NAME="DriveGo2_Test"

echo ""
echo "Step 1: Creating fresh test database..."
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "DROP DATABASE IF EXISTS $DB_NAME;"
mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e "CREATE DATABASE $DB_NAME;"

if [ $? -eq 0 ]; then
    echo "✓ Database '$DB_NAME' created successfully!"
else
    echo "✗ Failed to create database!"
    exit 1
fi

echo ""
echo "Step 2: Updating application.yml..."
# Backup original
cp src/main/resources/application.yml src/main/resources/application.yml.backup

# Update database name in application.yml
sed -i.tmp "s/DriveGo2/$DB_NAME/g" src/main/resources/application.yml
rm -f src/main/resources/application.yml.tmp

echo "✓ Configuration updated!"

echo ""
echo "Step 3: Building application..."
mvn clean package -DskipTests > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✓ Build successful!"
else
    echo "✗ Build failed!"
    mv src/main/resources/application.yml.backup src/main/resources/application.yml
    exit 1
fi

echo ""
echo "Step 4: Starting application (tables will be auto-created)..."
echo "Press Ctrl+C to stop the server after verification"
echo ""

# Start application
mvn spring-boot:run

# Restore original config when done
echo ""
echo "Restoring original configuration..."
mv src/main/resources/application.yml.backup src/main/resources/application.yml

echo ""
echo "================================================"
echo " Test Complete!"
echo "================================================"
echo ""
echo "To verify, connect to MySQL and run:"
echo "  USE $DB_NAME;"
echo "  SHOW TABLES;"
echo "  SELECT * FROM vehicles;"
echo "  SELECT * FROM car_bookings;"
echo "  SELECT * FROM payments;"
echo ""
