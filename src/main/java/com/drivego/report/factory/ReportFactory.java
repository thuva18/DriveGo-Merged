package com.drivego.report.factory;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * DESIGN PATTERN: FACTORY PATTERN - Factory Class
 * 
 * Factory that creates different types of report generators
 * 
 * This is the Factory class in the Factory Pattern that:
 * - Creates and returns appropriate ReportGenerator instances
 * - Encapsulates object creation logic
 * - Provides a single point of access for creating report generators
 * 
 * Benefits:
 * - Client code doesn't need to know about concrete report generator classes
 * - Easy to add new report types by registering new generators
 * - Promotes loose coupling between client code and report implementations
 * 
 * Usage Example:
 * <pre>
 * ReportFactory factory = new ReportFactory(generators);
 * ReportGenerator generator = factory.createReportGenerator("revenue");
 * Map<String, Object> report = generator.generateReport("2024-01-01", "2024-12-31");
 * </pre>
 */
@Component
public class ReportFactory {
    
    private final Map<String, ReportGenerator> reportGenerators;
    
    /**
     * Constructor that registers all available report generators
     * Spring will automatically inject all ReportGenerator beans
     */
    public ReportFactory(RevenueReportGenerator revenueGenerator,
                        FleetReportGenerator fleetGenerator,
                        CustomerReportGenerator customerGenerator) {
        
        this.reportGenerators = new HashMap<>();
        
        // Register all report generators
        registerReportGenerator("revenue", revenueGenerator);
        registerReportGenerator("fleet", fleetGenerator);
        registerReportGenerator("customers", customerGenerator);
        
        System.out.println("\n=== FACTORY PATTERN INITIALIZED ===");
        System.out.println("Registered Report Types: " + reportGenerators.keySet());
        System.out.println("====================================\n");
    }
    
    /**
     * Register a report generator with a specific type key
     * 
     * @param reportType Type identifier (e.g., "revenue", "fleet", "customers")
     * @param generator ReportGenerator implementation to register
     */
    private void registerReportGenerator(String reportType, ReportGenerator generator) {
        reportGenerators.put(reportType.toLowerCase(), generator);
    }
    
    /**
     * Factory Method: Create and return appropriate report generator
     * 
     * @param reportType Type of report to generate ("revenue", "fleet", "customers")
     * @return ReportGenerator instance for the specified type
     * @throws IllegalArgumentException if report type is not supported
     */
    public ReportGenerator createReportGenerator(String reportType) {
        if (reportType == null || reportType.trim().isEmpty()) {
            throw new IllegalArgumentException("Report type cannot be null or empty");
        }
        
        String normalizedType = reportType.toLowerCase().trim();
        ReportGenerator generator = reportGenerators.get(normalizedType);
        
        if (generator == null) {
            throw new IllegalArgumentException(
                "Unsupported report type: " + reportType + 
                ". Available types: " + reportGenerators.keySet()
            );
        }
        
        System.out.println("\n=== FACTORY PATTERN IN ACTION ===");
        System.out.println("Creating Report Generator: " + generator.getReportType());
        System.out.println("Description: " + generator.getReportDescription());
        System.out.println("==================================\n");
        
        return generator;
    }
    
    /**
     * Get all available report types
     * 
     * @return Map of report type keys and their generators
     */
    public Map<String, ReportGenerator> getAvailableReportTypes() {
        return new HashMap<>(reportGenerators);
    }
    
    /**
     * Check if a report type is supported
     * 
     * @param reportType Type to check
     * @return true if supported, false otherwise
     */
    public boolean isReportTypeSupported(String reportType) {
        return reportType != null && reportGenerators.containsKey(reportType.toLowerCase().trim());
    }
}
