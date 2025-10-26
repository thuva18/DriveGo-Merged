package com.drivego.customer;

import com.drivego.entity.User;
import com.drivego.user.UserService;
import com.drivego.vehicle.Vehicle;
import com.drivego.vehicle.VehicleService;
import com.drivego.booking.CarBookingModel;
import com.drivego.booking.CarBookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerBookingController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private VehicleService vehicleService;
    
    @Autowired
    private CarBookingRepository bookingRepository;

    /**
     * Global model attribute to add user to all customer booking pages
     */
    @ModelAttribute
    public void addUserToModel(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails != null) {
            User user = userService.findUserByEmail(userDetails.getUsername());
            if (user != null) {
                model.addAttribute("user", user);
            }
        }
    }

    @GetMapping("/my-bookings")
    public String showMyBookings(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        // Get current user's email
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && userDetails != null) {
            String userEmail = authentication.getName();
            
            // Fetch bookings for this user
            List<CarBookingModel> bookings = bookingRepository.findByBookedEmailAndDeleteStatusFalse(userEmail);
            model.addAttribute("bookings", bookings);
            model.addAttribute("userEmail", userEmail);
        } else {
            // Fallback for testing
            model.addAttribute("bookings", java.util.Collections.emptyList());
            model.addAttribute("userEmail", "user@drivego.com");
        }

        return "customer_my_bookings";
    }
    
    @GetMapping("/book-vehicle")
    public String bookVehicle(@RequestParam("vehicleRegNo") String vehicleRegNo, Model model) {
        // Get the vehicle details
        Vehicle vehicle = vehicleService.getVehicleByRegNo(vehicleRegNo).orElse(null);
        
        if (vehicle == null) {
            model.addAttribute("errorMessage", "Vehicle not found");
            return "redirect:/customer/vehicles";
        }
        
        model.addAttribute("vehicle", vehicle);
        return "customer_book_vehicle";
    }
    
    @PostMapping("/create-booking")
    public String createBooking(
            @RequestParam("vehicleRegNo") String vehicleRegNo,
            @RequestParam("pickupDate") String pickupDateStr,
            @RequestParam("returnDate") String returnDateStr,
            @RequestParam("pickupLocation") String pickupLocation,
            @RequestParam(value = "additionalNotes", required = false) String additionalNotes,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttributes) {
        
        try {
            if (userDetails == null) {
                return "redirect:/login";
            }
            
            // Get vehicle details
            Vehicle vehicle = vehicleService.getVehicleByRegNo(vehicleRegNo).orElse(null);
            if (vehicle == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Vehicle not found");
                return "redirect:/customer/vehicles";
            }
            
            // Get user details
            User user = userService.findUserByEmail(userDetails.getUsername());
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User not found");
                return "redirect:/customer/vehicles";
            }
            
            // Parse dates
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date pickupDate = dateFormat.parse(pickupDateStr);
            Date returnDate = dateFormat.parse(returnDateStr);
            
            // Validate dates
            if (returnDate.before(pickupDate)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Return date must be after pickup date");
                return "redirect:/customer/book-vehicle?vehicleRegNo=" + vehicleRegNo;
            }
            
            // Create booking
            CarBookingModel booking = new CarBookingModel();
            booking.setVehicleRegNo(vehicleRegNo);
            booking.setCarId(Long.parseLong(vehicleRegNo.replaceAll("[^0-9]", "1"))); // Temporary carId
            booking.setPickupDate(pickupDate);
            booking.setReturnDate(returnDate);
            booking.setPickupLocation(pickupLocation);
            booking.setBookingDate(new Date());
            booking.setBookedEmail(user.getEmail());
            booking.setContactPersonName(user.getName());
            booking.setContactNumber(user.getContactNum() != null ? user.getContactNum() : "");
            booking.setAdditionalNotes(additionalNotes);
            booking.setStatus("PENDING");
            booking.setDeleteStatus(false);
            
            // Save booking
            CarBookingModel savedBooking = bookingRepository.save(booking);
            
            // Redirect to payment page
            redirectAttributes.addFlashAttribute("successMessage", "Booking created successfully! Please complete the payment.");
            return "redirect:/customer/payment?bookingId=" + savedBooking.getId();
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error creating booking: " + e.getMessage());
            return "redirect:/customer/book-vehicle?vehicleRegNo=" + vehicleRegNo;
        }
    }
}