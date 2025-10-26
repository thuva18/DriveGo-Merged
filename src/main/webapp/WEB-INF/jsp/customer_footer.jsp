<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style data-footer-theme="dark-professional-v3-force">
    /* FORCE OVERRIDE ALL FOOTER STYLES - Dark Professional Theme */
    
    /* Kill any existing footer styles */
    footer,
    .footer,
    .customer-footer,
    footer.customer-footer {
        all: unset !important;
        display: block !important;
    }
    
    /* Apply new dark theme - BLACK BACKGROUND */
    footer.customer-footer,
    .customer-footer {
        background: #000000 !important;
        background-color: #000000 !important;
        background-image: none !important;
        padding: 4rem 2rem 2rem !important;
        margin: 0 !important;
        margin-top: 0 !important;
        color: rgba(255, 255, 255, 0.8) !important;
        border-top: 2px solid rgba(8, 161, 49, 0.3) !important;
        box-shadow: none !important;
        text-align: left !important;
        width: 100% !important;
    }

    .footer-content {
        all: unset !important;
        max-width: 1200px !important;
        margin: 0 auto 3rem !important;
        display: grid !important;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)) !important;
        gap: 3rem !important;
        text-align: left !important;
    }
    
    .footer-section {
        all: unset !important;
        display: block !important;
    }

    .footer-section h3,
    .footer-section h4 {
        all: unset !important;
        display: block !important;
        color: #ffffff !important;
        font-size: 1.2rem !important;
        margin-bottom: 1.5rem !important;
        font-weight: 700 !important;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
    }

    .footer-section p {
        all: unset !important;
        display: block !important;
        color: rgba(255, 255, 255, 0.7) !important;
        line-height: 1.6 !important;
        margin-bottom: 0.75rem !important;
        font-size: 0.95rem !important;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
    }

    .footer-section ul {
        all: unset !important;
        display: block !important;
        list-style: none !important;
        padding: 0 !important;
        margin: 0 !important;
    }

    .footer-section ul li {
        all: unset !important;
        display: block !important;
        margin-bottom: 0.75rem !important;
    }

    .footer-section a,
    .footer-section ul li a {
        all: unset !important;
        color: rgba(255, 255, 255, 0.7) !important;
        text-decoration: none !important;
        transition: all 0.3s ease !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 0.5rem !important;
        cursor: pointer !important;
        font-size: 0.95rem !important;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
    }

    .footer-section a:hover,
    .footer-section ul li a:hover {
        color: #0cc23c !important;
        transform: translateX(5px) !important;
    }

    .footer-section i {
        color: #08a131 !important;
        font-size: 1rem !important;
    }

    .footer-bottom {
        all: unset !important;
        display: block !important;
        text-align: center !important;
        padding-top: 2rem !important;
        border-top: 1px solid rgba(255, 255, 255, 0.1) !important;
        color: rgba(255, 255, 255, 0.6) !important;
    }

    .footer-social {
        all: unset !important;
        display: flex !important;
        justify-content: center !important;
        gap: 1rem !important;
        margin-bottom: 1.5rem !important;
        flex-wrap: wrap !important;
    }

    .footer-social a {
        all: unset !important;
        width: 45px !important;
        height: 45px !important;
        border-radius: 50% !important;
        background: rgba(8, 161, 49, 0.2) !important;
        color: #0cc23c !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        text-decoration: none !important;
        transition: all 0.3s ease !important;
        border: 1px solid rgba(8, 161, 49, 0.3) !important;
        cursor: pointer !important;
    }

    .footer-social a:hover {
        background: linear-gradient(135deg, #08a131, #0cc23c) !important;
        color: #ffffff !important;
        transform: translateY(-3px) !important;
        box-shadow: 0 10px 20px rgba(8, 161, 49, 0.3) !important;
    }

    .footer-bottom p {
        all: unset !important;
        display: block !important;
        font-size: 0.95rem !important;
        margin: 0 !important;
        color: rgba(255, 255, 255, 0.6) !important;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif !important;
    }

    .footer-heart {
        color: #08a131 !important;
        animation: heartbeat 1.5s ease-in-out infinite !important;
    }

    @keyframes heartbeat {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.1); }
    }

    @media (max-width: 768px) {
        .footer-content {
            grid-template-columns: 1fr !important;
            gap: 2rem !important;
            text-align: center !important;
        }
        
        .footer-section a,
        .footer-section ul li a {
            justify-content: center !important;
        }
    }
</style>

<footer class="customer-footer">
    <div class="footer-content">
        <div class="footer-section">
            <h3><i class="fas fa-car"></i> DriveGo</h3>
            <p>Your trusted partner for premium car rental services. We provide quality vehicles and exceptional service to make every journey memorable.</p>
            <p><i class="fas fa-envelope"></i> info@drivego.com</p>
            <p><i class="fas fa-phone"></i> +94 11 234 5678</p>
            <p><i class="fas fa-map-marker-alt"></i> Colombo, Sri Lanka</p>
        </div>
        
        <div class="footer-section">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="/"><i class="fas fa-home"></i> Home</a></li>
                <li><a href="/customer/vehicles"><i class="fas fa-car"></i> Browse Vehicles</a></li>
                <li><a href="/customer/my-bookings"><i class="fas fa-calendar-check"></i> My Bookings</a></li>
                <li><a href="/customer/contact"><i class="fas fa-envelope"></i> Contact Us</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h3>Services</h3>
            <ul>
                <li><a href="#"><i class="fas fa-clock"></i> 24/7 Rental Service</a></li>
                <li><a href="#"><i class="fas fa-shield-alt"></i> Fully Insured</a></li>
                <li><a href="#"><i class="fas fa-map-marker-alt"></i> Multiple Locations</a></li>
                <li><a href="#"><i class="fas fa-check-circle"></i> Flexible Plans</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h3>Follow Us</h3>
            <div class="footer-social">
                <a href="#" aria-label="Facebook" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                <a href="#" aria-label="Twitter" title="Twitter"><i class="fab fa-twitter"></i></a>
                <a href="#" aria-label="Instagram" title="Instagram"><i class="fab fa-instagram"></i></a>
                <a href="#" aria-label="LinkedIn" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <ul>
                <li><a href="#"><i class="fas fa-file-alt"></i> Terms & Conditions</a></li>
                <li><a href="#"><i class="fas fa-shield-check"></i> Privacy Policy</a></li>
            </ul>
        </div>
    </div>
    
    <div class="footer-bottom">
        <p>&copy; 2025 DriveGo. All rights reserved. | Designed with <i class="fas fa-heart footer-heart"></i></p>
    </div>
</footer>