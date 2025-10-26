<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - DriveGo</title>
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

        .profile-content {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .profile-banner {
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            padding: 2rem;
            text-align: center;
            border-bottom: 3px solid #0cc23c;
        }

        .profile-avatar-large {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0cc23c, #08a131);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: white;
            font-weight: bold;
            margin-bottom: 1rem;
            box-shadow: 0 4px 15px rgba(12, 194, 60, 0.4);
        }

        .profile-name {
            color: white;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .profile-email {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
        }

        .profile-details {
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

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-item {
            padding: 1.5rem;
            background: #f8f9ff;
            border-radius: 10px;
            border-left: 4px solid #0cc23c;
        }

        .info-label {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-label i {
            color: #0cc23c;
        }

        .info-value {
            color: #333;
            font-size: 1.1rem;
            font-weight: 500;
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

        .stats-section {
            background: #f8f9ff;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1.5rem;
            text-align: center;
        }

        .stat-item {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #0cc23c;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }

        /* Tab Navigation */
        .tab-navigation {
            display: flex;
            gap: 0;
            border-bottom: 2px solid #e0e0e0;
            margin-bottom: 2rem;
            background: #f8f9ff;
            border-radius: 10px 10px 0 0;
            overflow: hidden;
        }

        .tab-btn {
            flex: 1;
            padding: 1rem 2rem;
            background: transparent;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            color: #666;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .tab-btn:hover {
            background: rgba(12, 194, 60, 0.1);
            color: #0cc23c;
        }

        .tab-btn.active {
            background: #0cc23c;
            color: white;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Form Styles */
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

        .form-group input {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #0cc23c;
            box-shadow: 0 0 0 3px rgba(12, 194, 60, 0.1);
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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

            .profile-avatar-large {
                width: 100px;
                height: 100px;
                font-size: 2.5rem;
            }

            .profile-name {
                font-size: 1.5rem;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .tab-btn {
                padding: 0.8rem 1rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="customer_header.jsp" />

    <div class="container">
        <div class="page-header">
            <h1><i class="fas fa-user-circle"></i> My Profile</h1>
        </div>

        <div class="profile-content">
            <!-- Profile Banner -->
            <div class="profile-banner">
                <div class="profile-avatar-large">
                    <c:choose>
                        <c:when test="${not empty user.name}">${user.name.substring(0,1).toUpperCase()}</c:when>
                        <c:otherwise>U</c:otherwise>
                    </c:choose>
                </div>
                <div class="profile-name">
                    <c:choose>
                        <c:when test="${not empty user.name}">${user.name}</c:when>
                        <c:otherwise>Customer</c:otherwise>
                    </c:choose>
                </div>
                <div class="profile-email">
                    <c:choose>
                        <c:when test="${not empty user.email}">${user.email}</c:when>
                        <c:otherwise>customer@drivego.com</c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Tab Navigation -->
            <div class="tab-navigation">
                <button class="tab-btn active" onclick="switchTab('view')">
                    <i class="fas fa-eye"></i> View Profile
                </button>
                <button class="tab-btn" onclick="switchTab('edit')">
                    <i class="fas fa-edit"></i> Edit Profile
                </button>
                <button class="tab-btn" onclick="switchTab('password')">
                    <i class="fas fa-lock"></i> Change Password
                </button>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${errorMessage}
                </div>
            </c:if>

            <!-- View Profile Tab -->
            <div id="view-tab" class="tab-content active">
                <div class="profile-details">
                <!-- Personal Information -->
                <h2 class="section-title">
                    <i class="fas fa-user"></i>
                    Personal Information
                </h2>
                
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-user"></i>
                            Full Name
                        </div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${not empty user.name}">${user.name}</c:when>
                                <c:otherwise>Not provided</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-envelope"></i>
                            Email Address
                        </div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${not empty user.email}">${user.email}</c:when>
                                <c:otherwise>Not provided</c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-phone"></i>
                            Phone Number
                        </div>
                        <div class="info-value">+1 (555) 123-4567</div>
                    </div>

                    <div class="info-item">
                        <div class="info-label">
                            <i class="fas fa-id-card"></i>
                            Member Since
                        </div>
                        <div class="info-value">January 2024</div>
                    </div>
                </div>

                <!-- Booking Statistics -->
                <h2 class="section-title">
                    <i class="fas fa-chart-bar"></i>
                    Booking Statistics
                </h2>

                <div class="stats-section">
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-number">
                                <c:choose>
                                    <c:when test="${not empty totalBookings}">${totalBookings}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-label">Total Bookings</div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-number">
                                <c:choose>
                                    <c:when test="${not empty activeBookings}">${activeBookings}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-label">Active Bookings</div>
                        </div>

                        <div class="stat-item">
                            <div class="stat-number">
                                <c:choose>
                                    <c:when test="${not empty completedBookings}">${completedBookings}</c:when>
                                    <c:otherwise>0</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-label">Completed</div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="/customer/my-bookings" class="btn btn-primary">
                        <i class="fas fa-calendar"></i> View My Bookings
                    </a>
                    <a href="/customer/vehicles" class="btn btn-secondary">
                        <i class="fas fa-car"></i> Browse Vehicles
                    </a>
                </div>
            </div>
            </div>

            <!-- Edit Profile Tab -->
            <div id="edit-tab" class="tab-content">
                <div class="profile-details">
                    <h2 class="section-title">
                        <i class="fas fa-edit"></i>
                        Edit Profile
                    </h2>

                    <form action="/customer/profile/update" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="form-group">
                            <label for="firstName">
                                <i class="fas fa-user"></i>
                                First Name
                            </label>
                            <input type="text" id="firstName" name="firstName" 
                                   value="${user.firstName}" required>
                        </div>

                        <div class="form-group">
                            <label for="lastName">
                                <i class="fas fa-user"></i>
                                Last Name
                            </label>
                            <input type="text" id="lastName" name="lastName" 
                                   value="${user.lastName}" required>
                        </div>

                        <div class="form-group">
                            <label for="email">
                                <i class="fas fa-envelope"></i>
                                Email Address
                            </label>
                            <input type="email" id="email" name="email" 
                                   value="${user.email}" required>
                        </div>

                        <div class="form-group">
                            <label for="contactNum">
                                <i class="fas fa-phone"></i>
                                Phone Number
                            </label>
                            <input type="tel" id="contactNum" name="contactNum" 
                                   value="${user.contactNum}" required>
                        </div>

                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="switchTab('view')">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Change Password Tab -->
            <div id="password-tab" class="tab-content">
                <div class="profile-details">
                    <h2 class="section-title">
                        <i class="fas fa-lock"></i>
                        Change Password
                    </h2>

                    <form action="/customer/profile/change-password" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        
                        <div class="form-group">
                            <label for="currentPassword">
                                <i class="fas fa-key"></i>
                                Current Password
                            </label>
                            <input type="password" id="currentPassword" name="currentPassword" 
                                   required placeholder="Enter your current password">
                        </div>

                        <div class="form-group">
                            <label for="newPassword">
                                <i class="fas fa-lock"></i>
                                New Password
                            </label>
                            <input type="password" id="newPassword" name="newPassword" 
                                   required placeholder="Enter new password (min 8 characters)">
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">
                                <i class="fas fa-lock"></i>
                                Confirm New Password
                            </label>
                            <input type="password" id="confirmPassword" name="confirmPassword" 
                                   required placeholder="Re-enter new password">
                        </div>

                        <div class="action-buttons">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Change Password
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="switchTab('view')">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tab) {
            // Remove active class from all tabs and tab buttons
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
            
            // Add active class to selected tab
            if (tab === 'view') {
                document.querySelector('.tab-btn:nth-child(1)').classList.add('active');
                document.getElementById('view-tab').classList.add('active');
            } else if (tab === 'edit') {
                document.querySelector('.tab-btn:nth-child(2)').classList.add('active');
                document.getElementById('edit-tab').classList.add('active');
            } else if (tab === 'password') {
                document.querySelector('.tab-btn:nth-child(3)').classList.add('active');
                document.getElementById('password-tab').classList.add('active');
            }
        }

        // Client-side password validation
        document.querySelector('#password-tab form').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('New password and confirm password do not match!');
                return false;
            }
            
            if (newPassword.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long!');
                return false;
            }
        });
    </script>

    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />
</body>
</html>
