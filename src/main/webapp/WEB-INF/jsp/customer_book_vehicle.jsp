<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vehicle - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        }

        .container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-header {
            text-align: center;
            color: #000000;
            margin-bottom: 2rem;
            padding: 2rem 0;
        }

        .page-header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            color: #000000;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .page-header h1 i {
            color: #0cc23c;
        }

        .booking-content {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .vehicle-details {
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            padding: 2rem;
            color: white;
            border-bottom: 3px solid #0cc23c;
        }

        .vehicle-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .vehicle-info-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .vehicle-info-item i {
            color: #0cc23c;
            font-size: 1.2rem;
        }

        .vehicle-info-label {
            color: rgba(255,255,255,0.7);
            font-size: 0.9rem;
        }

        .vehicle-info-value {
            color: white;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .form-section {
            padding: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #0cc23c;
        }

        .section-title i {
            color: #0cc23c;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group label i {
            color: #0cc23c;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #0cc23c;
            box-shadow: 0 0 0 3px rgba(12, 194, 60, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .price-summary {
            background: #f8f9ff;
            padding: 1.5rem;
            border-radius: 10px;
            margin: 1.5rem 0;
            border-left: 4px solid #0cc23c;
        }

        .price-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            color: #333;
        }

        .price-row.total {
            font-size: 1.3rem;
            font-weight: bold;
            padding-top: 0.75rem;
            border-top: 2px solid #0cc23c;
            color: #0cc23c;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s;
        }

        .btn-primary {
            background: linear-gradient(135deg, #0cc23c, #08a131);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(12, 194, 60, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #000000;
            border: 2px solid #000000;
        }

        .btn-secondary:hover {
            background: #000000;
            color: white;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2rem;
            }

            .vehicle-info-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="customer_header.jsp" />

    <div class="container">
        <div class="page-header">
            <h1><i class="fas fa-calendar-check"></i> Book Vehicle</h1>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <div class="booking-content">
            <!-- Vehicle Details Section -->
            <div class="vehicle-details">
                <h2 style="margin-bottom: 1rem;"><i class="fas fa-car"></i> ${vehicle.model}</h2>
                <div class="vehicle-info-grid">
                    <div class="vehicle-info-item">
                        <i class="fas fa-hashtag"></i>
                        <div>
                            <div class="vehicle-info-label">Reg. No.</div>
                            <div class="vehicle-info-value">${vehicle.regNo}</div>
                        </div>
                    </div>
                    <div class="vehicle-info-item">
                        <i class="fas fa-gas-pump"></i>
                        <div>
                            <div class="vehicle-info-label">Fuel Type</div>
                            <div class="vehicle-info-value">${vehicle.fuelType}</div>
                        </div>
                    </div>
                    <div class="vehicle-info-item">
                        <i class="fas fa-users"></i>
                        <div>
                            <div class="vehicle-info-label">Seats</div>
                            <div class="vehicle-info-value">${vehicle.seats}</div>
                        </div>
                    </div>
                    <div class="vehicle-info-item">
                        <i class="fas fa-dollar-sign"></i>
                        <div>
                            <div class="vehicle-info-label">Daily Rate</div>
                            <div class="vehicle-info-value">LKR ${vehicle.dailyRate}/day</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Form -->
            <form action="/customer/create-booking" method="post" class="form-section">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="vehicleRegNo" value="${vehicle.regNo}"/>

                <h2 class="section-title">
                    <i class="fas fa-calendar-alt"></i>
                    Booking Details
                </h2>

                <div class="form-group">
                    <label for="pickupDate">
                        <i class="fas fa-calendar"></i>
                        Pickup Date
                    </label>
                    <input type="date" id="pickupDate" name="pickupDate" required>
                </div>

                <div class="form-group">
                    <label for="returnDate">
                        <i class="fas fa-calendar"></i>
                        Return Date
                    </label>
                    <input type="date" id="returnDate" name="returnDate" required>
                </div>

                <div class="form-group">
                    <label for="pickupLocation">
                        <i class="fas fa-map-marker-alt"></i>
                        Pickup Location
                    </label>
                    <input type="text" id="pickupLocation" name="pickupLocation" 
                           placeholder="Enter pickup location" required>
                </div>

                <div class="form-group">
                    <label for="additionalNotes">
                        <i class="fas fa-comment"></i>
                        Additional Notes (Optional)
                    </label>
                    <textarea id="additionalNotes" name="additionalNotes" 
                              placeholder="Any special requirements or requests..."></textarea>
                </div>

                <!-- Price Summary -->
                <div class="price-summary">
                    <h3 style="margin-bottom: 1rem; color: #333;">
                        <i class="fas fa-calculator"></i> Price Summary
                    </h3>
                    <div class="price-row">
                        <span>Daily Rate:</span>
                        <span>LKR ${vehicle.dailyRate}</span>
                    </div>
                    <div class="price-row">
                        <span>Number of Days:</span>
                        <span id="numDays">-</span>
                    </div>
                    <div class="price-row total">
                        <span>Total Amount:</span>
                        <span id="totalAmount">LKR 0.00</span>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="/customer/vehicles" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Back to Vehicles
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-credit-card"></i> Proceed to Pay
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Calculate total price based on dates
        const pickupDateInput = document.getElementById('pickupDate');
        const returnDateInput = document.getElementById('returnDate');
        const dailyRate = ${vehicle.dailyRate};

        function calculateTotal() {
            const pickupDate = new Date(pickupDateInput.value);
            const returnDate = new Date(returnDateInput.value);

            if (pickupDate && returnDate && returnDate > pickupDate) {
                const timeDiff = returnDate - pickupDate;
                const daysDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24));
                const total = daysDiff * dailyRate;

                document.getElementById('numDays').textContent = daysDiff;
                document.getElementById('totalAmount').textContent = 'LKR ' + total.toFixed(2);
            } else {
                document.getElementById('numDays').textContent = '-';
                document.getElementById('totalAmount').textContent = 'LKR 0.00';
            }
        }

        pickupDateInput.addEventListener('change', calculateTotal);
        returnDateInput.addEventListener('change', calculateTotal);

        // Set minimum dates
        const today = new Date().toISOString().split('T')[0];
        pickupDateInput.setAttribute('min', today);
        
        pickupDateInput.addEventListener('change', function() {
            returnDateInput.setAttribute('min', this.value);
        });
    </script>

    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />
</body>
</html>
