package com.drivego.vehicle;

import com.drivego.vehicle.Vehicle;
import com.drivego.vehicle.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VehicleService {

    @Autowired
    private VehicleRepository vehicleRepository;

    public List<Vehicle> getAllVehicles() {
        return vehicleRepository.findAll();
    }

    public Optional<Vehicle> getVehicleByRegNo(String regNo) {
        return vehicleRepository.findById(regNo);
    }

    public void addVehicle(Vehicle vehicle) {
        if (vehicleRepository.existsById(vehicle.getRegNo())) {
            throw new IllegalArgumentException("Vehicle with registration number " + vehicle.getRegNo() + " already exists.");
        }
        // Additional validations can be done here if not covered by @Valid
        vehicleRepository.save(vehicle);
    }

    public void updateVehicle(Vehicle vehicle) {
        if (!vehicleRepository.existsById(vehicle.getRegNo())) {
            throw new IllegalArgumentException("Vehicle with registration number " + vehicle.getRegNo() + " does not exist.");
        }
        vehicleRepository.save(vehicle);
    }

    public void deleteVehicle(String regNo) {
        if (!vehicleRepository.existsById(regNo)) {
            throw new IllegalArgumentException("Vehicle with registration number " + regNo + " does not exist.");
        }
        // Add check if in use (e.g., has active bookings) if integrated later
        vehicleRepository.deleteById(regNo);
    }

    public List<Vehicle> getAvailableVehicles() {
        return vehicleRepository.findByAvailabilityTrue();
    }
}