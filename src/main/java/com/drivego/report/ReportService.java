package com.drivego.report;

import com.drivego.booking.CarBookingRepository;
import com.drivego.payment.Payment;
import com.drivego.payment.PaymentRepository;
import com.drivego.vehicle.VehicleRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Service
public class ReportService {

    private final PaymentRepository paymentRepository;
    private final CarBookingRepository bookingRepository;
    private final VehicleRepository vehicleRepository;

    public ReportService(PaymentRepository paymentRepository,
                        CarBookingRepository bookingRepository,
                        VehicleRepository vehicleRepository) {
        this.paymentRepository = paymentRepository;
        this.bookingRepository = bookingRepository;
        this.vehicleRepository = vehicleRepository;
    }

    public Map<String,Object> generate(String type, String from, String to) {
        Map<String,Object> m = new HashMap<>();
        if ("fleet".equalsIgnoreCase(type)) {
            var r = fleet(from, to);
            m.putAll(r);
            m.put("chartTitle", "Fleet Usage Report");
        } else if ("customers".equalsIgnoreCase(type)) {
            var r = customers(from, to);
            m.putAll(r);
            m.put("chartTitle", "Customer Bookings Report");
        } else {
            var r = revenue(from, to);
            m.putAll(r);
            m.put("chartTitle", "Revenue Report");
        }
        return m;
    }

    private Map<String,Object> revenue(String from, String to){
        try {
            var payments = paymentRepository.findAll();
            var formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(from, formatter);
            LocalDate endDate   = LocalDate.parse(to, formatter);
            
            Map<String, Double> daily = new TreeMap<>();
            for (Payment p : payments) {
                if (p.getPaymentDate() != null && "COMPLETED".equals(p.getPaymentStatus())) {
                    LocalDate pd = p.getPaymentDate().toLocalDate();
                    if (!pd.isBefore(startDate) && !pd.isAfter(endDate)) {
                        String key = pd.format(formatter);
                        double amt = p.getAmount().doubleValue();
                        daily.merge(key, amt, Double::sum);
                    }
                }
            }
            
            List<String> labels = new ArrayList<>(daily.keySet());
            List<Double> values = new ArrayList<>(daily.values());
            
            Map<String,Object> result = new HashMap<>();
            result.put("labels", labels);
            result.put("values", values);
            result.put("chartLabel", "Revenue (LKR)");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            Map<String,Object> err = new HashMap<>();
            err.put("labels", List.of());
            err.put("values", List.of());
            err.put("error", e.getMessage());
            return err;
        }
    }

    private Map<String,Object> fleet(String from, String to){
        try {
            var bookings = bookingRepository.findAll();
            var formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(from, formatter);
            LocalDate endDate   = LocalDate.parse(to, formatter);
            
            Map<String, Integer> counts = new HashMap<>();
            for (var b : bookings) {
                if (b.getBookingDate() != null && !b.isDeleteStatus()) {
                    LocalDate bd = new java.sql.Date(b.getBookingDate().getTime()).toLocalDate();
                    if (!bd.isBefore(startDate) && !bd.isAfter(endDate)) {
                        String reg = b.getVehicleRegNo() != null ? b.getVehicleRegNo() : "Unknown";
                        counts.merge(reg, 1, Integer::sum);
                    }
                }
            }
            
            List<String> labels = new ArrayList<>(counts.keySet());
            List<Double> values = new ArrayList<>();
            for (Integer val : counts.values()) {
                values.add(val.doubleValue());
            }
            
            Map<String,Object> result = new HashMap<>();
            result.put("labels", labels);
            result.put("values", values);
            result.put("chartLabel", "Bookings");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            Map<String,Object> err = new HashMap<>();
            err.put("labels", List.of());
            err.put("values", List.of());
            err.put("error", e.getMessage());
            return err;
        }
    }

    private Map<String,Object> customers(String from, String to){
        try {
            var bookings = bookingRepository.findAll();
            var formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate startDate = LocalDate.parse(from, formatter);
            LocalDate endDate   = LocalDate.parse(to, formatter);
            
            Map<String, Integer> counts = new HashMap<>();
            for (var b : bookings) {
                if (b.getBookingDate() != null && !b.isDeleteStatus()) {
                    LocalDate bd = new java.sql.Date(b.getBookingDate().getTime()).toLocalDate();
                    if (!bd.isBefore(startDate) && !bd.isAfter(endDate)) {
                        String name = b.getContactPersonName() != null ? b.getContactPersonName() : "Unknown";
                        counts.merge(name, 1, Integer::sum);
                    }
                }
            }
            
            List<String> labels = new ArrayList<>(counts.keySet());
            List<Double> values = new ArrayList<>();
            for (Integer val : counts.values()) {
                values.add(val.doubleValue());
            }
            
            Map<String,Object> result = new HashMap<>();
            result.put("labels", labels);
            result.put("values", values);
            result.put("chartLabel", "Bookings");
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            Map<String,Object> err = new HashMap<>();
            err.put("labels", List.of());
            err.put("values", List.of());
            err.put("error", e.getMessage());
            return err;
        }
    }
}
