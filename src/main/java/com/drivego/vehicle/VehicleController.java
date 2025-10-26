package com.drivego.vehicle;

import com.drivego.vehicle.Vehicle;
import com.drivego.vehicle.VehicleService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/vehicles")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    // List all vehicles (view)
    @GetMapping
    public String listVehicles(Model model) {
        model.addAttribute("vehicles", vehicleService.getAllVehicles());
        return "vehicles/list";
    }

    // Show form for add new vehicle
    @GetMapping("/new")
    public String showNewForm(Model model) {
        model.addAttribute("vehicle", new Vehicle());
        return "vehicles/form";
    }

    // Show form for edit vehicle
    @GetMapping("/edit/{regNo}")
    public String showEditForm(@PathVariable String regNo, Model model) {
        Optional<Vehicle> vehicle = vehicleService.getVehicleByRegNo(regNo);
        if (vehicle.isEmpty()) {
            return "redirect:/vehicles"; // Or error page
        }
        model.addAttribute("vehicle", vehicle.get());
        return "vehicles/form";
    }

    // Save (add or update) with validation
    @PostMapping("/save")
    public String saveVehicle(
            @Valid @ModelAttribute Vehicle vehicle, 
            BindingResult bindingResult, 
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            Model model) {
        
        System.out.println("=== VEHICLE SAVE DEBUG ===");
        System.out.println("RegNo: " + vehicle.getRegNo());
        System.out.println("Model: " + vehicle.getModel());
        System.out.println("FuelType: " + vehicle.getFuelType());
        System.out.println("Seats: " + vehicle.getSeats());
        System.out.println("DailyRate: " + vehicle.getDailyRate());
        System.out.println("RentalPrice: " + vehicle.getRentalPrice());
        System.out.println("Availability: " + vehicle.getAvailability());
        System.out.println("Binding Result has errors: " + bindingResult.hasErrors());
        
        if (bindingResult.hasErrors()) {
            System.out.println("Validation errors:");
            bindingResult.getAllErrors().forEach(error -> {
                System.out.println(" - " + error.getDefaultMessage());
            });
            model.addAttribute("error", "Please fix the validation errors: " + bindingResult.getAllErrors().get(0).getDefaultMessage());
            return "vehicles/form";
        }
        
        try {
            // Handle image upload
            if (imageFile != null && !imageFile.isEmpty()) {
                String fileName = saveImage(imageFile);
                vehicle.setImage(fileName);
                System.out.println("Image uploaded: " + fileName);
            }
            
            boolean isUpdate = vehicleService.getVehicleByRegNo(vehicle.getRegNo()).isPresent();
            System.out.println("Is Update: " + isUpdate);
            
            if (isUpdate) {
                // If updating and no new image uploaded, keep the old image
                if (imageFile == null || imageFile.isEmpty()) {
                    Vehicle existingVehicle = vehicleService.getVehicleByRegNo(vehicle.getRegNo()).get();
                    vehicle.setImage(existingVehicle.getImage());
                }
                vehicleService.updateVehicle(vehicle);
                System.out.println("Vehicle updated successfully");
                return "redirect:/vehicles?success=updated";
            } else {
                vehicleService.addVehicle(vehicle);
                System.out.println("Vehicle added successfully");
                return "redirect:/vehicles?success=added";
            }
        } catch (IllegalArgumentException e) {
            System.out.println("IllegalArgumentException: " + e.getMessage());
            model.addAttribute("error", e.getMessage());
            model.addAttribute("vehicle", vehicle);
            return "vehicles/form";
        } catch (IOException e) {
            System.out.println("IOException: " + e.getMessage());
            model.addAttribute("error", "Failed to upload image: " + e.getMessage());
            model.addAttribute("vehicle", vehicle);
            return "vehicles/form";
        } catch (Exception e) {
            System.out.println("Unexpected exception: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "An unexpected error occurred: " + e.getMessage());
            model.addAttribute("vehicle", vehicle);
            return "vehicles/form";
        }
    }
    
    // Helper method to save image
    private String saveImage(MultipartFile file) throws IOException {
        String uploadDir = "src/main/resources/static/uploads/vehicles";
        Path uploadPath = Paths.get(uploadDir);
        
        // Create directory if it doesn't exist
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }
        
        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String fileExtension = "";
        if (originalFilename != null && originalFilename.contains(".")) {
            fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String uniqueFilename = UUID.randomUUID().toString() + fileExtension;
        
        // Save file
        Path filePath = uploadPath.resolve(uniqueFilename);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        
        return uniqueFilename;
    }

    // Delete vehicle
    @GetMapping("/delete/{regNo}")
    public String deleteVehicle(@PathVariable String regNo) {
        try {
            vehicleService.deleteVehicle(regNo);
            return "redirect:/vehicles?success=deleted";
        } catch (IllegalArgumentException e) {
            return "redirect:/vehicles?error=" + e.getMessage();
        }
    }
}