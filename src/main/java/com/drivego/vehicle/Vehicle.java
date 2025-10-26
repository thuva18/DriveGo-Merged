package com.drivego.vehicle;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "vehicles")
public class Vehicle {

    @Id
    @NotBlank(message = "Registration number is required")
    private String regNo;

    @NotBlank(message = "Model is required")
    private String model;

    private String imageUrl;
    
    private String image;

    @Min(value = 0, message = "Mileage must be non-negative")
    private int mileage;

    @DecimalMin(value = "0.01", message = "Rental price must be positive")
    private double rentalPrice;
    
    @DecimalMin(value = "0.01", message = "Daily rate must be positive")
    private double dailyRate;
    
    @Min(value = 1, message = "Seats must be at least 1")
    private int seats;

    @NotBlank(message = "Fuel type is required")
    private String fuelType;

    private String maintenanceHistory;

    @NotNull(message = "Availability is required")
    private Boolean availability;

//    @NotBlank(message = "Condition is required")
//    @jakarta.persistence.Column(name = "`condition`") // Explicitly map to the escaped column name
//    private String condition;

    // Default constructor
    public Vehicle() {}

    // Getters and Setters
    public String getRegNo() { return regNo; }
    public void setRegNo(String regNo) { this.regNo = regNo; }
    public String getModel() { return model; }
    public void setModel(String model) { this.model = model; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getMileage() { return mileage; }
    public void setMileage(int mileage) { this.mileage = mileage; }
    public double getRentalPrice() { return rentalPrice; }
    public void setRentalPrice(double rentalPrice) { this.rentalPrice = rentalPrice; }
    public double getDailyRate() { return dailyRate; }
    public void setDailyRate(double dailyRate) { this.dailyRate = dailyRate; }
    public int getSeats() { return seats; }
    public void setSeats(int seats) { this.seats = seats; }
    public String getFuelType() { return fuelType; }
    public void setFuelType(String fuelType) { this.fuelType = fuelType; }
    public String getMaintenanceHistory() { return maintenanceHistory; }
    public void setMaintenanceHistory(String maintenanceHistory) { this.maintenanceHistory = maintenanceHistory; }
    public Boolean getAvailability() { return availability; }
    public void setAvailability(Boolean availability) { this.availability = availability; }
//    public String getCondition() { return condition; }
//    public void setCondition(String condition) { this.condition = condition; }
}