package com.drivego.report;

import com.drivego.report.factory.ReportFactory;
import com.drivego.report.factory.ReportGenerator;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * ReportService - Updated to use Factory Pattern
 * 
 * This service demonstrates the use of the Factory Pattern to generate reports
 * Instead of having multiple if-else statements, it uses the ReportFactory
 * to create appropriate report generators dynamically.
 */
@Service
public class ReportServiceWithFactory {
    
    private final ReportFactory reportFactory;
    
    public ReportServiceWithFactory(ReportFactory reportFactory) {
        this.reportFactory = reportFactory;
    }
    
    /**
     * Generate report using Factory Pattern
     * 
     * This method demonstrates how the Factory Pattern simplifies report generation:
     * - No need for multiple if-else statements
     * - Easy to add new report types
     * - Cleaner, more maintainable code
     * 
     * @param type Report type ("revenue", "fleet", "customers")
     * @param from Start date (yyyy-MM-dd)
     * @param to End date (yyyy-MM-dd)
     * @return Report data map
     */
    public Map<String, Object> generate(String type, String from, String to) {
        try {
            // Factory Pattern in action: Create appropriate report generator
            ReportGenerator generator = reportFactory.createReportGenerator(type);
            
            // Generate report using the factory-created generator
            Map<String, Object> reportData = generator.generateReport(from, to);
            
            // Add common metadata
            reportData.putIfAbsent("chartTitle", generator.getReportType() + " Report");
            reportData.putIfAbsent("description", generator.getReportDescription());
            
            return reportData;
            
        } catch (IllegalArgumentException e) {
            // Handle unsupported report type
            Map<String, Object> errorMap = new HashMap<>();
            errorMap.put("error", e.getMessage());
            errorMap.put("availableTypes", reportFactory.getAvailableReportTypes().keySet());
            return errorMap;
        }
    }
    
    /**
     * Get available report types
     * 
     * @return Map of available report type keys and descriptions
     */
    public Map<String, String> getAvailableReportTypes() {
        Map<String, String> types = new HashMap<>();
        reportFactory.getAvailableReportTypes().forEach((key, generator) -> 
            types.put(key, generator.getReportDescription())
        );
        return types;
    }
}
