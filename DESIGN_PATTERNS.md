# Design Patterns in DriveGo Application

This document describes the **2 design patterns** implemented in the DriveGo vehicle rental management system to demonstrate software engineering best practices.

---

## Table of Contents
1. [Strategy Pattern - Payment Processing](#1-strategy-pattern---payment-processing)
2. [Factory Pattern - Report Generation](#2-factory-pattern---report-generation)
3. [Benefits and Use Cases](#benefits-and-use-cases)
4. [How to Test the Patterns](#how-to-test-the-patterns)

---

## 1. Strategy Pattern - Payment Processing

### 📋 Pattern Overview

**Type:** Behavioral Design Pattern

**Purpose:** Defines a family of algorithms (payment methods), encapsulates each one, and makes them interchangeable. The Strategy pattern lets the algorithm vary independently from clients that use it.

### 🎯 Problem It Solves

**Before Pattern:**
```java
// Bad: Multiple if-else statements for different payment methods
public void processPayment(String method, double amount) {
    if (method.equals("credit-card")) {
        // Credit card logic
        validateCard();
        chargeCard();
    } else if (method.equals("bank-transfer")) {
        // Bank transfer logic
        validateAccount();
        transferFunds();
    } else if (method.equals("cash")) {
        // Cash logic
        recordCashPayment();
    }
    // Hard to add new payment methods!
}
```

**After Pattern:**
```java
// Good: Strategy pattern - Easy to extend
paymentContext.setPaymentStrategy(creditCardStrategy);
PaymentResult result = paymentContext.executePayment(amount, details);
```

### 🏗️ Implementation Structure

```
payment/strategy/
├── PaymentStrategy.java           (Strategy Interface)
├── PaymentResult.java              (Result Object)
├── CreditCardPaymentStrategy.java  (Concrete Strategy)
├── BankTransferPaymentStrategy.java (Concrete Strategy)
├── CashPaymentStrategy.java        (Concrete Strategy)
└── PaymentContext.java             (Context Class)
```

### 📐 UML Diagram

```
┌─────────────────────────┐
│   <<interface>>         │
│   PaymentStrategy       │
├─────────────────────────┤
│ + processPayment()      │
│ + getPaymentMethodName()│
│ + validatePaymentDetails()│
└──────────△──────────────┘
           │
           │ implements
     ┌─────┴─────┬─────────────────┐
     │           │                 │
┌────▼────┐ ┌───▼────┐ ┌──────────▼─────┐
│ Credit  │ │  Bank  │ │      Cash      │
│  Card   │ │Transfer│ │    Payment     │
│Strategy │ │Strategy│ │    Strategy    │
└─────────┘ └────────┘ └────────────────┘
     │
     │ uses
     ▼
┌──────────────────┐
│ PaymentContext   │
├──────────────────┤
│- strategy        │
├──────────────────┤
│+ setStrategy()   │
│+ executePayment()│
└──────────────────┘
```

### 💻 Code Example

#### 1. Strategy Interface
```java
public interface PaymentStrategy {
    PaymentResult processPayment(double amount, String paymentDetails);
    String getPaymentMethodName();
    boolean validatePaymentDetails(String paymentDetails);
}
```

#### 2. Concrete Strategy (Credit Card)
```java
@Component
public class CreditCardPaymentStrategy implements PaymentStrategy {
    @Override
    public PaymentResult processPayment(double amount, String paymentDetails) {
        // Validate card
        if (!validatePaymentDetails(paymentDetails)) {
            return new PaymentResult(false, null, "Invalid card", "Credit Card");
        }
        
        // Process payment
        String transactionId = "CC-" + UUID.randomUUID();
        return new PaymentResult(true, transactionId, 
            "Payment successful", "Credit Card");
    }
    
    @Override
    public boolean validatePaymentDetails(String cardNumber) {
        // Validate 16-digit card number
        return cardNumber.matches("^\\d{16}$");
    }
}
```

#### 3. Context Class
```java
@Component
public class PaymentContext {
    private PaymentStrategy paymentStrategy;
    
    public void setPaymentStrategy(PaymentStrategy strategy) {
        this.paymentStrategy = strategy;
    }
    
    public PaymentResult executePayment(double amount, String details) {
        return paymentStrategy.processPayment(amount, details);
    }
}
```

#### 4. Usage Example
```java
@Service
public class PaymentProcessingService {
    private final PaymentContext context;
    private final CreditCardPaymentStrategy creditCardStrategy;
    
    public PaymentResult processPayment(String method, double amount, String details) {
        // Select strategy based on method
        PaymentStrategy strategy = switch(method) {
            case "credit-card" -> creditCardStrategy;
            case "bank-transfer" -> bankTransferStrategy;
            case "cash" -> cashStrategy;
        };
        
        // Set strategy and execute
        context.setPaymentStrategy(strategy);
        return context.executePayment(amount, details);
    }
}
```

### ✅ Benefits

1. **Open/Closed Principle:** Open for extension (new payment methods), closed for modification
2. **Single Responsibility:** Each payment method has its own class
3. **Eliminates Conditionals:** No if-else chains for payment types
4. **Easy Testing:** Each strategy can be tested independently
5. **Runtime Flexibility:** Payment method can be changed at runtime

### 📍 Location in Project

- **Package:** `com.drivego.payment.strategy`
- **Files:**
  - `PaymentStrategy.java` - Interface
  - `PaymentContext.java` - Context
  - `CreditCardPaymentStrategy.java` - Concrete strategy
  - `BankTransferPaymentStrategy.java` - Concrete strategy
  - `CashPaymentStrategy.java` - Concrete strategy
  - `PaymentProcessingService.java` - Service using pattern

---

## 2. Factory Pattern - Report Generation

### 📋 Pattern Overview

**Type:** Creational Design Pattern

**Purpose:** Defines an interface for creating objects, but lets subclasses decide which class to instantiate. The Factory pattern lets a class defer instantiation to subclasses.

### 🎯 Problem It Solves

**Before Pattern:**
```java
// Bad: Creating objects with if-else statements
public ReportGenerator createReport(String type) {
    if (type.equals("revenue")) {
        return new RevenueReportGenerator(paymentRepo);
    } else if (type.equals("fleet")) {
        return new FleetReportGenerator(bookingRepo);
    } else if (type.equals("customer")) {
        return new CustomerReportGenerator(bookingRepo);
    }
    // Hard to add new report types!
}
```

**After Pattern:**
```java
// Good: Factory pattern - Centralized object creation
ReportGenerator generator = reportFactory.createReportGenerator("revenue");
Map<String, Object> report = generator.generateReport(from, to);
```

### 🏗️ Implementation Structure

```
report/factory/
├── ReportGenerator.java           (Product Interface)
├── RevenueReportGenerator.java    (Concrete Product)
├── FleetReportGenerator.java      (Concrete Product)
├── CustomerReportGenerator.java   (Concrete Product)
└── ReportFactory.java             (Factory Class)
```

### 📐 UML Diagram

```
┌─────────────────────────┐
│   <<interface>>         │
│   ReportGenerator       │
├─────────────────────────┤
│ + generateReport()      │
│ + getReportType()       │
│ + getReportDescription()│
└──────────△──────────────┘
           │
           │ implements
     ┌─────┴──────┬──────────────┐
     │            │              │
┌────▼─────┐ ┌───▼────┐ ┌───────▼────┐
│ Revenue  │ │ Fleet  │ │  Customer  │
│  Report  │ │ Report │ │   Report   │
│Generator │ │Generator│ │ Generator  │
└──────────┘ └────────┘ └────────────┘
     △
     │ creates
     │
┌────┴─────────────┐
│  ReportFactory   │
├──────────────────┤
│- generators: Map │
├──────────────────┤
│+ createReport()  │
│+ getAvailable()  │
└──────────────────┘
```

### 💻 Code Example

#### 1. Product Interface
```java
public interface ReportGenerator {
    Map<String, Object> generateReport(String fromDate, String toDate);
    String getReportType();
    String getReportDescription();
}
```

#### 2. Concrete Product (Revenue Report)
```java
@Component
public class RevenueReportGenerator implements ReportGenerator {
    private final PaymentRepository paymentRepository;
    
    @Override
    public Map<String, Object> generateReport(String from, String to) {
        Map<String, Object> data = new HashMap<>();
        
        // Generate revenue report logic
        List<Payment> payments = paymentRepository.findAll();
        // Process data...
        
        data.put("labels", labels);
        data.put("values", values);
        data.put("totalRevenue", totalRevenue);
        
        return data;
    }
    
    @Override
    public String getReportType() {
        return "Revenue";
    }
}
```

#### 3. Factory Class
```java
@Component
public class ReportFactory {
    private final Map<String, ReportGenerator> generators;
    
    public ReportFactory(RevenueReportGenerator revenueGen,
                        FleetReportGenerator fleetGen,
                        CustomerReportGenerator customerGen) {
        generators = new HashMap<>();
        generators.put("revenue", revenueGen);
        generators.put("fleet", fleetGen);
        generators.put("customers", customerGen);
    }
    
    public ReportGenerator createReportGenerator(String type) {
        ReportGenerator generator = generators.get(type.toLowerCase());
        
        if (generator == null) {
            throw new IllegalArgumentException("Unknown report type: " + type);
        }
        
        return generator;
    }
}
```

#### 4. Usage Example
```java
@Service
public class ReportServiceWithFactory {
    private final ReportFactory factory;
    
    public Map<String, Object> generate(String type, String from, String to) {
        // Factory creates appropriate generator
        ReportGenerator generator = factory.createReportGenerator(type);
        
        // Generate report
        return generator.generateReport(from, to);
    }
}
```

### ✅ Benefits

1. **Loose Coupling:** Client code doesn't depend on concrete classes
2. **Single Responsibility:** Object creation logic in one place
3. **Easy Extension:** Add new report types by creating new classes
4. **Encapsulation:** Creation logic is hidden from clients
5. **Maintainability:** Changes to creation logic don't affect clients

### 📍 Location in Project

- **Package:** `com.drivego.report.factory`
- **Files:**
  - `ReportGenerator.java` - Interface
  - `ReportFactory.java` - Factory
  - `RevenueReportGenerator.java` - Concrete product
  - `FleetReportGenerator.java` - Concrete product
  - `CustomerReportGenerator.java` - Concrete product
  - `ReportServiceWithFactory.java` - Service using pattern

---

## Benefits and Use Cases

### Strategy Pattern Use Cases in DriveGo

✅ **Payment Processing**
- Credit Card payments
- Bank Transfer payments
- Cash payments
- Easy to add: Digital Wallet, Cryptocurrency, etc.

✅ **Future Extensions:**
- Discount calculation strategies
- Pricing strategies (hourly, daily, weekly)
- Notification strategies (email, SMS, push)

### Factory Pattern Use Cases in DriveGo

✅ **Report Generation**
- Revenue reports
- Fleet usage reports
- Customer booking reports
- Easy to add: Maintenance reports, Analytics reports, etc.

✅ **Future Extensions:**
- Vehicle factory (create different vehicle types)
- Notification factory (create different notification types)
- Document generator factory (invoices, receipts, contracts)

---

## How to Test the Patterns

### Testing Strategy Pattern

```java
// Test different payment strategies
@Test
public void testCreditCardPayment() {
    PaymentContext context = new PaymentContext();
    context.setPaymentStrategy(new CreditCardPaymentStrategy());
    
    PaymentResult result = context.executePayment(5000.0, "1234567812345678");
    
    assertTrue(result.isSuccess());
    assertEquals("Credit Card", result.getPaymentMethod());
}

@Test
public void testBankTransferPayment() {
    PaymentContext context = new PaymentContext();
    context.setPaymentStrategy(new BankTransferPaymentStrategy());
    
    PaymentResult result = context.executePayment(10000.0, "1234567890");
    
    assertTrue(result.isSuccess());
    assertEquals("Bank Transfer", result.getPaymentMethod());
}
```

### Testing Factory Pattern

```java
// Test report factory
@Test
public void testRevenueReportCreation() {
    ReportGenerator generator = reportFactory.createReportGenerator("revenue");
    
    assertNotNull(generator);
    assertEquals("Revenue", generator.getReportType());
}

@Test
public void testReportGeneration() {
    ReportGenerator generator = reportFactory.createReportGenerator("fleet");
    Map<String, Object> report = generator.generateReport("2024-01-01", "2024-12-31");
    
    assertNotNull(report);
    assertTrue(report.containsKey("labels"));
    assertTrue(report.containsKey("values"));
}

@Test
public void testInvalidReportType() {
    assertThrows(IllegalArgumentException.class, () -> {
        reportFactory.createReportGenerator("invalid");
    });
}
```

---

## Evaluation Criteria Compliance

### ✅ Pattern 1: Strategy Pattern
- **Implementation:** ✓ Fully implemented with 3 concrete strategies
- **Documentation:** ✓ Comprehensive comments and JavaDoc
- **Correct Usage:** ✓ Used in PaymentProcessingService
- **Benefits:** ✓ Eliminates conditionals, easy to extend
- **Real Application:** ✓ Handles actual payment processing logic

### ✅ Pattern 2: Factory Pattern
- **Implementation:** ✓ Fully implemented with 3 concrete products
- **Documentation:** ✓ Comprehensive comments and JavaDoc
- **Correct Usage:** ✓ Used in ReportServiceWithFactory
- **Benefits:** ✓ Encapsulates object creation, loose coupling
- **Real Application:** ✓ Generates actual reports from database

---

## Summary

The DriveGo application successfully implements **2 design patterns**:

1. **Strategy Pattern** - Makes payment processing flexible and extensible
2. **Factory Pattern** - Simplifies report generation and object creation

Both patterns:
- Follow SOLID principles
- Are properly documented
- Demonstrate real-world usage
- Can be easily extended with new functionality
- Improve code maintainability and testability

**Location:** All pattern implementations are in:
- `src/main/java/com/drivego/payment/strategy/` (Strategy Pattern)
- `src/main/java/com/drivego/report/factory/` (Factory Pattern)
