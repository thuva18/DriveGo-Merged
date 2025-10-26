<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveGo - Professional Car Management System</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- CSS Links -->
    <link rel="stylesheet" href="/css/style.css">
    
    <!-- Form Validation Styles -->
    <link rel="stylesheet" href="/WEB-INF/jsp/common/validation.css">

    <!-- External Libraries -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <!-- Multiple Chart.js CDN fallbacks -->
    <script>
        // Chart.js loading with multiple fallbacks
        (function() {
            var chartUrls = [
                'https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js',
                'https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.js',
                'https://unpkg.com/chart.js@4.4.0/dist/chart.umd.js'
            ];
            
            var currentIndex = 0;
            
            function loadChart() {
                if (currentIndex >= chartUrls.length) {
                    console.warn('All Chart.js CDNs failed, loading local fallback');
                    // Load local fallback
                    var fallbackScript = document.createElement('script');
                    fallbackScript.src = '/js/chart-fallback.js';
                    fallbackScript.onload = function() {
                        console.log('Chart.js fallback loaded successfully');
                        window.dispatchEvent(new CustomEvent('chartjs-loaded'));
                    };
                    fallbackScript.onerror = function() {
                        console.error('Even fallback Chart.js failed to load');
                    };
                    document.head.appendChild(fallbackScript);
                    return;
                }
                
                var script = document.createElement('script');
                script.src = chartUrls[currentIndex];
                script.onload = function() {
                    console.log('Chart.js loaded successfully from:', chartUrls[currentIndex]);
                    // Dispatch custom event when Chart.js is ready
                    window.dispatchEvent(new CustomEvent('chartjs-loaded'));
                };
                script.onerror = function() {
                    console.warn('Failed to load Chart.js from:', chartUrls[currentIndex]);
                    currentIndex++;
                    setTimeout(loadChart, 100); // Try next URL
                };
                document.head.appendChild(script);
            }
            
            loadChart();
        })();
    </script>
    
    <!-- Form Validation Script -->
    <script src="/WEB-INF/jsp/common/validation.js"></script>

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🚗</text></svg>">
</head>
<body>

<!-- Mobile Sidebar Overlay -->
<div class="sidebar-overlay" id="sidebarOverlay"></div>

<div class="app">
    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <a href="<c:url value='/dashboard'/>" class="sidebar-logo">
                <img src="/img/logo.png" alt="DriveGo" class="sidebar-logo-full">
            </a>
        </div>
        
        <nav class="nav">
            <div class="nav-section">
                <div class="nav-section-title">Main</div>
                <a href="<c:url value='/dashboard'/>" class="nav-link" data-page="dashboard">
                    <div class="nav-icon"><i class="fas fa-tachometer-alt"></i></div>
                    <span>Dashboard</span>
                </a>
            </div>

            <div class="nav-section">
                <div class="nav-section-title">Management</div>
                <a href="<c:url value='/vehicles'/>" class="nav-link" data-page="vehicles">
                    <div class="nav-icon"><i class="fas fa-car"></i></div>
                    <span>Vehicles</span>
                </a>
                <a href="<c:url value='/bookings'/>" class="nav-link" data-page="bookings">
                    <div class="nav-icon"><i class="fas fa-calendar-check"></i></div>
                    <span>Bookings</span>
                </a>
                <a href="<c:url value='/admin/users'/>" class="nav-link" data-page="users">
                    <div class="nav-icon"><i class="fas fa-users-cog"></i></div>
                    <span>User Management</span>
                </a>
                <a href="<c:url value='/admin/payments'/>" class="nav-link" data-page="payments">
                    <div class="nav-icon"><i class="fas fa-credit-card"></i></div>
                    <span>Payments</span>
                </a>
                <a href="<c:url value='/admin/contacts'/>" class="nav-link" data-page="contacts">
                    <div class="nav-icon"><i class="fas fa-envelope"></i></div>
                    <span>Messages</span>
                </a>
            </div>

            <div class="nav-section">
                <div class="nav-section-title">Analytics</div>
                <a href="<c:url value='/reports'/>" class="nav-link" data-page="reports">
                    <div class="nav-icon"><i class="fas fa-chart-line"></i></div>
                    <span>Reports</span>
                </a>
                <a href="<c:url value='/reports/manage'/>" class="nav-link" data-page="manage-reports">
                    <div class="nav-icon"><i class="fas fa-folder-open"></i></div>
                    <span>Manage Reports</span>
                </a>
            </div>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main">
        <!-- Top Header -->
        <header class="header">
            <div class="header-left">
                <button class="mobile-menu-btn" id="mobileMenuBtn">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="logo">
                    <img src="/img/logo.png" alt="DriveGo Logo" class="logo-image">
                    <span>DriveGo</span>
                </div>
            </div>
            
            <div class="header-actions">
                <div class="user-menu" id="userMenu">
                    <div class="user-avatar">
                        <i class="fas fa-user-circle"></i>
                    </div>
                    <span>Admin</span>
                    <i class="fas fa-chevron-down"></i>
                    
                    <!-- Dropdown Menu -->
                    <div class="user-dropdown" id="userDropdown">
                        <div class="user-dropdown-header">
                            <div class="user-dropdown-avatar">
                                <i class="fas fa-user-circle"></i>
                            </div>
                            <div class="user-dropdown-info">
                                <div class="user-dropdown-name">Administrator</div>
                                <div class="user-dropdown-email">admin@drivego.com</div>
                            </div>
                        </div>
                        <div class="user-dropdown-divider"></div>
                        <a href="<c:url value='/dashboard'/>" class="user-dropdown-item">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                        <a href="<c:url value='/profile'/>" class="user-dropdown-item">
                            <i class="fas fa-user"></i>
                            <span>Profile</span>
                        </a>
                        <a href="<c:url value='/settings'/>" class="user-dropdown-item">
                            <i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </a>
                        <div class="user-dropdown-divider"></div>
                        <form method="post" action="<c:url value='/logout'/>" style="margin: 0;">
                            <button type="submit" class="user-dropdown-item logout-btn">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Logout</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </header>

        <!-- Page Content -->
        <div class="main-content">
