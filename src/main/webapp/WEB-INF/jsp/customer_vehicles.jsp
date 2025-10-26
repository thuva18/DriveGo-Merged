<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Vehicles - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            color: #2c2c2c;
            min-height: 100vh;
            padding-bottom: 2rem;
            position: relative;
        }

        /* Remove embedded header styles - using shared component */

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            position: relative;
            z-index: 5;
        }

        .page-header {
            background: #f8f9fa;
            border-radius: 20px;
            padding: 3rem 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            border: 3px solid #08a131;
            position: relative;
        }

        .page-title {
            font-size: 3rem;
            color: #2c2c2c;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .page-subtitle {
            color: #666666;
            font-size: 1.1rem;
        }

        /* Filter Section */
        .filters-section {
            background: #f8f9fa;
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 3rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            border: 2px solid #e9ecef;
            position: relative;
        }
        }

        .filters-title {
            font-size: 1.5rem;
            color: #2c2c2c;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 700;
        }

        .filters-title i {
            color: #08a131;
            font-size: 1.4rem;
        }

        .filter-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .form-group label {
            font-weight: 600;
            color: #2c2c2c;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group select {
            padding: 1rem;
            border: 2px solid #e5e5e5;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fafafa;
            color: #000000;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #08a131;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(8, 161, 49, 0.1);
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 700;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #08a131 0%, #0cc23c 100%);
            color: #000000;
            box-shadow: 0 6px 20px rgba(8, 161, 49, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(8, 161, 49, 0.5);
            background: linear-gradient(135deg, #0a6e24, #08a131);
        }

        .btn-secondary {
            background: #333333;
            color: #ffffff;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        .btn-secondary:hover {
            background: #000000;
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        /* Vehicles Grid */
        .vehicles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2.5rem;
            margin-top: 3rem;
        }

        .vehicle-card {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 30px rgba(8, 161, 49, 0.1);
            transition: all 0.3s ease;
            border: 1px solid rgba(8, 161, 49, 0.2);
            position: relative;
        }

        .vehicle-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #08a131, #0cc23c);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .vehicle-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .vehicle-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(45deg, #f0f2f5, #e1e8ed);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: #667eea;
        }

        .vehicle-content {
            padding: 1.5rem;
        }

        .vehicle-title {
            font-size: 1.3rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .vehicle-reg {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .vehicle-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 0.3rem;
        }

        .detail-label {
            font-size: 0.85rem;
            color: #666;
            font-weight: 500;
        }

        .detail-value {
            color: #333;
            font-weight: 600;
        }

        .vehicle-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
            text-align: center;
            margin-bottom: 1rem;
        }

        .vehicle-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn-book {
            flex: 1;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border: none;
            padding: 0.8rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-book.btn-disabled {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            cursor: not-allowed;
            opacity: 0.7;
        }

        .btn-book.btn-disabled:hover {
            transform: none;
            box-shadow: none;
        }

        .btn-details {
            background: #6c757d;
            color: white;
            padding: 0.8rem 1rem;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .btn-details:hover {
            background: #5a6268;
            color: white;
        }

        /* Availability Badge */
        .availability-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            color: white;
            padding: 0.4rem 0.9rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.3rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            z-index: 10;
        }

        .availability-badge.available {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }

        .availability-badge.unavailable {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        }

        .availability-badge i {
            font-size: 0.9rem;
        }

        .vehicle-card {
            position: relative;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #666;
        }

        .empty-icon {
            font-size: 5rem;
            color: #ddd;
            margin-bottom: 1rem;
        }

        .empty-title {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 0.5rem;
        }

        /* Results Count */
        .results-count {
            background: white;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        @media (max-width: 768px) {

            .filter-form {
                grid-template-columns: 1fr;
            }

            .vehicles-grid {
                grid-template-columns: 1fr;
            }

            .vehicle-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="customer_header.jsp" />

    <main>
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-car"></i> Browse Our Fleet
                </h1>
                <p class="page-subtitle">Find the perfect vehicle for your journey</p>
            </div>

            <!-- Filters Section -->
            <div class="filters-section">
                <h3 class="filters-title">
                    <i class="fas fa-filter"></i> Filter Vehicles
                </h3>
                <form method="GET" action="/customer/vehicles" class="filter-form">
                    <div class="form-group">
                        <label for="search">Search</label>
                        <input type="text" id="search" name="search" value="${searchQuery}" placeholder="Search by model or reg no...">
                    </div>
                    <div class="form-group">
                        <label for="fuelType">Fuel Type</label>
                        <select id="fuelType" name="fuelType">
                            <option value="">All Fuel Types</option>
                            <option value="Petrol" ${selectedFuelType == 'Petrol' ? 'selected' : ''}>Petrol</option>
                            <option value="Diesel" ${selectedFuelType == 'Diesel' ? 'selected' : ''}>Diesel</option>
                            <option value="Hybrid" ${selectedFuelType == 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                            <option value="Electric" ${selectedFuelType == 'Electric' ? 'selected' : ''}>Electric</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="minPrice">Min Price (LKR/day)</label>
                        <input type="number" id="minPrice" name="minPrice" value="${minPrice}" placeholder="Min price" min="0" step="0.01">
                    </div>
                    <div class="form-group">
                        <label for="maxPrice">Max Price (LKR/day)</label>
                        <input type="number" id="maxPrice" name="maxPrice" value="${maxPrice}" placeholder="Max price" min="0" step="0.01">
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </form>
            </div>

            <!-- Results Count -->
            <div class="results-count">
                <span><strong>${vehicles.size()}</strong> vehicles available</span>
                <c:if test="${not empty searchQuery or not empty selectedFuelType or not empty minPrice or not empty maxPrice}">
                    <a href="/customer/vehicles" class="btn btn-secondary">Clear Filters</a>
                </c:if>
            </div>

            <!-- Vehicles Grid -->
            <c:choose>
                <c:when test="${not empty vehicles}">
                    <div class="vehicles-grid">
                        <c:forEach var="vehicle" items="${vehicles}">
                            <div class="vehicle-card">
                                <c:choose>
                                    <c:when test="${vehicle.availability}">
                                        <div class="availability-badge available">
                                            <i class="fas fa-check-circle"></i> Available
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="availability-badge unavailable">
                                            <i class="fas fa-times-circle"></i> Not Available
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="vehicle-image">
                                    <c:choose>
                                        <c:when test="${not empty vehicle.image}">
                                            <img src="<c:url value='/uploads/vehicles/${vehicle.image}'/>" alt="${vehicle.model}" style="width: 100%; height: 100%; object-fit: cover;" />
                                        </c:when>
                                        <c:when test="${not empty vehicle.imageUrl}">
                                            <img src="${vehicle.imageUrl}" alt="${vehicle.model}" style="width: 100%; height: 100%; object-fit: cover;" />
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-car"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="vehicle-content">
                                    <h3 class="vehicle-title">${vehicle.model}</h3>
                                    <p class="vehicle-reg">Reg: ${vehicle.regNo}</p>
                                    
                                    <div class="vehicle-details">
                                        <div class="detail-item">
                                            <span class="detail-label">Fuel Type</span>
                                            <span class="detail-value">${vehicle.fuelType}</span>
                                        </div>
                                        <div class="detail-item">
                                            <span class="detail-label">Mileage</span>
                                            <span class="detail-value">${vehicle.mileage} km</span>
                                        </div>
                                    </div>
                                    
                                    <div class="vehicle-price">
                                        LKR ${vehicle.rentalPrice}/day
                                    </div>
                                    
                                    <div class="vehicle-actions">
                                        <c:choose>
                                            <c:when test="${vehicle.availability}">
                                                <button class="btn-book" onclick="bookVehicle('${vehicle.regNo}')">
                                                    <i class="fas fa-calendar-plus"></i> Book Now
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn-book btn-disabled" disabled>
                                                    <i class="fas fa-ban"></i> Not Available
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="/customer/vehicles/${vehicle.regNo}" class="btn-details">
                                            <i class="fas fa-info-circle"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fas fa-car-crash"></i>
                        </div>
                        <h3 class="empty-title">No vehicles found</h3>
                        <p>Try adjusting your filters or search criteria to find available vehicles.</p>
                        <br>
                        <a href="/customer/vehicles" class="btn btn-primary">Show All Vehicles</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />

    <script>
        function bookVehicle(regNo) {
            // Redirect to booking page with selected vehicle
            window.location.href = '/customer/book-vehicle?vehicleRegNo=' + regNo;
        }
    </script>
</body>
</html>
