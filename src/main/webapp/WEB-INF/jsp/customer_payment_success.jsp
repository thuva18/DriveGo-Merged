<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .success-container {
            max-width: 600px;
            width: 100%;
            background: white;
            border-radius: 1.5rem;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
            padding: 3rem;
            text-align: center;
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #22c55e 0%, #16a34a 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            animation: scaleIn 0.5s ease 0.2s backwards;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .success-icon i {
            font-size: 3.5rem;
            color: white;
        }

        .success-title {
            font-size: 2rem;
            color: #15803d;
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .success-message {
            font-size: 1.1rem;
            color: #64748b;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .payment-details {
            background: #f8fafb;
            border-radius: 1rem;
            padding: 1.5rem;
            margin: 2rem 0;
            text-align: left;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #64748b;
            font-weight: 600;
        }

        .detail-value {
            color: #1e293b;
            font-weight: 600;
        }

        .redirect-info {
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            border-radius: 0.75rem;
            padding: 1rem;
            margin: 2rem 0;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .redirect-info i {
            color: #16a34a;
            font-size: 1.2rem;
        }

        .redirect-info p {
            color: #15803d;
            font-weight: 600;
            margin: 0;
        }

        .countdown {
            font-size: 1.5rem;
            color: #16a34a;
            font-weight: 700;
        }

        .btn {
            display: inline-block;
            padding: 1rem 2rem;
            border-radius: 0.75rem;
            font-size: 1.1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            margin: 0.5rem;
        }

        .btn-primary {
            background: #16a34a;
            color: white;
        }

        .btn-primary:hover {
            background: #15803d;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(22, 163, 74, 0.3);
        }

        .btn-secondary {
            background: #64748b;
            color: white;
        }

        .btn-secondary:hover {
            background: #475569;
        }

        .checkmark-circle {
            stroke-dasharray: 166;
            stroke-dashoffset: 166;
            animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) 0.3s forwards;
        }

        @keyframes stroke {
            100% {
                stroke-dashoffset: 0;
            }
        }

        .checkmark {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            display: block;
            stroke-width: 3;
            stroke: #fff;
            stroke-miterlimit: 10;
            margin: 10% auto;
            box-shadow: inset 0px 0px 0px #16a34a;
            animation: fill 0.4s ease-in-out 0.5s forwards, scale 0.3s ease-in-out 0.9s both;
        }

        @keyframes scale {
            0%, 100% {
                transform: none;
            }
            50% {
                transform: scale3d(1.1, 1.1, 1);
            }
        }

        @keyframes fill {
            100% {
                box-shadow: inset 0px 0px 0px 30px #16a34a;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">
            <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none"/>
                <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
            </svg>
        </div>

        <h1 class="success-title">Payment Successful!</h1>
        <p class="success-message">
            Your payment has been processed successfully. Your booking is now confirmed and you will receive a confirmation email shortly.
        </p>

        <c:if test="${not empty bookingId}">
            <div class="payment-details">
                <div class="detail-row">
                    <span class="detail-label">Booking ID:</span>
                    <span class="detail-value">#BK-${bookingId}</span>
                </div>
                <c:if test="${not empty paymentMethod}">
                    <div class="detail-row">
                        <span class="detail-label">Payment Method:</span>
                        <span class="detail-value">
                            <c:choose>
                                <c:when test="${paymentMethod == 'CASH'}">Cash</c:when>
                                <c:when test="${paymentMethod == 'CREDIT_CARD'}">Credit Card</c:when>
                                <c:when test="${paymentMethod == 'DEBIT_CARD'}">Debit Card</c:when>
                                <c:when test="${paymentMethod == 'BANK_TRANSFER'}">Bank Transfer</c:when>
                                <c:otherwise>${paymentMethod}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </c:if>
                <c:if test="${not empty amount}">
                    <div class="detail-row">
                        <span class="detail-label">Amount Paid:</span>
                        <span class="detail-value">LKR <fmt:formatNumber value="${amount}" type="number" minFractionDigits="2"/></span>
                    </div>
                </c:if>
            </div>
        </c:if>

        <div class="redirect-info">
            <i class="fas fa-info-circle"></i>
            <p>Redirecting to My Bookings in <span class="countdown" id="countdown">5</span> seconds...</p>
        </div>

        <div>
            <a href="/customer/my-bookings" class="btn btn-primary">
                <i class="fas fa-list"></i> View My Bookings
            </a>
            <a href="/customer/vehicles" class="btn btn-secondary">
                <i class="fas fa-car"></i> Book Another Vehicle
            </a>
        </div>
    </div>

    <script>
        // Countdown and auto-redirect
        let seconds = 5;
        const countdownElement = document.getElementById('countdown');
        
        const countdown = setInterval(function() {
            seconds--;
            countdownElement.textContent = seconds;
            
            if (seconds <= 0) {
                clearInterval(countdown);
                window.location.href = '/customer/my-bookings';
            }
        }, 1000);
    </script>
</body>
</html>
