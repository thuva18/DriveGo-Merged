package com.drivego.demo;

import com.drivego.payment.PaymentProcessingService;
import com.drivego.payment.strategy.PaymentResult;
import com.drivego.report.ReportServiceWithFactory;
import com.drivego.report.factory.ReportFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

/**
 * Design Patterns Demonstration Controller
 * 
 * This controller demonstrates the usage of both design patterns:
 * 1. Strategy Pattern - Payment Processing
 * 2. Factory Pattern - Report Generation
 * 
 * Access URLs:
 * - http://localhost:8080/design-patterns/demo
 * - http://localhost:8080/design-patterns/test-payment?method=credit-card&amount=5000
 * - http://localhost:8080/design-patterns/test-report?type=revenue
 */
@Controller
@RequestMapping("/design-patterns")
public class DesignPatternsDemo {
    
    private final PaymentProcessingService paymentService;
    private final ReportServiceWithFactory reportService;
    private final ReportFactory reportFactory;
    
    public DesignPatternsDemo(PaymentProcessingService paymentService,
                             ReportServiceWithFactory reportService,
                             ReportFactory reportFactory) {
        this.paymentService = paymentService;
        this.reportService = reportService;
        this.reportFactory = reportFactory;
    }
    
    /**
     * Main demo page showing available pattern demonstrations
     */
    @GetMapping("/demo")
    public String demoPage(Model model) {
        model.addAttribute("title", "Design Patterns Demo");
        model.addAttribute("patterns", Map.of(
            "Strategy Pattern", "Payment Processing with different methods",
            "Factory Pattern", "Report Generation with different types"
        ));
        return "design_patterns_demo";
    }
    
    /**
     * Test Strategy Pattern - Payment Processing
     * 
     * Examples:
     * - /design-patterns/test-payment?method=credit-card&amount=5000&details=1234567812345678
     * - /design-patterns/test-payment?method=bank-transfer&amount=10000&details=1234567890
     * - /design-patterns/test-payment?method=cash&amount=2000
     */
    @GetMapping("/test-payment")
    @ResponseBody
    public Map<String, Object> testPaymentStrategy(
            @RequestParam String method,
            @RequestParam double amount,
            @RequestParam(required = false, defaultValue = "") String details) {
        
        Map<String, Object> response = new HashMap<>();
        response.put("pattern", "Strategy Pattern");
        response.put("demonstration", "Payment Processing");
        
        try {
            // Use payment details based on method
            String paymentDetails = details.isEmpty() ? getDefaultPaymentDetails(method) : details;
            
            // Strategy Pattern in action!
            PaymentResult result = paymentService.processPayment(method, amount, paymentDetails);
            
            response.put("success", result.isSuccess());
            response.put("paymentMethod", result.getPaymentMethod());
            response.put("transactionId", result.getTransactionId());
            response.put("message", result.getMessage());
            response.put("amount", amount);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        
        return response;
    }
    
    /**
     * Test Factory Pattern - Report Generation
     * 
     * Examples:
     * - /design-patterns/test-report?type=revenue
     * - /design-patterns/test-report?type=fleet
     * - /design-patterns/test-report?type=customers
     */
    @GetMapping("/test-report")
    @ResponseBody
    public Map<String, Object> testReportFactory(
            @RequestParam String type,
            @RequestParam(required = false) String from,
            @RequestParam(required = false) String to) {
        
        Map<String, Object> response = new HashMap<>();
        response.put("pattern", "Factory Pattern");
        response.put("demonstration", "Report Generation");
        
        try {
            // Default date range if not provided
            if (from == null) from = LocalDate.now().minusMonths(1).toString();
            if (to == null) to = LocalDate.now().toString();
            
            // Factory Pattern in action!
            Map<String, Object> reportData = reportService.generate(type, from, to);
            
            response.put("success", true);
            response.put("reportType", type);
            response.put("dateRange", Map.of("from", from, "to", to));
            response.put("reportData", reportData);
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            response.put("availableTypes", reportService.getAvailableReportTypes());
        }
        
        return response;
    }
    
    /**
     * Get information about all available patterns
     */
    @GetMapping("/info")
    @ResponseBody
    public Map<String, Object> getPatternsInfo() {
        Map<String, Object> info = new HashMap<>();
        
        // Strategy Pattern info
        Map<String, String> strategyInfo = new HashMap<>();
        strategyInfo.put("type", "Behavioral Design Pattern");
        strategyInfo.put("purpose", "Defines a family of algorithms, encapsulates each one, and makes them interchangeable");
        strategyInfo.put("implementation", "Payment Processing with Credit Card, Bank Transfer, and Cash strategies");
        strategyInfo.put("location", "com.drivego.payment.strategy");
        strategyInfo.put("testUrl", "/design-patterns/test-payment?method=credit-card&amount=5000");
        
        // Factory Pattern info
        Map<String, String> factoryInfo = new HashMap<>();
        factoryInfo.put("type", "Creational Design Pattern");
        factoryInfo.put("purpose", "Defines an interface for creating objects, letting subclasses decide which class to instantiate");
        factoryInfo.put("implementation", "Report Generation with Revenue, Fleet, and Customer report generators");
        factoryInfo.put("location", "com.drivego.report.factory");
        factoryInfo.put("testUrl", "/design-patterns/test-report?type=revenue");
        factoryInfo.put("availableReportTypes", reportService.getAvailableReportTypes().toString());
        
        info.put("Strategy Pattern", strategyInfo);
        info.put("Factory Pattern", factoryInfo);
        info.put("documentation", "See DESIGN_PATTERNS.md in project root for detailed documentation");
        
        return info;
    }
    
    /**
     * Helper method to provide default payment details for testing
     */
    private String getDefaultPaymentDetails(String method) {
        return switch (method.toLowerCase()) {
            case "credit-card", "creditcard", "card" -> "1234567812345678"; // Test card number
            case "bank-transfer", "banktransfer", "bank" -> "1234567890"; // Test account number
            case "cash" -> "Test cash payment"; // Optional notes
            default -> "";
        };
    }
}
