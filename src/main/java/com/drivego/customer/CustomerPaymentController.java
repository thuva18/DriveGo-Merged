package com.drivego.customer;

import com.drivego.booking.CarBookingModel;
import com.drivego.booking.CarBookingRepository;
import com.drivego.entity.User;
import com.drivego.payment.Payment;
import com.drivego.payment.PaymentRepository;
import com.drivego.payment.BankTransferReceipt;
import com.drivego.payment.BankTransferReceiptRepository;
import com.drivego.user.UserService;
import com.drivego.vehicle.Vehicle;
import com.drivego.vehicle.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerPaymentController {

    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private BankTransferReceiptRepository bankTransferReceiptRepository;

    @Autowired
    private CarBookingRepository carBookingRepository;

    @Autowired
    private VehicleService vehicleService;

    @Autowired
    private UserService userService;

    // Show payment page for a booking
    @GetMapping("/payment")
    public String showPaymentPage(@RequestParam("bookingId") Long bookingId,
                                 @AuthenticationPrincipal UserDetails userDetails,
                                 Model model,
                                 RedirectAttributes redirectAttributes) {
        
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        // Get booking
        CarBookingModel booking = carBookingRepository.findById(bookingId).orElse(null);
        if (booking == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Booking not found");
            return "redirect:/customer/my-bookings";
        }
        
        // Verify booking belongs to user
        User user = userService.findUserByEmail(userDetails.getUsername());
        if (!booking.getBookedEmail().equals(user.getEmail())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized access");
            return "redirect:/customer/my-bookings";
        }
        
        // Get vehicle details
        Vehicle vehicle = vehicleService.getVehicleByRegNo(booking.getVehicleRegNo()).orElse(null);
        
        // Calculate amount (example: daily rate * days)
        long days = (booking.getReturnDate().getTime() - booking.getPickupDate().getTime()) / (1000 * 60 * 60 * 24);
        if (days < 1) days = 1;
        
        BigDecimal dailyRate = vehicle != null ? 
                             new BigDecimal(vehicle.getDailyRate()) : new BigDecimal("5000");
        BigDecimal totalAmount = dailyRate.multiply(new BigDecimal(days));
        
        model.addAttribute("booking", booking);
        model.addAttribute("vehicle", vehicle);
        model.addAttribute("days", days);
        model.addAttribute("dailyRate", dailyRate);
        model.addAttribute("totalAmount", totalAmount);
        
        return "customer_payment";
    }

    // Process payment
    @PostMapping("/process-payment")
    public String processPayment(@RequestParam("bookingId") Long bookingId,
                                @RequestParam("amount") BigDecimal amount,
                                @RequestParam("paymentMethod") String paymentMethod,
                                @RequestParam(value = "cardNumber", required = false) String cardNumber,
                                @RequestParam(value = "cardholderName", required = false) String cardholderName,
                                @RequestParam(value = "expiryDate", required = false) String expiryDate,
                                @RequestParam(value = "cvv", required = false) String cvv,
                                @RequestParam(value = "saveCard", required = false) Boolean saveCard,
                                @RequestParam(value = "debitCardNumber", required = false) String debitCardNumber,
                                @RequestParam(value = "debitCardholderName", required = false) String debitCardholderName,
                                @RequestParam(value = "debitExpiryDate", required = false) String debitExpiryDate,
                                @RequestParam(value = "debitCvv", required = false) String debitCvv,
                                @RequestParam(value = "saveDebitCard", required = false) Boolean saveDebitCard,
                                @RequestParam(value = "paymentReceipt", required = false) MultipartFile paymentReceipt,
                                @AuthenticationPrincipal UserDetails userDetails,
                                RedirectAttributes redirectAttributes,
                                HttpServletRequest request) {
        
        try {
            if (userDetails == null) {
                return "redirect:/login";
            }
            
            // Get booking
            CarBookingModel booking = carBookingRepository.findById(bookingId).orElse(null);
            if (booking == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Booking not found");
                return "redirect:/customer/my-bookings";
            }
            
            // Verify booking belongs to user
            User user = userService.findUserByEmail(userDetails.getUsername());
            if (!booking.getBookedEmail().equals(user.getEmail())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized access");
                return "redirect:/customer/my-bookings";
            }
            
            // Create payment record
            Payment payment = new Payment(bookingId, paymentMethod, amount);
            payment.setPaymentStatus("COMPLETED");
            
            // Handle payment method specific logic
            switch (paymentMethod) {
                case "CASH":
                    // Cash payment - no additional details needed
                    break;
                    
                case "CREDIT_CARD":
                    if (cardNumber != null && cardholderName != null) {
                        payment.setCardHolder(cardholderName);
                        payment.setCardNumber(cardNumber.replaceAll("\\s", "")); // Store full number (in production, use encryption!)
                        payment.setCardExpiry(expiryDate);
                    }
                    break;
                    
                case "DEBIT_CARD":
                    if (debitCardNumber != null && debitCardholderName != null) {
                        payment.setCardHolder(debitCardholderName);
                        payment.setCardNumber(debitCardNumber.replaceAll("\\s", ""));
                        payment.setCardExpiry(debitExpiryDate);
                    }
                    break;
                    
                case "BANK_TRANSFER":
                    // Handle file upload
                    if (paymentReceipt != null && !paymentReceipt.isEmpty()) {
                        String uploadDir = System.getProperty("user.home") + "/uploads/payment-receipts/";
                        Path uploadPath = Paths.get(uploadDir);
                        if (!Files.exists(uploadPath)) {
                            Files.createDirectories(uploadPath);
                        }
                        
                        String originalFilename = paymentReceipt.getOriginalFilename();
                        if (originalFilename != null && originalFilename.contains(".")) {
                            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
                            String savedFilename = "receipt_" + bookingId + "_" + System.currentTimeMillis() + fileExtension;
                            Path filePath = uploadPath.resolve(savedFilename);
                            
                            Files.copy(paymentReceipt.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                            
                            // Save payment first, then save receipt record
                            Payment savedPayment = paymentRepository.save(payment);
                            
                            // Save receipt record
                            BankTransferReceipt receipt = new BankTransferReceipt(
                                savedPayment.getPaymentId(),
                                savedFilename,
                                filePath.toString(),
                                paymentReceipt.getSize()
                            );
                            bankTransferReceiptRepository.save(receipt);
                        }
                    }
                    break;
            }
            
            // Save payment (if not already saved by bank transfer logic)
            if (payment.getPaymentId() == null) {
                paymentRepository.save(payment);
            }
            
            // Update booking status
            booking.setStatus("CONFIRMED");
            carBookingRepository.save(booking);
            
            // Redirect to payment success page
            redirectAttributes.addFlashAttribute("bookingId", bookingId);
            redirectAttributes.addFlashAttribute("paymentMethod", paymentMethod);
            redirectAttributes.addFlashAttribute("amount", amount);
            return "redirect:/customer/payment-success";
            
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Error processing payment: " + e.getMessage());
            return "redirect:/customer/payment?bookingId=" + bookingId;
        }
    }
    
    // Payment success page
    @GetMapping("/payment-success")
    public String paymentSuccess(Model model) {
        return "customer_payment_success";
    }

    // View customer's payments
    @GetMapping("/my-payments")
    public String myPayments(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        User user = userService.findUserByEmail(userDetails.getUsername());
        
        // Get all bookings for this user
        List<CarBookingModel> bookings = carBookingRepository.findByBookedEmailAndDeleteStatusFalse(user.getEmail());
        
        // Get all payments for these bookings
        model.addAttribute("bookings", bookings);
        
        return "customer_payments_list";
    }
}
