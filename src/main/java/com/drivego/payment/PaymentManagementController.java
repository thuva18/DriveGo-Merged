package com.drivego.payment;

import com.drivego.booking.CarBookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/payments")
public class PaymentManagementController {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private CarBookingRepository carBookingRepository;
    
    @Autowired
    private PaymentMethodRepository paymentMethodRepository;

    // List all payments with filtering and pagination
    @GetMapping
    public String listPayments(Model model,
                             @RequestParam(defaultValue = "0") int page,
                             @RequestParam(defaultValue = "10") int size,
                             @RequestParam(required = false) Long bookingId,
                             @RequestParam(required = false) String status,
                             @RequestParam(required = false) String fromDate,
                             @RequestParam(required = false) String toDate) {
        
        // Get all payments and do manual pagination
        List<Payment> allPayments = paymentRepository.findAll();
        
        // Filter if needed
        if (bookingId != null) {
            allPayments = allPayments.stream()
                .filter(p -> p.getBookingId() != null && p.getBookingId().equals(bookingId))
                .collect(Collectors.toList());
        }
        if (status != null && !status.isEmpty()) {
            allPayments = allPayments.stream()
                .filter(p -> status.equals(p.getPaymentStatus()))
                .collect(Collectors.toList());
        }
        
        // Calculate stats
        BigDecimal totalRevenue = allPayments.stream()
            .filter(p -> "COMPLETED".equals(p.getPaymentStatus()))
            .map(Payment::getAmount)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        long completedCount = allPayments.stream().filter(p -> "COMPLETED".equals(p.getPaymentStatus())).count();
        long pendingCount = allPayments.stream().filter(p -> "PENDING".equals(p.getPaymentStatus())).count();
        long failedCount = allPayments.stream().filter(p -> "FAILED".equals(p.getPaymentStatus())).count();
        
        // Manual pagination
        int start = page * size;
        int end = Math.min(start + size, allPayments.size());
        List<Payment> pagedPayments = start < allPayments.size() ? allPayments.subList(start, end) : List.of();
        int totalPages = (int) Math.ceil((double) allPayments.size() / size);
        
        model.addAttribute("payments", pagedPayments);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("completedCount", completedCount);
        model.addAttribute("pendingCount", pendingCount);
        model.addAttribute("failedCount", failedCount);
        
        return "payment_management/list";
    }

    // View payment details
    @GetMapping("/{id}")
    public String viewPayment(@PathVariable Integer id, Model model, RedirectAttributes redirectAttributes) {
        Payment payment = paymentRepository.findById(id).orElse(null);
        
        if (payment == null) {
            redirectAttributes.addFlashAttribute("error", "Payment not found");
            return "redirect:/admin/payments";
        }
        
        model.addAttribute("payment", payment);
        
        // Get booking details if available
        if (payment.getBookingId() != null) {
            carBookingRepository.findById(payment.getBookingId().longValue())
                .ifPresent(booking -> model.addAttribute("booking", booking));
        }
        
        return "payment_management/view";
    }

    // Show create payment form
    @GetMapping("/new")
    public String newPaymentForm(Model model) {
        model.addAttribute("payment", new Payment(null, "CASH", BigDecimal.ZERO));
        model.addAttribute("bookings", carBookingRepository.findByDeleteStatusFalse());
        return "payment_management/form";
    }

    // Create new payment
    @PostMapping("/create")
    public String createPayment(@RequestParam Long bookingId,
                              @RequestParam String paymentMethod,
                              @RequestParam BigDecimal amount,
                              RedirectAttributes redirectAttributes) {
        try {
            Payment payment = new Payment(bookingId, paymentMethod, amount);
            payment.setPaymentStatus("PENDING");
            paymentRepository.save(payment);
            redirectAttributes.addFlashAttribute("success", "Payment recorded successfully");
            return "redirect:/admin/payments";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error creating payment: " + e.getMessage());
            return "redirect:/admin/payments/new";
        }
    }

    // Mark payment as completed
    @PostMapping("/{id}/complete")
    public String completePayment(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            Payment payment = paymentRepository.findById(id).orElse(null);
            if (payment == null) {
                redirectAttributes.addFlashAttribute("error", "Payment not found");
                return "redirect:/admin/payments";
            }
            
            payment.setPaymentStatus("COMPLETED");
            paymentRepository.save(payment);
            redirectAttributes.addFlashAttribute("success", "Payment marked as completed");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating payment: " + e.getMessage());
        }
        
        return "redirect:/admin/payments";
    }

    // Update payment status
    @PostMapping("/{id}/status")
    public String updatePaymentStatus(@PathVariable Integer id,
                                    @RequestParam String status,
                                    RedirectAttributes redirectAttributes) {
        try {
            Payment payment = paymentRepository.findById(id).orElse(null);
            if (payment == null) {
                redirectAttributes.addFlashAttribute("error", "Payment not found");
                return "redirect:/admin/payments";
            }
            
            payment.setPaymentStatus(status);
            paymentRepository.save(payment);
            redirectAttributes.addFlashAttribute("success", "Payment status updated successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating payment status: " + e.getMessage());
        }
        
        return "redirect:/admin/payments/" + id;
    }
}
