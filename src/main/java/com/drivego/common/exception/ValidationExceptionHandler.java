package com.drivego.common.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Global exception handler for validation errors
 * Provides consistent error responses across all controllers
 */
@ControllerAdvice
public class ValidationExceptionHandler {

    /**
     * Handles validation errors from @Valid annotations on request bodies
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, Object>> handleValidationExceptions(
            MethodArgumentNotValidException ex) {
        
        Map<String, Object> response = new HashMap<>();
        Map<String, String> errors = new HashMap<>();
        
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        
        response.put("status", "error");
        response.put("message", "Validation failed");
        response.put("errors", errors);
        
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Handles validation errors from form binding
     */
    @ExceptionHandler(BindException.class)
    public ModelAndView handleBindException(BindException ex) {
        ModelAndView modelAndView = new ModelAndView();
        
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        
        // Get the first error message to display as general error
        String firstError = errors.values().iterator().next();
        
        modelAndView.addObject("error", "Validation failed: " + firstError);
        modelAndView.addObject("fieldErrors", errors);
        
        // Determine which view to return based on the form being submitted
        String referer = ex.getBindingResult().getObjectName();
        if (referer.contains("vehicle")) {
            modelAndView.setViewName("vehicles/form");
        } else if (referer.contains("booking")) {
            modelAndView.setViewName("bookings/form");
        } else if (referer.contains("user")) {
            modelAndView.setViewName("user/form");
        } else {
            modelAndView.setViewName("error");
        }
        
        return modelAndView;
    }

    /**
     * Handles constraint violation exceptions
     */
    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<Map<String, Object>> handleConstraintViolationException(
            ConstraintViolationException ex) {
        
        Map<String, Object> response = new HashMap<>();
        Map<String, String> errors = new HashMap<>();
        
        Set<ConstraintViolation<?>> violations = ex.getConstraintViolations();
        for (ConstraintViolation<?> violation : violations) {
            String fieldName = violation.getPropertyPath().toString();
            String errorMessage = violation.getMessage();
            errors.put(fieldName, errorMessage);
        }
        
        response.put("status", "error");
        response.put("message", "Validation constraints violated");
        response.put("errors", errors);
        
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Handles generic illegal argument exceptions
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public ModelAndView handleIllegalArgumentException(IllegalArgumentException ex) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("error", ex.getMessage());
        modelAndView.setViewName("error");
        return modelAndView;
    }

    /**
     * Handles file upload size exceeded exceptions
     */
    @ExceptionHandler(org.springframework.web.multipart.MaxUploadSizeExceededException.class)
    public ModelAndView handleMaxSizeException(
            org.springframework.web.multipart.MaxUploadSizeExceededException ex) {
        
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("error", "File size exceeds maximum limit. Please select a smaller file.");
        modelAndView.setViewName("vehicles/form");
        return modelAndView;
    }

    /**
     * Utility method to create standardized error response
     */
    public static Map<String, Object> createErrorResponse(String message, Map<String, String> fieldErrors) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "error");
        response.put("message", message);
        response.put("errors", fieldErrors);
        response.put("timestamp", System.currentTimeMillis());
        return response;
    }

    /**
     * Utility method to extract validation errors from binding result
     */
    public static Map<String, String> extractFieldErrors(org.springframework.validation.BindingResult bindingResult) {
        Map<String, String> errors = new HashMap<>();
        
        bindingResult.getFieldErrors().forEach(error -> {
            errors.put(error.getField(), error.getDefaultMessage());
        });
        
        bindingResult.getGlobalErrors().forEach(error -> {
            errors.put(error.getObjectName(), error.getDefaultMessage());
        });
        
        return errors;
    }
}