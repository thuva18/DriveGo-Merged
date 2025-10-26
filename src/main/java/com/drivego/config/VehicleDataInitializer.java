package com.drivego.config;

import com.drivego.vehicle.Vehicle;
import com.drivego.vehicle.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

// @Component - DISABLED to use only real database data
public class VehicleDataInitializer implements CommandLineRunner {

    @Autowired
    private VehicleRepository vehicleRepository;

    @Override
    public void run(String... args) throws Exception {
        // Only initialize if no vehicles exist
        if (vehicleRepository.count() == 0) {
            initializeSampleVehicles();
        }
    }

    private void initializeSampleVehicles() {
        // Economy Cars
        Vehicle vehicle1 = new Vehicle();
        vehicle1.setRegNo("ECO-001");
        vehicle1.setModel("Toyota Corolla");
        vehicle1.setMileage(25000);
        vehicle1.setRentalPrice(45.00);
        vehicle1.setFuelType("Petrol");
        vehicle1.setMaintenanceHistory("Last serviced on 2024-09-15");
        vehicle1.setAvailability(true);
        vehicleRepository.save(vehicle1);

        Vehicle vehicle2 = new Vehicle();
        vehicle2.setRegNo("ECO-002");
        vehicle2.setModel("Honda Civic");
        vehicle2.setMileage(18000);
        vehicle2.setRentalPrice(50.00);
        vehicle2.setFuelType("Petrol");
        vehicle2.setMaintenanceHistory("Last serviced on 2024-08-22");
        vehicle2.setAvailability(true);
        vehicleRepository.save(vehicle2);

        Vehicle vehicle3 = new Vehicle();
        vehicle3.setRegNo("ECO-003");
        vehicle3.setModel("Nissan Sentra");
        vehicle3.setMileage(32000);
        vehicle3.setRentalPrice(42.00);
        vehicle3.setFuelType("Petrol");
        vehicle3.setMaintenanceHistory("Last serviced on 2024-10-01");
        vehicle3.setAvailability(true);
        vehicleRepository.save(vehicle3);

        // Premium Cars
        Vehicle vehicle4 = new Vehicle();
        vehicle4.setRegNo("PREM-001");
        vehicle4.setModel("BMW 3 Series");
        vehicle4.setMileage(15000);
        vehicle4.setRentalPrice(120.00);
        vehicle4.setFuelType("Petrol");
        vehicle4.setMaintenanceHistory("Last serviced on 2024-09-30");
        vehicle4.setAvailability(true);
        vehicleRepository.save(vehicle4);

        Vehicle vehicle5 = new Vehicle();
        vehicle5.setRegNo("PREM-002");
        vehicle5.setModel("Mercedes C-Class");
        vehicle5.setMileage(12000);
        vehicle5.setRentalPrice(135.00);
        vehicle5.setFuelType("Petrol");
        vehicle5.setMaintenanceHistory("Last serviced on 2024-09-20");
        vehicle5.setAvailability(true);
        vehicleRepository.save(vehicle5);

        Vehicle vehicle6 = new Vehicle();
        vehicle6.setRegNo("PREM-003");
        vehicle6.setModel("Audi A4");
        vehicle6.setMileage(22000);
        vehicle6.setRentalPrice(110.00);
        vehicle6.setFuelType("Petrol");
        vehicle6.setMaintenanceHistory("Last serviced on 2024-08-15");
        vehicle6.setAvailability(true);
        vehicleRepository.save(vehicle6);

        // SUVs
        Vehicle vehicle7 = new Vehicle();
        vehicle7.setRegNo("SUV-001");
        vehicle7.setModel("Toyota RAV4");
        vehicle7.setMileage(28000);
        vehicle7.setRentalPrice(85.00);
        vehicle7.setFuelType("Hybrid");
        vehicle7.setMaintenanceHistory("Last serviced on 2024-09-10");
        vehicle7.setAvailability(true);
        vehicleRepository.save(vehicle7);

        Vehicle vehicle8 = new Vehicle();
        vehicle8.setRegNo("SUV-002");
        vehicle8.setModel("Honda CR-V");
        vehicle8.setMileage(35000);
        vehicle8.setRentalPrice(80.00);
        vehicle8.setFuelType("Petrol");
        vehicle8.setMaintenanceHistory("Last serviced on 2024-08-28");
        vehicle8.setAvailability(true);
        vehicleRepository.save(vehicle8);

        Vehicle vehicle9 = new Vehicle();
        vehicle9.setRegNo("SUV-003");
        vehicle9.setModel("Ford Explorer");
        vehicle9.setMileage(40000);
        vehicle9.setRentalPrice(95.00);
        vehicle9.setFuelType("Petrol");
        vehicle9.setMaintenanceHistory("Last serviced on 2024-09-05");
        vehicle9.setAvailability(true);
        vehicleRepository.save(vehicle9);

        // Electric Vehicles
        Vehicle vehicle10 = new Vehicle();
        vehicle10.setRegNo("EV-001");
        vehicle10.setModel("Tesla Model 3");
        vehicle10.setMileage(8000);
        vehicle10.setRentalPrice(150.00);
        vehicle10.setFuelType("Electric");
        vehicle10.setMaintenanceHistory("Battery check on 2024-09-25");
        vehicle10.setAvailability(true);
        vehicleRepository.save(vehicle10);

        Vehicle vehicle11 = new Vehicle();
        vehicle11.setRegNo("EV-002");
        vehicle11.setModel("Nissan Leaf");
        vehicle11.setMileage(15000);
        vehicle11.setRentalPrice(90.00);
        vehicle11.setFuelType("Electric");
        vehicle11.setMaintenanceHistory("Battery check on 2024-08-12");
        vehicle11.setAvailability(true);
        vehicleRepository.save(vehicle11);

        // Vans
        Vehicle vehicle12 = new Vehicle();
        vehicle12.setRegNo("VAN-001");
        vehicle12.setModel("Ford Transit");
        vehicle12.setMileage(55000);
        vehicle12.setRentalPrice(75.00);
        vehicle12.setFuelType("Diesel");
        vehicle12.setMaintenanceHistory("Last serviced on 2024-09-18");
        vehicle12.setAvailability(true);
        vehicleRepository.save(vehicle12);

        Vehicle vehicle13 = new Vehicle();
        vehicle13.setRegNo("VAN-002");
        vehicle13.setModel("Mercedes Sprinter");
        vehicle13.setMileage(48000);
        vehicle13.setRentalPrice(85.00);
        vehicle13.setFuelType("Diesel");
        vehicle13.setMaintenanceHistory("Last serviced on 2024-08-30");
        vehicle13.setAvailability(true);
        vehicleRepository.save(vehicle13);

        // Motorcycles
        Vehicle vehicle14 = new Vehicle();
        vehicle14.setRegNo("BIKE-001");
        vehicle14.setModel("Honda CB500F");
        vehicle14.setMileage(12000);
        vehicle14.setRentalPrice(35.00);
        vehicle14.setFuelType("Petrol");
        vehicle14.setMaintenanceHistory("Last serviced on 2024-09-12");
        vehicle14.setAvailability(true);
        vehicleRepository.save(vehicle14);

        Vehicle vehicle15 = new Vehicle();
        vehicle15.setRegNo("BIKE-002");
        vehicle15.setModel("Yamaha MT-07");
        vehicle15.setMileage(8500);
        vehicle15.setRentalPrice(40.00);
        vehicle15.setFuelType("Petrol");
        vehicle15.setMaintenanceHistory("Last serviced on 2024-08-20");
        vehicle15.setAvailability(true);
        vehicleRepository.save(vehicle15);

        System.out.println("Initialized 15 sample vehicles in the database");
    }
}