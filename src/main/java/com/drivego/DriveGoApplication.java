package com.drivego;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableJpaRepositories(basePackages = "com.drivego")
@EntityScan(basePackages = "com.drivego")
@EnableTransactionManagement
public class DriveGoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DriveGoApplication.class, args);
    }
}
