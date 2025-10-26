# Design Patterns Visual Overview

## 1. Strategy Pattern - Payment Processing

### Class Diagram
```
┌─────────────────────────────────────────────────────────┐
│                    <<interface>>                        │
│                  PaymentStrategy                        │
├─────────────────────────────────────────────────────────┤
│  + processPayment(amount, details): PaymentResult      │
│  + getPaymentMethodName(): String                      │
│  + validatePaymentDetails(details): boolean            │
└─────────────────────────────────────────────────────────┘
                          △
                          │ implements
                          │
       ┌──────────────────┼──────────────────┐
       │                  │                  │
┌──────▼────────┐  ┌──────▼────────┐  ┌─────▼─────────┐
│   Credit Card │  │ Bank Transfer │  │     Cash      │
│   Strategy    │  │   Strategy    │  │   Strategy    │
├───────────────┤  ├───────────────┤  ├───────────────┤
│ - CARD_PATTERN│  │- ACCOUNT_     │  │ (No specific  │
│               │  │  PATTERN      │  │  validation)  │
├───────────────┤  ├───────────────┤  ├───────────────┤
│+ process()    │  │+ process()    │  │+ process()    │
│+ validate()   │  │+ validate()   │  │+ validate()   │
└───────────────┘  └───────────────┘  └───────────────┘
       │                  │                  │
       └──────────────────┼──────────────────┘
                          │ used by
                          ▼
               ┌──────────────────┐
               │ PaymentContext   │
               ├──────────────────┤
               │ - strategy       │
               ├──────────────────┤
               │ + setStrategy()  │
               │ + executePayment()│
               └──────────────────┘
                          │
                          │ used by
                          ▼
         ┌────────────────────────────────┐
         │  PaymentProcessingService      │
         ├────────────────────────────────┤
         │ - paymentContext               │
         │ - creditCardStrategy           │
         │ - bankTransferStrategy         │
         │ - cashStrategy                 │
         ├────────────────────────────────┤
         │ + processPayment(method, ...)  │
         │ + validatePaymentDetails(...)  │
         └────────────────────────────────┘
```

### Flow Diagram
```
┌─────────┐
│ Client  │
└────┬────┘
     │ 1. Call processPayment("credit-card", 5000, "1234...")
     ▼
┌────────────────────────────┐
│ PaymentProcessingService   │
└────────┬───────────────────┘
         │ 2. Select CreditCardStrategy
         ▼
┌────────────────────────────┐
│    PaymentContext          │
└────────┬───────────────────┘
         │ 3. Set strategy
         │ 4. Execute payment
         ▼
┌────────────────────────────┐
│ CreditCardPaymentStrategy  │
└────────┬───────────────────┘
         │ 5. Validate card
         │ 6. Process payment
         │ 7. Return PaymentResult
         ▼
┌────────────────────────────┐
│      PaymentResult         │
│  - success: true           │
│  - transactionId: CC-XXX   │
│  - message: "Success"      │
└────────────────────────────┘
```

---

## 2. Factory Pattern - Report Generation

### Class Diagram
```
┌─────────────────────────────────────────────────────────┐
│                    <<interface>>                        │
│                  ReportGenerator                        │
├─────────────────────────────────────────────────────────┤
│  + generateReport(from, to): Map<String, Object>       │
│  + getReportType(): String                             │
│  + getReportDescription(): String                      │
└─────────────────────────────────────────────────────────┘
                          △
                          │ implements
                          │
       ┌──────────────────┼──────────────────┐
       │                  │                  │
┌──────▼────────┐  ┌──────▼────────┐  ┌─────▼─────────┐
│    Revenue    │  │     Fleet     │  │   Customer    │
│    Report     │  │    Report     │  │    Report     │
│   Generator   │  │   Generator   │  │   Generator   │
├───────────────┤  ├───────────────┤  ├───────────────┤
│- paymentRepo  │  │- bookingRepo  │  │- bookingRepo  │
├───────────────┤  ├───────────────┤  ├───────────────┤
│+ generate()   │  │+ generate()   │  │+ generate()   │
│+ getType()    │  │+ getType()    │  │+ getType()    │
└───────────────┘  └───────────────┘  └───────────────┘
       △                  △                  △
       │                  │                  │
       └──────────────────┼──────────────────┘
                          │ created by
                          │
               ┌──────────▼─────────┐
               │   ReportFactory    │
               ├────────────────────┤
               │ - generators: Map  │
               ├────────────────────┤
               │ + createReport()   │
               │ + getAvailable()   │
               │ + isSupported()    │
               └────────────────────┘
                          │
                          │ used by
                          ▼
         ┌────────────────────────────────┐
         │  ReportServiceWithFactory      │
         ├────────────────────────────────┤
         │ - reportFactory                │
         ├────────────────────────────────┤
         │ + generate(type, from, to)     │
         │ + getAvailableReportTypes()    │
         └────────────────────────────────┘
```

