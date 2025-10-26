<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style data-cache-bust="header-no-border-fixed-v11">
    /* CRITICAL: Force reset all CSS that might be applying green colors */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    /* Add padding to body to prevent content from hiding under fixed header */
    body {
        padding-top: 80px !important;
    }
    
    /* FORCE B    /* Progressive reveal animation for elements - balanced 1.5 second duration */
    .fade-in-up {
        animation: fadeInUp 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
        opacity: 0;
        transform: translateY(30px);
    }
    
    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* Staggered animations for lists and grids - balanced 1.5 second duration */
    .stagger-animation > * {
        animation: fadeInUp 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
        opacity: 0;
        transform: translateY(20px);
    }
    
    /* Header styles - FIXED POSITION - NO GREEN BORDER */
    .header,
    header,
    .customer-header,
    nav.header,
    div.header {
        display: flex !important;
        justify-content: space-between !important;
        align-items: center !important;
        padding: 1rem 2rem !important;
        background: #000000 !important;
        background-color: #000000 !important;
        background-image: none !important;
        border: none !important;
        border-bottom: none !important;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5) !important;
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        right: 0 !important;
        z-index: 9999 !important;
        width: 100% !important;
        margin: 0 !important;
        color: #ffffff !important;
    }

    /* Logo styles */
    .logo {
        display: flex !important;
        align-items: center !important;
        transition: transform 0.3s ease !important;
    }

    .logo:hover {
        transform: scale(1.05) !important;
    }

    .logo img {
        height: 45px !important;
        width: auto !important;
        filter: brightness(1.1) !important;
    }

    /* Navigation menu */
    .nav-menu {
        display: flex !important;
        gap: 2rem !important;
        align-items: center !important;
    }

    .nav-menu a {
        color: #ffffff !important;
        text-decoration: none !important;
        padding: 0.75rem 1.5rem !important;
        border-radius: 25px !important;
        transition: all 0.3s ease !important;
        font-weight: 600 !important;
        position: relative !important;
        overflow: hidden !important;
        background: transparent !important;
    }

    .nav-menu a:hover {
        background: linear-gradient(135deg, rgba(8, 161, 49, 0.15), rgba(12, 194, 60, 0.2)) !important;
        color: #0cc23c !important;
        transform: translateY(-1px) scale(1.02) !important;
        box-shadow: 0 3px 12px rgba(8, 161, 49, 0.15) !important;
        backdrop-filter: blur(10px) !important;
        border: 1px solid rgba(12, 194, 60, 0.3) !important;
    }

    /* User menu section */
    .user-menu {
        display: flex !important;
        align-items: center !important;
        gap: 1rem !important;
        position: relative !important;
    }
    
    /* Profile Dropdown */
    .profile-dropdown {
        position: relative !important;
        display: inline-block !important;
    }
    
    .profile-btn {
        background: linear-gradient(135deg, #0cc23c, #08a131) !important;
        color: #ffffff !important;
        border: none !important;
        padding: 0.75rem 1.5rem !important;
        border-radius: 25px !important;
        cursor: pointer !important;
        font-weight: 600 !important;
        transition: all 0.3s ease !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 0.5rem !important;
        box-shadow: 0 4px 15px rgba(12, 194, 60, 0.3) !important;
    }
    
    .profile-btn:hover {
        background: linear-gradient(135deg, #0cc23c, #08a131) !important;
        transform: translateY(-1px) scale(1.02) !important;
        box-shadow: 0 4px 16px rgba(12, 194, 60, 0.25) !important;
        filter: brightness(1.05) !important;
    }
    
    .dropdown-menu {
        display: none !important;
        position: absolute !important;
        right: 0 !important;
        top: calc(100% + 10px) !important;
        background: #ffffff !important;
        min-width: 220px !important;
        border-radius: 12px !important;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2) !important;
        z-index: 10000 !important;
        overflow: hidden !important;
        border: 1px solid #e5e5e5 !important;
    }
    
    .dropdown-menu.show {
        display: block !important;
        animation: slideDown 0.3s ease !important;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .dropdown-menu a,
    .dropdown-menu button {
        all: unset !important;
        display: flex !important;
        align-items: center !important;
        gap: 0.75rem !important;
        padding: 0.875rem 1.25rem !important;
        color: #2c2c2c !important;
        text-decoration: none !important;
        transition: all 0.2s ease !important;
        cursor: pointer !important;
        width: 100% !important;
        box-sizing: border-box !important;
        font-size: 0.95rem !important;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
    }
    
    .dropdown-menu a:hover,
    .dropdown-menu button:hover {
        background: #f0f9f4 !important;
        color: #08a131 !important;
        padding-left: 1.5rem !important;
    }
    
    .dropdown-menu i {
        width: 18px !important;
        text-align: center !important;
        color: #08a131 !important;
    }
    
    .dropdown-divider {
        height: 1px !important;
        background: #e5e5e5 !important;
        margin: 0.5rem 0 !important;
    }

    /* Logout and login buttons */
    .logout-btn,
    .login-btn {
        background: linear-gradient(135deg, #0cc23c, #08a131) !important;
        color: #ffffff !important;
        border: none !important;
        padding: 0.75rem 1.5rem !important;
        border-radius: 25px !important;
        cursor: pointer !important;
        font-weight: 600 !important;
        transition: all 0.3s ease !important;
        text-decoration: none !important;
        display: inline-block !important;
        box-shadow: 0 4px 15px rgba(12, 194, 60, 0.3) !important;
        margin-left: 0.5rem !important;
    }

    .logout-btn:hover,
    .login-btn:hover {
        background: linear-gradient(135deg, #08a131, #0a6e24) !important;
        transform: translateY(-2px) !important;
        box-shadow: 0 6px 20px rgba(8, 161, 49, 0.4) !important;
    }

    /* Mobile responsive */
    @media (max-width: 768px) {
        .header {
            flex-direction: column !important;
            gap: 1rem !important;
            padding: 1rem !important;
        }

        .nav-menu {
            flex-wrap: wrap !important;
            justify-content: center !important;
        }

        .nav-menu a {
            font-size: 0.9rem !important;
        }
    }
    
    /* ABSOLUTE OVERRIDE - REMOVE ANY POTENTIAL GREEN BACKGROUND */
    html body .header,
    html body header.header,
    html body nav.header,
    body > .header,
    body header,
    .navbar,
    nav {
        background: #000000 !important;
        background-color: #000000 !important;
        background-image: none !important;
    }
    
    /* Remove any inherited styles */
    .header * {
        color: inherit !important;
    }
    
    /* Kill any external stylesheets that might interfere */
    .header {
        background: #000000 !important;
        background-color: #000000 !important;
        background-image: none !important;
        border: none !important;
        border-bottom: none !important;
    }
    
    /* PAGE TRANSITION ANIMATIONS */
    .page-container {
        animation: pageSlideIn 0.5s ease-out;
    }
    
    @keyframes pageSlideIn {
        from {
            opacity: 0;
            transform: translateY(15px) scale(0.98);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }
    
    @keyframes pageFadeIn {
        from {
            opacity: 0;
            filter: blur(1px);
        }
        to {
            opacity: 1;
            filter: blur(0);
        }
    }
    
    @keyframes pageSlideFromRight {
        from {
            opacity: 0;
            transform: translateX(20px) scale(0.98);
        }
        to {
            opacity: 1;
            transform: translateX(0) scale(1);
        }
    }
    
    @keyframes pageSlideFromLeft {
        from {
            opacity: 0;
            transform: translateX(-20px) scale(0.98);
        }
        to {
            opacity: 1;
            transform: translateX(0) scale(1);
        }
    }
    
    @keyframes gentlePulse {
        0%, 100% {
            transform: scale(1);
            opacity: 1;
        }
        50% {
            transform: scale(1.02);
            opacity: 0.9;
        }
    }
    
    @keyframes floatUp {
        from {
            opacity: 0;
            transform: translateY(30px) rotate(-1deg);
        }
        to {
            opacity: 1;
            transform: translateY(0) rotate(0deg);
        }
    }
    
    /* Apply modern animations to main content areas - balanced 1.5 second duration */
    body {
        animation: pageFadeIn 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }
    
    .container {
        animation: pageSlideIn 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }
    
    .hero {
        animation: floatUp 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }
    
    .features {
        animation: pageSlideFromRight 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }
    
    .contact-content,
    .vehicle-grid,
    .booking-container {
        animation: pageSlideFromLeft 1.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    }
    
    /* Smooth transitions for interactive elements */
    .nav-menu a {
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        position: relative !important;
        overflow: hidden !important;
    }
    
    .nav-menu a:hover {
        transform: translateY(-2px) scale(1.05) !important;
        box-shadow: 0 8px 25px rgba(8, 161, 49, 0.3) !important;
    }
    
    .nav-menu a::before {
        content: '' !important;
        position: absolute !important;
        top: 0 !important;
        left: -100% !important;
        width: 100% !important;
        height: 100% !important;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent) !important;
        transition: left 0.6s ease !important;
    }
    
    .nav-menu a:hover::before {
        left: 100% !important;
    }
    
    /* Button animations */
    .btn, .login-btn, .logout-btn {
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        position: relative !important;
        overflow: hidden !important;
    }
    
    .btn:hover, .login-btn:hover, .logout-btn:hover {
        transform: translateY(-3px) scale(1.05) !important;
    }
    
    /* Modern Loading transition overlay */
    .page-transition-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(248, 250, 252, 0.98));
        backdrop-filter: blur(10px);
        z-index: 999999;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        visibility: hidden;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    .page-transition-overlay.active {
        opacity: 1;
        visibility: visible;
    }
    
    .page-transition-spinner {
        width: 40px;
        height: 40px;
        position: relative;
    }
    
    .page-transition-spinner::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border: 3px solid transparent;
        border-top: 3px solid #6366f1;
        border-right: 3px solid #8b5cf6;
        border-radius: 50%;
        animation: modernSpin 1.2s cubic-bezier(0.4, 0, 0.2, 1) infinite;
    }
    
    .page-transition-spinner::after {
        content: '';
        position: absolute;
        top: 6px;
        left: 6px;
        width: calc(100% - 12px);
        height: calc(100% - 12px);
        border: 2px solid transparent;
        border-bottom: 2px solid #06b6d4;
        border-left: 2px solid #10b981;
        border-radius: 50%;
        animation: modernSpin 0.8s cubic-bezier(0.4, 0, 0.2, 1) infinite reverse;
    }
    
    @keyframes modernSpin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    /* Modern Form and Button Enhancements */
    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="number"],
    input[type="date"],
    input[type="time"],
    select,
    textarea {
        transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
        border: 2px solid rgba(8, 161, 49, 0.2) !important;
        border-radius: 8px !important;
        padding: 12px 16px !important;
        font-size: 14px !important;
    }
    
    input[type="text"]:focus,
    input[type="email"]:focus,
    input[type="password"]:focus,
    input[type="number"]:focus,
    input[type="date"]:focus,
    input[type="time"]:focus,
    select:focus,
    textarea:focus {
        border-color: #0cc23c !important;
        box-shadow: 0 0 0 3px rgba(12, 194, 60, 0.1) !important;
        transform: translateY(-1px) !important;
        outline: none !important;
    }
    
    .btn,
    button:not(.profile-btn):not(.dropdown-menu button) {
        transition: all 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
        border-radius: 8px !important;
        padding: 12px 24px !important;
        font-weight: 600 !important;
        position: relative !important;
        overflow: hidden !important;
    }
    
    .btn:hover,
    button:not(.profile-btn):not(.dropdown-menu button):hover {
        transform: translateY(-2px) !important;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15) !important;
    }
    
    .btn-primary,
    .btn-success {
        background: linear-gradient(135deg, #0cc23c, #08a131) !important;
        border: none !important;
        color: white !important;
    }
    
    .btn-primary:hover,
    .btn-success:hover {
        background: linear-gradient(135deg, #08a131, #0a6e24) !important;
        box-shadow: 0 6px 20px rgba(12, 194, 60, 0.3) !important;
    }
    
    /* Card hover effects */
    .card,
    .vehicle-card,
    .booking-card {
        transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94) !important;
        border-radius: 12px !important;
    }
    
    .card:hover,
    .vehicle-card:hover,
    .booking-card:hover {
        transform: translateY(-5px) scale(1.02) !important;
        box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15) !important;
    }
    
    /* Progressive reveal animation for elements - 2.5 second duration */
    .fade-in-up {
        animation: fadeInUp 2.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
        opacity: 0;
        transform: translateY(30px);
    }
    
    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    /* Staggered animations for lists and grids - 2.5 second duration */
    .stagger-animation > * {
        animation: fadeInUp 2.5s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
        opacity: 0;
        transform: translateY(20px);
    }
    
    .stagger-animation > *:nth-child(1) { animation-delay: 0.2s; }
    .stagger-animation > *:nth-child(2) { animation-delay: 0.3s; }
    .stagger-animation > *:nth-child(3) { animation-delay: 0.4s; }
    .stagger-animation > *:nth-child(4) { animation-delay: 0.5s; }
    .stagger-animation > *:nth-child(5) { animation-delay: 0.6s; }
    .stagger-animation > *:nth-child(6) { animation-delay: 0.7s; }
