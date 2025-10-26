package com.drivego.report.factory;

import java.util.Map;

/**
 * DESIGN PATTERN: FACTORY PATTERN
 * 
 * Product Interface for different report types
 * 
 * Pattern Purpose:
 * - Defines a common interface for all report generators
 * - Allows creation of different report types without specifying exact classes
 * - Encapsulates report generation logic
 * 
 * Benefits:
 * - Easy to add new report types without modifying existing code
 * - Centralizes report creation logic
 * - Follows Single Responsibility Principle
 */
public interface ReportGenerator {
    
    /**
     * Generate report data based on date range
     * 
     * @param fromDate Start date in format yyyy-MM-dd
     * @param toDate End date in format yyyy-MM-dd
     * @return Map containing report data (labels, values, chartTitle, etc.)
     */
    Map<String, Object> generateReport(String fromDate, String toDate);
    
    /**
     * Get report type name
     * 
     * @return Type of report (e.g., "Revenue", "Fleet", "Customer")
     */
    String getReportType();
    
    /**
     * Get report description
     * 
     * @return Description of what this report shows
     */
    String getReportDescription();
}
