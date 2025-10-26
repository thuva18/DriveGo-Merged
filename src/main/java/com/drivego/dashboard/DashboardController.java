package com.drivego.dashboard;

import com.drivego.booking.CarBookingModel;
import com.drivego.booking.CarBookingRepository;
import com.drivego.payment.Payment;
import com.drivego.payment.PaymentRepository;
import com.drivego.vehicle.VehicleRepository;
import com.drivego.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private CarBookingRepository carBookingRepository;
    
    @Autowired
    private VehicleRepository vehicleRepository;
    
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // Get today's date range
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startOfToday = cal.getTime();
        
        cal.add(Calendar.DAY_OF_MONTH, 1);
        Date endOfToday = cal.getTime();
        
        // Yesterday's date range
        cal.add(Calendar.DAY_OF_MONTH, -2);
        Date startOfYesterday = cal.getTime();
        
        cal.add(Calendar.DAY_OF_MONTH, 1);
        Date endOfYesterday = cal.getTime();

        // Calculate KPIs from real data
        Map<String, Object> kpi = new HashMap<>();
        
        // Revenue Today (simplified - just count payments)
        List<Payment> todayPayments = paymentRepository.findAll();
        BigDecimal revenueToday = todayPayments.stream()
            .filter(p -> "COMPLETED".equals(p.getPaymentStatus()))
            .map(Payment::getAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        NumberFormat formatter = NumberFormat.getInstance(new Locale("en", "LK"));
        kpi.put("revenueToday", "LKR " + formatter.format(revenueToday));
        kpi.put("revenueDelta", "Total Revenue");
        
        // Active Bookings (CONFIRMED + PENDING)
        long confirmedBookings = carBookingRepository.countByStatus("CONFIRMED");
        long pendingBookings = carBookingRepository.countByStatus("PENDING");
        long activeBookings = confirmedBookings + pendingBookings;
        kpi.put("activeBookings", activeBookings);
        
        // New Bookings Today
        List<CarBookingModel> todayBookingsList = carBookingRepository
                .findByBookingDateBetweenAndDeleteStatusFalse(startOfToday, endOfToday);
        kpi.put("newBookingsNote", "+" + todayBookingsList.size() + " new");
        
        // Fleet Availability
        long totalVehicles = vehicleRepository.count();
        long availableVehicles = vehicleRepository.findByAvailabilityTrue().size();
        if (totalVehicles > 0) {
            int pct = (int) ((availableVehicles * 100) / totalVehicles);
            kpi.put("fleetAvailablePct", pct + "%");
            kpi.put("fleetAvailableCount", availableVehicles + " / " + totalVehicles);
        } else {
            kpi.put("fleetAvailablePct", "0%");
            kpi.put("fleetAvailableCount", "0 / 0");
        }
        
        // New Customers (users created in last 24 hours)
        long totalCustomers = userRepository.count();
        kpi.put("newCustomers", totalCustomers);
        kpi.put("newCustomersNote", "Total users");
        
        model.addAttribute("kpi", kpi);

        // Recent activity (real payments and bookings)
        List<Map<String,String>> recent = new ArrayList<>();
        
        // Get recent payments (simplified)
        List<Payment> allPayments = paymentRepository.findAll();
        List<Payment> recentPayments = allPayments.stream()
            .sorted((a, b) -> b.getPaymentDate().compareTo(a.getPaymentDate()))
            .limit(3)
            .collect(Collectors.toList());
        for (Payment payment : recentPayments) {
            Map<String, String> activity = new HashMap<>();
            activity.put("type", "PAYMENT");
            activity.put("title", "LKR " + formatter.format(payment.getAmount()) + " - " + payment.getPaymentStatus());
            activity.put("when", "Recent");
            recent.add(activity);
        }
        
        // Get recent bookings
        List<CarBookingModel> recentBookings = carBookingRepository.findRecentBookings(PageRequest.of(0, 3));
        for (CarBookingModel booking : recentBookings) {
            Map<String, String> activity = new HashMap<>();
            activity.put("type", "BOOKING");
            activity.put("title", "Booking #" + booking.getId() + " - " + booking.getStatus());
            activity.put("when", getTimeAgo(booking.getBookingDate()));
            recent.add(activity);
        }
        
        // Sort by most recent
        recent.sort((a, b) -> {
            String aTime = a.get("when");
            String bTime = b.get("when");
            return aTime.compareTo(bTime);
        });
        
        // Limit to 5 most recent
        if (recent.size() > 5) {
            recent = recent.subList(0, 5);
        }
        
        model.addAttribute("recent", recent);

        // Today's bookings (real data)
        List<Map<String,String>> today = new ArrayList<>();
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        
        for (CarBookingModel booking : todayBookingsList) {
            if (today.size() >= 10) break; // Limit to 10
            
            Map<String, String> bookingMap = new HashMap<>();
            bookingMap.put("code", "BK-" + booking.getId());
            bookingMap.put("customer", booking.getContactPersonName() != null ? booking.getContactPersonName() : "N/A");
            bookingMap.put("vehicle", booking.getVehicleRegNo() != null ? booking.getVehicleRegNo() : "Vehicle #" + booking.getCarId());
            
            String timeRange = "All Day";
            if (booking.getPickupDate() != null && booking.getReturnDate() != null) {
                timeRange = timeFormat.format(booking.getPickupDate()) + " → " + timeFormat.format(booking.getReturnDate());
            }
            bookingMap.put("timeRange", timeRange);
            bookingMap.put("status", booking.getStatus());
            today.add(bookingMap);
        }
        
        model.addAttribute("todayBookings", today);

        // Charts data - Last 7 days
        List<String> labels = new ArrayList<>();
        List<Long> bookingsData = new ArrayList<>();
        List<BigDecimal> revenueData = new ArrayList<>();
        
        SimpleDateFormat dayFormat = new SimpleDateFormat("EEE");
        
        for (int i = 6; i >= 0; i--) {
            Calendar dayCal = Calendar.getInstance();
            dayCal.add(Calendar.DAY_OF_MONTH, -i);
            dayCal.set(Calendar.HOUR_OF_DAY, 0);
            dayCal.set(Calendar.MINUTE, 0);
            dayCal.set(Calendar.SECOND, 0);
            Date dayStart = dayCal.getTime();
            
            dayCal.add(Calendar.DAY_OF_MONTH, 1);
            Date dayEnd = dayCal.getTime();
            
            labels.add("'" + dayFormat.format(dayStart) + "'");
            
            // Count bookings for this day
            List<CarBookingModel> dayBookings = carBookingRepository
                    .findByBookingDateBetweenAndDeleteStatusFalse(dayStart, dayEnd);
            bookingsData.add((long) dayBookings.size());
            
            // Get revenue for this day (simplified - just use 0 for now)
            BigDecimal dayRevenue = BigDecimal.ZERO;
            revenueData.add(dayRevenue);
        }
        
        model.addAttribute("chartBookingsLabelsJson", "[" + String.join(",", labels) + "]");
        model.addAttribute("chartBookingsDataJson", "[" + bookingsData.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]");
        model.addAttribute("chartRevenueLabelsJson", "[" + String.join(",", labels) + "]");
        model.addAttribute("chartRevenueDataJson", "[" + revenueData.stream().map(String::valueOf).collect(Collectors.joining(",")) + "]");

        return "admin-dashboard"; // /WEB-INF/jsp/admin-dashboard.jsp
    }
    
    private String getTimeAgo(Date date) {
        if (date == null) return "Unknown";
        
        long diffInMillis = System.currentTimeMillis() - date.getTime();
        long diffInMinutes = diffInMillis / (60 * 1000);
        long diffInHours = diffInMillis / (60 * 60 * 1000);
        long diffInDays = diffInMillis / (24 * 60 * 60 * 1000);
        
        if (diffInMinutes < 1) {
            return "Just now";
        } else if (diffInMinutes < 60) {
            return diffInMinutes + " min ago";
        } else if (diffInHours < 24) {
            return diffInHours + " hour" + (diffInHours > 1 ? "s" : "") + " ago";
        } else {
            return diffInDays + " day" + (diffInDays > 1 ? "s" : "") + " ago";
        }
    }
}
