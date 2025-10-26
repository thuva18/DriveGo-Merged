package com.drivego.report.factory;

import com.drivego.payment.Payment;
import com.drivego.payment.PaymentRepository;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * FACTORY PATTERN - Concrete Product Implementation
 * 
 * Concrete implementation for Revenue Report Generation
 * 
 * Generates reports showing payment revenue over time
 */
@Component
public class RevenueReportGenerator implements ReportGenerator {
    
    private final PaymentRepository paymentRepository;
    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    public RevenueReportGenerator(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }
    
    @Override
    public Map<String, Object> generateReport(String fromDate, String toDate) {
        Map<String, Object> reportData = new HashMap<>();
        
        try {
            List<Payment> payments = paymentRepository.findAll();
            LocalDate startDate = LocalDate.parse(fromDate, formatter);
            LocalDate endDate = LocalDate.parse(toDate, formatter);
            
            // Group payments by date and sum amounts
            Map<LocalDate, Double> dailyRevenue = new TreeMap<>();
            double totalRevenue = 0.0;
            int completedPayments = 0;
            
            for (Payment payment : payments) {
                if (payment.getPaymentDate() != null && 
                    "COMPLETED".equals(payment.getPaymentStatus())) {
                    
                    LocalDate paymentDate = payment.getPaymentDate().toLocalDate();
                    
                    if (!paymentDate.isBefore(startDate) && !paymentDate.isAfter(endDate)) {
                        double amount = payment.getAmount().doubleValue();
                        dailyRevenue.merge(paymentDate, amount, Double::sum);
                        totalRevenue += amount;
                        completedPayments++;
                    }
                }
            }
            
            // Prepare chart data
            List<String> labels = new ArrayList<>();
            List<Double> values = new ArrayList<>();
            
            for (Map.Entry<LocalDate, Double> entry : dailyRevenue.entrySet()) {
                labels.add(entry.getKey().format(formatter));
                values.add(entry.getValue());
            }
            
            // Build report data
            reportData.put("labels", labels);
            reportData.put("values", values);
            reportData.put("chartTitle", "Revenue Report");
            reportData.put("chartLabel", "Daily Revenue (LKR)");
            reportData.put("totalRevenue", totalRevenue);
            reportData.put("completedPayments", completedPayments);
            reportData.put("averageRevenue", completedPayments > 0 ? totalRevenue / completedPayments : 0.0);
            reportData.put("reportType", getReportType());
            reportData.put("fromDate", fromDate);
            reportData.put("toDate", toDate);
            
            System.out.println("Revenue Report Generated: LKR " + String.format("%.2f", totalRevenue) + 
                             " from " + completedPayments + " payments");
            
        } catch (Exception e) {
            reportData.put("error", "Failed to generate revenue report: " + e.getMessage());
        }
        
        return reportData;
    }
    
    @Override
    public String getReportType() {
        return "Revenue";
    }
    
    @Override
    public String getReportDescription() {
        return "Shows total revenue from completed payments over time";
    }
}
