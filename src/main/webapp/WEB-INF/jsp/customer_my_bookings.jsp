<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - DriveGo</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            position: relative;
            z-index: 5;
        }

        .bookings-content {
            background: #f8f9fa;
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            border: 3px solid #08a131;
            position: relative;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            position: relative;
        }

        .page-header h1 {
            color: #2c2c2c;
            font-size: 2.5rem;
            margin-bottom: 1rem;
            font-weight: 700;
            background: linear-gradient(135deg, #000000, #333333);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .page-header p {
            color: #666666;
            font-size: 1.2rem;
        }

        .bookings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(450px, 1fr));
            gap: 2rem;
        }

        .booking-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            padding: 2rem;
            border-left: 6px solid;
            box-shadow: 0 8px 25px rgba(0, 255, 136, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .booking-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(0, 255, 136, 0.3), transparent);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .booking-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0, 255, 136, 0.2);
        }

        .booking-card:hover::before {
            transform: scaleX(1);
        }

        .booking-card.pending {
            border-color: #08a131;
        }

        .booking-card.confirmed {
            border-color: #00cc6a;
        }

        .booking-card.cancelled {
            border-color: #333333;
        }

        .booking-card.completed {
            border-color: #6c757d;
        }

        .booking-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .booking-id {
            font-weight: bold;
            color: #333;
            font-size: 1.1rem;
        }

        .booking-status {
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .status-completed {
            background-color: #e2e3e5;
            color: #383d41;
        }

        .booking-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-item i {
            color: #667eea;
            width: 16px;
            text-align: center;
        }

        .detail-value {
            font-weight: 600;
        }

        .booking-notes {
            background-color: #f8f9fa;
            padding: 1rem;
            border-radius: 10px;
            margin-top: 1rem;
            border-left: 3px solid #667eea;
        }

        .booking-notes h4 {
            margin-bottom: 0.5rem;
            color: #333;
        }

        .no-bookings {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .no-bookings i {
            font-size: 4rem;
            margin-bottom: 1rem;
            color: #ccc;
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
            transition: all 0.3s ease;
            margin-top: 1.5rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #08a131 0%, #0cc23c 100%);
            color: #000000;
            box-shadow: 0 6px 20px rgba(0, 255, 136, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0, 255, 136, 0.5);
            color: #000000;
            background: linear-gradient(135deg, #00cc6a, #00a855);
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 0 0.5rem;
            }

            .bookings-content {
                padding: 2rem 1.5rem;
            }

            .bookings-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .booking-details {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 2rem;
            }

            .booking-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="customer_header.jsp" />

    <div class="container">
        <div class="bookings-content">
            <div class="page-header">
                <h1><i class="fas fa-calendar-check"></i> My Bookings</h1>
                <p>Track and manage your vehicle bookings</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div style="background: #d4edda; color: #155724; padding: 1rem; border-radius: 10px; margin-bottom: 2rem; border: 1px solid #c3e6cb;">
                    <i class="fas fa-check-circle"></i> ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 10px; margin-bottom: 2rem; border: 1px solid #f5c6cb;">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="no-bookings">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Bookings Found</h3>
                    <p>You haven't made any bookings yet. Start by browsing our available vehicles!</p>
                    <a href="/customer/vehicles" class="btn btn-primary">
                        <i class="fas fa-car"></i> Browse Vehicles
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bookings-grid">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card ${booking.status.toLowerCase()}">
                            <div class="booking-header">
                                <div class="booking-id">
                                    <i class="fas fa-hashtag"></i> Booking #${booking.id}
                                </div>
                                <div class="booking-status status-${booking.status.toLowerCase()}">
                                    ${booking.status}
                                </div>
                            </div>

                            <div class="booking-details">
                                <div class="detail-item">
                                    <i class="fas fa-car"></i>
                                    <span>Vehicle: <span class="detail-value">${booking.vehicleRegNo}</span></span>
                                </div>
                                <c:if test="${not empty booking.pickupDate}">
                                    <div class="detail-item">
                                        <i class="fas fa-calendar-plus"></i>
                                        <span>Pickup: <span class="detail-value">
                                            <fmt:formatDate value="${booking.pickupDate}" pattern="MMM dd, yyyy" />
                                        </span></span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty booking.returnDate}">
                                    <div class="detail-item">
                                        <i class="fas fa-calendar-minus"></i>
                                        <span>Return: <span class="detail-value">
                                            <fmt:formatDate value="${booking.returnDate}" pattern="MMM dd, yyyy" />
                                        </span></span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty booking.pickupLocation}">
                                    <div class="detail-item">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>Location: <span class="detail-value">${booking.pickupLocation}</span></span>
                                    </div>
                                </c:if>
                                <div class="detail-item">
                                    <i class="fas fa-user"></i>
                                    <span>Contact: <span class="detail-value">${booking.contactPersonName}</span></span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-phone"></i>
                                    <span>Phone: <span class="detail-value">${booking.contactNumber}</span></span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-clock"></i>
                                    <span>Booked: <span class="detail-value">
                                        <fmt:formatDate value="${booking.createdAt}" pattern="MMM dd, yyyy HH:mm" />
                                    </span></span>
                                </div>
                            </div>

                            <c:if test="${not empty booking.additionalNotes}">
                                <div class="booking-notes">
                                    <h4><i class="fas fa-sticky-note"></i> Additional Notes</h4>
                                    <p>${booking.additionalNotes}</p>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        </div>
    </div>

    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />
</body>
</html>