</style>

<header class="header customer-header">
    <div class="logo">
        <img src="/img/drive gow_.png" alt="DriveGo Logo">
    </div>
    
    <nav class="nav-menu">
        <a href="/"><i class="fa-solid fa-home"></i> Home</a>
        <a href="/customer/vehicles"><i class="fa-solid fa-car"></i> Browse Vehicles</a>
        <a href="/customer/my-bookings"><i class="fa-solid fa-calendar-check"></i> My Bookings</a>
        <a href="/customer/contact"><i class="fa-solid fa-envelope"></i> Contact Us</a>
    </nav>

    <div class="user-menu">
        <c:choose>
            <c:when test="${not empty user}">
                <div class="profile-dropdown">
                    <button class="profile-btn" onclick="toggleDropdown()">
                        <i class="fas fa-user-circle"></i>
                        ${user.name}
                        <i class="fas fa-chevron-down" style="font-size: 0.8rem;"></i>
                    </button>
                    <div class="dropdown-menu" id="profileDropdown">
                        <a href="/customer/profile">
                            <i class="fas fa-user"></i>
                            View Profile
                        </a>
                        <a href="/customer/profile?edit=true">
                            <i class="fas fa-edit"></i>
                            Edit Profile
                        </a>
                        <a href="/customer/profile?section=password">
                            <i class="fas fa-key"></i>
                            Change Password
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="/customer/my-bookings">
                            <i class="fas fa-calendar-check"></i>
                            My Bookings
                        </a>
                        <div class="dropdown-divider"></div>
                        <form action="/logout" method="post" style="all: unset; width: 100%; margin: 0;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" style="all: unset; display: flex !important; align-items: center !important; gap: 0.75rem !important; padding: 0.875rem 1.25rem !important; color: #2c2c2c !important; cursor: pointer !important; width: 100% !important; box-sizing: border-box !important; font-size: 0.95rem !important; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important; transition: all 0.2s ease !important;">
                                <i class="fas fa-sign-out-alt" style="width: 18px !important; text-align: center !important; color: #08a131 !important;"></i>
                                Logout
                            </button>
                        </form>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <a href="/login" class="login-btn"><i class="fa-solid fa-sign-in-alt"></i> Log in</a>
                <a href="/register" class="login-btn"><i class="fa-solid fa-user-plus"></i> Sign up</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<!-- Form Validation Styles and Scripts -->