### Flow Diagram
```
┌─────────┐
│ Client  │
└────┬────┘
     │ 1. Call generate("revenue", "2024-01-01", "2024-12-31")
     ▼
┌────────────────────────────┐
│ ReportServiceWithFactory   │
└────────┬───────────────────┘
         │ 2. Request generator for "revenue"
         ▼
┌────────────────────────────┐
│      ReportFactory         │
│ - generators: {            │
│   "revenue" -> RevenueGen  │
│   "fleet" -> FleetGen      │
│   "customers" -> CustomerGen│
│  }                         │
└────────┬───────────────────┘
         │ 3. Return RevenueReportGenerator
         ▼
┌────────────────────────────┐
│  RevenueReportGenerator    │
└────────┬───────────────────┘
         │ 4. Query database
         │ 5. Process data
         │ 6. Return report Map
         ▼
┌────────────────────────────┐
│      Report Data           │
│  - labels: [dates]         │
│  - values: [revenue]       │
│  - totalRevenue: 125000    │
│  - chartTitle: "Revenue"   │
└────────────────────────────┘
```

---

## Pattern Comparison

### Strategy Pattern vs Factory Pattern

| Aspect | Strategy Pattern | Factory Pattern |
|--------|-----------------|-----------------|
| **Type** | Behavioral | Creational |
| **Purpose** | Define family of algorithms | Create objects |
| **Runtime Behavior** | Algorithm selected at runtime | Object type selected at creation |
| **Flexibility** | Can change strategy dynamically | Creates appropriate object once |
| **Our Use Case** | Payment processing methods | Report type generation |
| **Main Benefit** | Eliminates conditionals | Centralizes object creation |

---

## File Organization

### Strategy Pattern Files
```
src/main/java/com/drivego/
├── payment/
│   ├── strategy/                           ← NEW PACKAGE
│   │   ├── PaymentStrategy.java            ← Interface
│   │   ├── PaymentContext.java             ← Context
│   │   ├── PaymentResult.java              ← Result Object
│   │   ├── CreditCardPaymentStrategy.java  ← Implementation 1
│   │   ├── BankTransferPaymentStrategy.java← Implementation 2
│   │   └── CashPaymentStrategy.java        ← Implementation 3
│   └── PaymentProcessingService.java       ← Service using pattern
```

### Factory Pattern Files
```
src/main/java/com/drivego/
├── report/
│   ├── factory/                            ← NEW PACKAGE
│   │   ├── ReportGenerator.java            ← Interface
│   │   ├── ReportFactory.java              ← Factory
│   │   ├── RevenueReportGenerator.java     ← Product 1
│   │   ├── FleetReportGenerator.java       ← Product 2
│   │   └── CustomerReportGenerator.java    ← Product 3
│   └── ReportServiceWithFactory.java       ← Service using pattern
```

---

## Usage Examples

### Strategy Pattern Example
```java
// Client code
@Autowired
private PaymentProcessingService paymentService;

// Process different payment types without if-else
PaymentResult result1 = paymentService.processPayment(
    "credit-card", 5000.0, "1234567812345678"
);

PaymentResult result2 = paymentService.processPayment(
    "bank-transfer", 10000.0, "1234567890"
);

PaymentResult result3 = paymentService.processPayment(
    "cash", 2000.0, "Walk-in customer"
);

// All use the same method but different strategies internally!
```

