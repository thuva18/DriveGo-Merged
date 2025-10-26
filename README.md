# DriveGoMergedBase (Java 17)

Spring Boot 3 Car Rental Management System with automatic database setup.

## 🚀 Quick Start

### 1. Create Database
```sql
CREATE DATABASE DriveGo2;
```

### 2. Configure Database
Edit `src/main/resources/application.yml`:
```yaml
spring:
  datasource:
    username: root           # Your MySQL username
    password: YourPassword   # Your MySQL password
```

### 3. Run Application
```bash
mvn spring-boot:run
```

**All tables will be created automatically!** ✨

For detailed setup instructions, see:
- **[QUICK_SETUP.md](QUICK_SETUP.md)** - Quick 3-step guide
- **[DATABASE_SETUP.md](DATABASE_SETUP.md)** - Complete documentation

## Tech Stack
- Java 17, Maven, Spring Boot 3.3
- Spring MVC + Thymeleaf (templates) + JSP (WEB-INF/jsp)
- Spring Data JPA, MySQL, Flyway (optional), Security, Validation

## Structure
```
com.drivego
 ├─ config
 ├─ common
 ├─ user
 ├─ vehicle
 ├─ customer
 ├─ booking
 ├─ payment
 ├─ report
 └─ dashboard

src/main/resources/templates/         # Thymeleaf pages
src/main/webapp/WEB-INF/jsp/          # JSP pages
src/main/resources/static/js|css|img  # Static files
```

## Run
```bash
export DB_USER=youruser
export DB_PASS=yourpass
mvn clean spring-boot:run
```

Then open http://localhost:8080