<link rel="stylesheet" href="/WEB-INF/jsp/common/validation.css">
<script src="/WEB-INF/jsp/common/validation.js"></script>

<script>
    // Toggle dropdown menu
    function toggleDropdown() {
        const dropdown = document.getElementById('profileDropdown');
        dropdown.classList.toggle('show');
    }
    
    // Close dropdown when clicking outside
    window.addEventListener('click', function(event) {
        if (!event.target.matches('.profile-btn') && !event.target.closest('.profile-btn')) {
            const dropdowns = document.getElementsByClassName('dropdown-menu');
            for (let i = 0; i < dropdowns.length; i++) {
                dropdowns[i].classList.remove('show');
            }
        }
    });
    
    // PAGE TRANSITION ANIMATIONS
    document.addEventListener('DOMContentLoaded', function() {
        // Create transition overlay
        const overlay = document.createElement('div');
        overlay.className = 'page-transition-overlay';
        overlay.innerHTML = '<div class="page-transition-spinner"></div>';
        document.body.appendChild(overlay);
        
        // Animate page elements on load - balanced 1.5 second duration with moderate delays
        const animateElements = document.querySelectorAll('.container, .hero, .features, .contact-content, .vehicle-grid, .booking-container');
        animateElements.forEach((element, index) => {
            element.style.animationDelay = (index * 0.1) + 's';
        });
        
        // Modern smooth page transitions for navigation links
        const navLinks = document.querySelectorAll('.nav-menu a, .btn, .logo');
        navLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                
                // Skip transition for external links, anchors, and form submissions
                if (!href || href.startsWith('#') || href.startsWith('http') || href.startsWith('mailto') || this.getAttribute('target')) {
                    return;
                }
                
                // Skip transition for current page
                if (href === window.location.pathname || href === window.location.href) {
                    return;
                }
                
                e.preventDefault();
                
                // Add subtle loading state to clicked element
                this.style.transform = 'scale(0.98)';
                this.style.opacity = '0.7';
                
                // Show modern transition overlay
                overlay.classList.add('active');
                
                // Navigate after 1.5 second delay to match animation
                setTimeout(() => {
                    window.location.href = href;
                }, 1500);
            });
        });
        
        // Hide overlay when page loads with smooth transition
        window.addEventListener('load', function() {
            setTimeout(() => {
                overlay.classList.remove('active');
                // Add stagger animations to key elements - balanced 1.5 second duration with moderate delays
                const staggerElements = document.querySelectorAll('.container, .hero, .card, .feature-card');
                staggerElements.forEach((el, index) => {
                    if (el) {
                        el.classList.add('fade-in-up');
                        el.style.animationDelay = (index * 0.1) + 's';
                    }
                });
            }, 50);
        });
        
        // Add stagger animation to cards and elements - balanced 1.5 second duration
        const cards = document.querySelectorAll('.feature-card, .stat-card, .step-card, .vehicle-card, .message-item');
        cards.forEach((card, index) => {
            card.style.animation = `pageSlideIn 1.5s ease-out ${(index * 0.1)}s both`;
        });
        
        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    });
    
    // Add entrance animation to dynamically loaded content
    function animateNewContent(element) {
        if (element) {
            element.style.animation = 'pageSlideIn 0.5s ease-out';
        }
    }
    
    // Modern Intersection Observer for subtle scroll animations
    const observerOptions = {
        threshold: 0.15,
        rootMargin: '0px 0px -30px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in-up');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);
    
    // Enhanced parallax scroll effect for modern feel
    let ticking = false;
    function updateScrollAnimations() {
        const scrolled = window.pageYOffset;
        const rate = scrolled * -0.3;
        
        // Subtle parallax for hero backgrounds
        const heroElements = document.querySelectorAll('.hero, .banner');
        heroElements.forEach(el => {
            if (el) {
                el.style.transform = `translateY(${rate}px)`;
            }
        });
        
        ticking = false;
    }
    
    window.addEventListener('scroll', function() {
        if (!ticking) {
            requestAnimationFrame(updateScrollAnimations);
            ticking = true;
        }
    });
    
    // Observe elements for modern scroll animations
    document.addEventListener('DOMContentLoaded', function() {
        const elementsToAnimate = document.querySelectorAll('.section-header, .contact-info-item, .vehicle-item, .feature-card, .card');
        elementsToAnimate.forEach(el => observer.observe(el));
    });
</script>