### Factory Pattern Example
```java
// Client code
@Autowired
private ReportServiceWithFactory reportService;

// Generate different reports without knowing concrete classes
Map<String, Object> revenueReport = reportService.generate(
    "revenue", "2024-01-01", "2024-12-31"
);

Map<String, Object> fleetReport = reportService.generate(
    "fleet", "2024-01-01", "2024-12-31"
);

Map<String, Object> customerReport = reportService.generate(
    "customers", "2024-01-01", "2024-12-31"
);

// Factory creates appropriate generator for each type!
```

---

## Console Output Examples

### When Application Starts:
```
=== FACTORY PATTERN INITIALIZED ===
Registered Report Types: [fleet, revenue, customers]
====================================
```

### When Payment is Processed:
```
=== STRATEGY PATTERN IN ACTION ===
Selected Payment Method: Credit Card
Processing Credit Card Payment:
  Amount: LKR 5000.00
  Card: **** **** **** 5678
  Transaction ID: CC-A1B2C3D4
Payment Status: SUCCESS
===================================
```

### When Report is Generated:
```
=== FACTORY PATTERN IN ACTION ===
Creating Report Generator: Revenue
Description: Shows total revenue from completed payments over time
==================================

Revenue Report Generated: LKR 125000.00 from 45 payments
```

---

## Benefits Summary

### Strategy Pattern Benefits:
```
Before Pattern:                After Pattern:
─────────────                 ─────────────

if (method == "card") {       context.setStrategy(cardStrategy);
    // 20 lines            →   context.executePayment();
} else if (method == "bank") {
    // 20 lines
} else if (method == "cash") {
    // 20 lines
}

❌ Hard to maintain              ✅ Easy to extend
❌ Hard to test                  ✅ Each strategy tested separately
❌ Violates Open/Closed          ✅ Follows Open/Closed Principle
❌ Complex conditional logic     ✅ Simple delegation
```

### Factory Pattern Benefits:
```
Before Pattern:                After Pattern:
─────────────                 ─────────────

if (type == "revenue") {      generator = factory.create(type);
    return new Revenue...  →  return generator.generate();
} else if (type == "fleet") {
    return new Fleet...
} else if (type == "customer") {
    return new Customer...
}

❌ Client knows concrete classes  ✅ Client uses interface only
❌ Hard to add new types          ✅ Register new type in factory
❌ Creation logic scattered       ✅ Centralized creation logic
❌ Tight coupling                 ✅ Loose coupling
```

---

## Testing URLs

### Pattern Information
```
GET http://localhost:8080/design-patterns/info
```

### Strategy Pattern Tests
```
GET http://localhost:8080/design-patterns/test-payment?method=credit-card&amount=5000
GET http://localhost:8080/design-patterns/test-payment?method=bank-transfer&amount=10000
GET http://localhost:8080/design-patterns/test-payment?method=cash&amount=2000
```

### Factory Pattern Tests
```
GET http://localhost:8080/design-patterns/test-report?type=revenue
GET http://localhost:8080/design-patterns/test-report?type=fleet
GET http://localhost:8080/design-patterns/test-report?type=customers
```

---

## Summary

✅ **2 Patterns Implemented**
- Strategy Pattern (Behavioral) - Payment Processing
- Factory Pattern (Creational) - Report Generation

✅ **15 Files Created**
- 6 Strategy Pattern classes
- 5 Factory Pattern classes
- 2 Service implementations
- 1 Demo controller
- 1 Documentation set

✅ **Professional Quality**
- Comprehensive JavaDoc
- UML diagrams
- Working demonstrations
- Production-ready code

---

**For Full Documentation, See:**
- `DESIGN_PATTERNS.md` - Complete technical documentation
- `DESIGN_PATTERNS_README.md` - Quick start guide
- `DESIGN_PATTERNS_SUMMARY.md` - Evaluation checklist
- `DESIGN_PATTERNS_DIAGRAMS.md` - This visual overview
