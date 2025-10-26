<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vehicle - DriveGo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
            color: #000000;
            min-height: 100vh;
            padding-bottom: 2rem;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .booking-content {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h1 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            color: #666;
            font-size: 1.1rem;
        }

        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: #d4edda;
            border-color: #28a745;
            color: #155724;
        }

        .alert-error {
            background-color: #f8d7da;
            border-color: #dc3545;
            color: #721c24;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }

        .form-group select,
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-group select:focus,
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .selected-vehicle {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            border-radius: 15px;
            margin-bottom: 1.5rem;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .selected-vehicle h3 {
            margin-bottom: 0.5rem;
            font-size: 1.3rem;
        }

        .vehicle-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .vehicle-detail {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .vehicle-detail i {
            font-size: 1.1rem;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            margin-right: 1rem;
        }

        .btn-secondary:hover {
            background: #5a6268;
            color: white;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid #e1e5e9;
        }

        .required {
            color: #dc3545;
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 0 0.5rem;
            }

            .booking-content {
                padding: 1.5rem;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="customer_header.jsp" />

    <div class="container">
        <div class="booking-content">
            <div class="page-header">
                <h1><i class="fas fa-calendar-plus"></i> Book Vehicle</h1>
                <p>Fill in the details below to book your preferred vehicle</p>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <c:if test="${not empty selectedVehicle}">
                <div class="selected-vehicle">
                    <h3><i class="fas fa-car"></i> Selected Vehicle: ${selectedVehicle.model}</h3>
                    <div class="vehicle-details">
                        <div class="vehicle-detail">
                            <i class="fas fa-hashtag"></i>
                            <span>Reg: ${selectedVehicle.regNo}</span>
                        </div>
                        <div class="vehicle-detail">
                            <i class="fas fa-gas-pump"></i>
                            <span>${selectedVehicle.fuelType}</span>
                        </div>
                        <div class="vehicle-detail">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>${selectedVehicle.mileage} km</span>
                        </div>
                        <div class="vehicle-detail">
                            <i class="fas fa-rupee-sign"></i>
                            <span>LKR ${selectedVehicle.rentalPrice}/day</span>
                        </div>
                    </div>
                </div>
            </c:if>

            <form action="/customer/book-vehicle" method="post" id="bookingForm">
                <div class="form-group">
                    <label for="vehicleRegNo">Select Vehicle <span class="required">*</span></label>
                    <select name="vehicleRegNo" id="vehicleRegNo" required>
                        <option value="">Choose a vehicle...</option>
                        <c:forEach var="vehicle" items="${vehicles}">
                            <option value="${vehicle.regNo}" 
                                    ${selectedVehicle != null && selectedVehicle.regNo == vehicle.regNo ? 'selected' : ''}>
                                ${vehicle.model} (${vehicle.regNo}) - LKR ${vehicle.rentalPrice}/day - ${vehicle.fuelType}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="contactPersonName">Full Name <span class="required">*</span></label>
                        <input type="text" name="contactPersonName" id="contactPersonName" 
                               placeholder="Enter your full name" required>
                    </div>
                    <div class="form-group">
                        <label for="contactNumber">Contact Number <span class="required">*</span></label>
                        <input type="tel" name="contactNumber" id="contactNumber" 
                               placeholder="Enter your phone number" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="bookedEmail">Email Address <span class="required">*</span></label>
                        <input type="email" name="bookedEmail" id="bookedEmail" 
                               value="${userEmail}" placeholder="Enter your email" required>
                    </div>
                    <div class="form-group">
                        <label for="bookingDate">Booking Date <span class="required">*</span></label>
                        <input type="date" name="bookingDate" id="bookingDate" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="additionalNotes">Additional Notes</label>
                    <textarea name="additionalNotes" id="additionalNotes" 
                              placeholder="Any special requests or additional information..."></textarea>
                </div>

                <div class="form-actions">
                    <a href="/customer/vehicles" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Vehicles
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-calendar-check"></i> Book Now
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />

    <script>
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('bookingDate');
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            const formattedDate = tomorrow.toISOString().split('T')[0];
            dateInput.min = formattedDate;
            
            // Form validation
            const form = document.getElementById('bookingForm');
            form.addEventListener('submit', function(e) {
                const selectedDate = new Date(dateInput.value);
                if (selectedDate <= today) {
                    e.preventDefault();
                    alert('Please select a future date for your booking.');
                    return false;
                }
                
                // Show loading state
                const submitBtn = form.querySelector('button[type="submit"]');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                submitBtn.disabled = true;
            });

            // Update vehicle info when selection changes
            const vehicleSelect = document.getElementById('vehicleRegNo');
            vehicleSelect.addEventListener('change', function() {
                if (this.value) {
                    // You could add AJAX here to fetch vehicle details
                    // For now, just update the URL to show selected vehicle
                    const currentUrl = new URL(window.location);
                    currentUrl.searchParams.set('vehicleRegNo', this.value);
                    // Uncomment the next line if you want to reload with selected vehicle
                    // window.location.href = currentUrl.toString();
                }
            });
        });
    </script>
</body>
</html>