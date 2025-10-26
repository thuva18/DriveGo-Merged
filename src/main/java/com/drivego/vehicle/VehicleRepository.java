package com.drivego.vehicle;

import com.drivego.vehicle.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VehicleRepository extends JpaRepository<Vehicle, String> {
    // Custom queries can be added if needed, e.g., for search/filter
    List<Vehicle> findByAvailabilityTrue();
}