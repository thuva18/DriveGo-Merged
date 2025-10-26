package com.drivego.booking;

import com.drivego.booking.CarBookingDTOS;
import com.drivego.booking.CarBookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/bookings")
public class CarBookingController {
    
    private final CarBookingService carBookingService;
    
    @Autowired
    public CarBookingController(CarBookingService carBookingService) {
        this.carBookingService = carBookingService;
    }
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                try {
                    setValue(dateFormat.parse(text));
                } catch (ParseException e) {
                    setValue(null);
                }
            }
            
            @Override
            public String getAsText() {
                Date value = (Date) getValue();
                return (value != null ? dateFormat.format(value) : "");
            }
        });
    }
    
    // Admin: View all bookings
    @GetMapping
    public String listBookings(Model model,
                              @RequestParam(defaultValue = "0") int page,
                              @RequestParam(defaultValue = "10") int size) {
        try {
            CarBookingDTOS.ListResponse response = carBookingService.getAllBookings(page, size);
            model.addAttribute("bookings", response.getBookings());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", response.getTotalPages());
            model.addAttribute("totalElements", response.getTotalElements());
            return "bookings/list";
        } catch (Exception e) {
            model.addAttribute("error", "Failed to load bookings: " + e.getMessage());
            return "bookings/list";
        }
    }

    // Admin: View booking details
    @GetMapping("/{id}")
    public String viewBooking(@PathVariable Long id, Model model) {
        try {
            CarBookingDTOS.Response booking = carBookingService.getBookingById(id);
            model.addAttribute("booking", booking);
            return "bookings/view";
        } catch (Exception e) {
            model.addAttribute("error", "Booking not found");
            return "redirect:/bookings";
        }
    }

    // Admin: Show create booking form
    @GetMapping("/new")
    public String newBookingForm(Model model) {
        model.addAttribute("booking", new CarBookingDTOS.CreateRequest());
        return "bookings/form";
    }

    // Admin: Create booking
    @PostMapping
    public String createBooking(@ModelAttribute CarBookingDTOS.CreateRequest request,
                               RedirectAttributes redirectAttributes) {
        try {
            CarBookingDTOS.Response response = carBookingService.createBooking(request);
            redirectAttributes.addFlashAttribute("success", "Booking created successfully with ID: " + response.getId());
            return "redirect:/bookings/" + response.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create booking: " + e.getMessage());
            return "redirect:/bookings/new";
        }
    }

    // Admin: Show edit booking form
    @GetMapping("/{id}/edit")
    public String editBookingForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            CarBookingDTOS.Response booking = carBookingService.getBookingById(id);
            model.addAttribute("booking", booking);
            return "bookings/edit";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Booking not found");
            return "redirect:/bookings";
        }
    }

    // Admin: Update booking
    @PostMapping("/{id}/update")
    public String updateBooking(@PathVariable Long id,
                               @ModelAttribute CarBookingDTOS.UpdateRequest request,
                               RedirectAttributes redirectAttributes) {
        try {
            CarBookingDTOS.Response response = carBookingService.updateBooking(id, request);
            redirectAttributes.addFlashAttribute("success", "Booking updated successfully");
            return "redirect:/bookings/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update booking: " + e.getMessage());
            return "redirect:/bookings/" + id + "/edit";
        }
    }

    // Admin: Update booking status (kept for backward compatibility)
    @PostMapping("/{id}/status")
    public String updateBookingStatus(@PathVariable Long id,
                                    @RequestParam String status,
                                    RedirectAttributes redirectAttributes) {
        try {
            carBookingService.updateBookingStatus(id, status);
            redirectAttributes.addFlashAttribute("success", "Booking status updated successfully");
            return "redirect:/bookings/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update booking status: " + e.getMessage());
            return "redirect:/bookings/" + id;
        }
    }

    // Admin: Delete booking (soft delete)
    @PostMapping("/{id}/delete")
    public String deleteBooking(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            carBookingService.deleteBooking(id);
            redirectAttributes.addFlashAttribute("success", "Booking deleted successfully");
            return "redirect:/bookings";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete booking: " + e.getMessage());
            return "redirect:/bookings";
        }
    }
}

// API Controller for REST endpoints
@RestController
@RequestMapping("/api/bookings")
class CarBookingApiController {

    private final CarBookingService carBookingService;

    @Autowired
    public CarBookingApiController(CarBookingService carBookingService) {
        this.carBookingService = carBookingService;
    }

    @PostMapping
    public ResponseEntity<CarBookingDTOS.Response> createBooking(@RequestBody CarBookingDTOS.CreateRequest request) {
        try {
            CarBookingDTOS.Response response = carBookingService.createBooking(request);
            return new ResponseEntity<>(response, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<CarBookingDTOS.Response> getBookingById(@PathVariable Long id) {
        try {
            CarBookingDTOS.Response response = carBookingService.getBookingById(id);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    
    @GetMapping
    public ResponseEntity<CarBookingDTOS.ListResponse> getAllBookings(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        try {
            CarBookingDTOS.ListResponse response = carBookingService.getAllBookings(page, size);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
