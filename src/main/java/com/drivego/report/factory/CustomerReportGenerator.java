package com.drivego.report.factory;

import com.drivego.booking.CarBookingModel;
import com.drivego.booking.CarBookingRepository;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * FACTORY PATTERN - Concrete Product Implementation
 * 
 * Concrete implementation for Customer Bookings Report Generation
 * 
 * Generates reports showing customer booking patterns and statistics
 */
@Component
public class CustomerReportGenerator implements ReportGenerator {
    
    private final CarBookingRepository bookingRepository;
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    public CustomerReportGenerator(CarBookingRepository bookingRepository) {
        this.bookingRepository = bookingRepository;
    }
    
    @Override
    public Map<String, Object> generateReport(String fromDate, String toDate) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            List<CarBookingModel> bookings = bookingRepository.findAll();
            LocalDate startDate = LocalDate.parse(fromDate, formatter);
            LocalDate endDate = LocalDate.parse(toDate, formatter);
            
            // Group bookings by customer
            Map<String, Integer> customerBookingCount = new HashMap<>();
            int totalBookings = 0;
            
            for (CarBookingModel booking : bookings) {
                if (booking.getBookingDate() != null && !booking.isDeleteStatus()) {
                    // Convert Date to LocalDate for comparison
                    LocalDate bookingDate = new java.sql.Date(booking.getBookingDate().getTime()).toLocalDate();
                    
                    if (!bookingDate.isBefore(startDate) && !bookingDate.isAfter(endDate)) {
                        String customerName = booking.getContactPersonName() != null ? booking.getContactPersonName() : "Unknown Customer";
                        customerBookingCount.merge(customerName, 1, Integer::sum);
                        totalBookings++;
                    }
                }
            }
            
            // Sort by booking count (descending)
            List<Map.Entry<String, Integer>> sortedEntries = new ArrayList<>(customerBookingCount.entrySet());
            sortedEntries.sort((e1, e2) -> e2.getValue().compareTo(e1.getValue()));
            
            // Prepare chart data (top 10 customers)
            List<String> labels = new ArrayList<>();
            List<Double> values = new ArrayList<>();
            
            int count = 0;
            for (Map.Entry<String, Integer> entry : sortedEntries) {
                if (count >= 10) break;
                labels.add(entry.getKey());
                values.add(entry.getValue().doubleValue());
                count++;
            }
            
            // Build report data
            reportData.put("labels", labels);
            reportData.put("values", values);
            reportData.put("chartTitle", "Customer Bookings Report");
            reportData.put("chartLabel", "Number of Bookings");
            reportData.put("totalBookings", totalBookings);
            reportData.put("totalCustomers", customerBookingCount.size());
            reportData.put("averageBookingsPerCustomer", 
                customerBookingCount.size() > 0 ? (double) totalBookings / customerBookingCount.size() : 0.0);
            reportData.put("reportType", getReportType());
            reportData.put("fromDate", fromDate);
            reportData.put("toDate", toDate);
            
            System.out.println("Customer Report Generated: " + totalBookings + 
                             " bookings from " + customerBookingCount.size() + " customers");
            
        } catch (Exception e) {
            reportData.put("error", "Failed to generate customer report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    @Override
    public String getReportType() {
        return "Customer";
    }
    
    @Override
    public String getReportDescription() {
        return "Shows customer booking patterns and top customers by booking frequency";
    }
}
