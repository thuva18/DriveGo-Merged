<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 50%, #000000 100%);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            color: #ffffff;
        }

        /* Floating particles animation */
        .particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .particle {
            position: absolute;
            background: linear-gradient(45deg, #08a131, #0cc23c);
            border-radius: 50%;
            opacity: 0.1;
            animation: float 15s infinite ease-in-out;
        }

        .particle:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
            animation-duration: 20s;
        }

        .particle:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 15%;
            animation-delay: 7s;
            animation-duration: 25s;
        }

        .particle:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 20%;
            animation-delay: 3s;
            animation-duration: 18s;
        }

        .particle:nth-child(4) {
            width: 90px;
            height: 90px;
            top: 10%;
            right: 30%;
            animation-delay: 12s;
            animation-duration: 22s;
        }

        @keyframes float {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg);
                opacity: 0.1;
            }
            50% { 
                transform: translateY(-20px) rotate(180deg);
                opacity: 0.2;
            }
        }

        /* Hero section with modern animations */
        .hero-section {
            padding: 8rem 2rem 6rem;
            text-align: center;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 5;
            animation: slideUp 1s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero-section h1 {
            font-size: 4.5rem;
            margin-bottom: 1.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #08a131, #0cc23c, #0a6e24);
            background-size: 200% 200%;
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradientShift 3s ease-in-out infinite alternate;
            position: relative;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            100% { background-position: 100% 50%; }
        }

        .hero-section h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 4px;
            background: linear-gradient(90deg, #08a131, #0cc23c);
            animation: lineExpand 2s ease-out 0.5s forwards;
        }

        @keyframes lineExpand {
            to { width: 200px; }
        }

        .hero-section p {
            font-size: 1.4rem;
            margin-bottom: 3rem;
            color: #555;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.7;
            animation: fadeIn 1.5s ease-out 0.3s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .cta-buttons {
            display: flex;
            gap: 2rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 4rem;
            animation: fadeIn 1.5s ease-out 0.6s both;
        }

        .cta-btn {
            padding: 1.2rem 2.5rem;
            background: linear-gradient(135deg, #08a131, #0cc23c);
            color: #ffffff;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.4s ease;
            box-shadow: 0 8px 25px rgba(8, 161, 49, 0.3);
            position: relative;
            overflow: hidden;
            border: none;
            cursor: pointer;
        }

        .cta-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .cta-btn:hover::before {
            left: 100%;
        }

        .cta-btn:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(8, 161, 49, 0.4);
            background: linear-gradient(135deg, #0cc23c, #08a131);
        }

        .cta-btn.secondary {
            background: linear-gradient(135deg, #0a6e24, #08a131);
            box-shadow: 0 8px 25px rgba(10, 110, 36, 0.3);
        }

        .cta-btn.secondary:hover {
            background: linear-gradient(135deg, #08a131, #0a6e24);
            box-shadow: 0 15px 35px rgba(10, 110, 36, 0.4);
        }

        /* Features section with modern cards */
        .features-section {
            background: #ffffff;
            padding: 8rem 2rem;
            position: relative;
            z-index: 5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
        }

        .section-title {
            text-align: center;
            font-size: 3.5rem;
            color: #2c2c2c;
            margin-bottom: 4rem;
            font-weight: 800;
            position: relative;
            animation: fadeIn 1s ease-out 0.8s both;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            border-radius: 2px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 3rem;
            margin-bottom: 6rem;
            animation: fadeIn 1.5s ease-out 1s both;
        }

        .feature-card {
            background: #ffffff;
            padding: 3.5rem 2.5rem;
            border-radius: 20px;
            text-align: center;
            transition: all 0.4s ease;
            border: 2px solid #f0f0f0;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(8, 161, 49, 0.1), transparent);
            transition: left 0.6s ease;
        }

        .feature-card:hover::before {
            left: 100%;
        }

        .feature-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 25px 50px rgba(8, 161, 49, 0.15);
            border-color: #08a131;
        }

        .feature-icon {
            font-size: 4rem;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #08a131, #0cc23c);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            transition: all 0.4s ease;
            display: block;
        }

        .feature-card:hover .feature-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .feature-card h3 {
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
            color: #2c2c2c;
            font-weight: 700;
            transition: color 0.3s ease;
        }

        .feature-card:hover h3 {
            color: #08a131;
        }

        .feature-card p {
            font-size: 1.1rem;
            color: #666666;
            line-height: 1.7;
        }

        /* Statistics section with modern counters */
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 3rem;
            margin-top: 6rem;
            animation: fadeIn 1.5s ease-out 1.2s both;
        }

        .stat-card {
            background: linear-gradient(135deg, #08a131, #0a6e24);
            padding: 3.5rem 2.5rem;
            border-radius: 25px;
            text-align: center;
            color: white;
            box-shadow: 0 20px 40px rgba(8, 161, 49, 0.2);
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            transition: all 0.6s ease;
            transform: scale(0);
        }

        .stat-card:hover::before {
            transform: scale(1);
        }

        .stat-card:hover {
            transform: scale(1.05) rotate(2deg);
            box-shadow: 0 25px 50px rgba(8, 161, 49, 0.3);
        }

        .stat-number {
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 1rem;
            color: #ffffff;
            position: relative;
            z-index: 2;
        }

        .stat-label {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            z-index: 2;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 3rem;
            }
            
            .hero-section p {
                font-size: 1.2rem;
            }
            
            .cta-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .section-title {
                font-size: 2.5rem;
            }
            
            .features-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-section {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
        }
    </style>
</head>
<body>
    <!-- Animated particles background -->
    <div class="particles">
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
        <div class="particle"></div>
    </div>

    <jsp:include page="customer_header.jsp" />

    <main>
        <!-- Hero Section -->
        <section class="hero-section">
            <h1>Drive Your Dreams</h1>
            <p>Experience premium car rentals with unmatched service, competitive prices, and a fleet that brings your journey to life.</p>
            
            <div class="cta-buttons">
                <a href="<c:url value='/customer/vehicles'/>" class="cta-btn">
                    <i class="fas fa-car"></i>
                    Browse Vehicles
                </a>
                <a href="<c:url value='/customer/contact'/>" class="cta-btn secondary">
                    <i class="fas fa-phone"></i>
                    Get Started
                </a>
            </div>
        </section>
            overflow: hidden;
        }

        .stat-card:hover {
            transform: scale(1.05);
            box-shadow: 0 12px 35px rgba(0, 255, 136, 0.2);
        }

        .stat-number {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            color: #00ff88;
        }

        .stat-label {
            font-size: 1.2rem;
            color: #ffffff;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }

            .hero-section p {
                font-size: 1.2rem;
                margin-bottom: 2rem;
            }

            .section-title {
                font-size: 2.2rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .cta-buttons {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .cta-btn {
                width: 280px;
                justify-content: center;
            }

            .feature-card {
                padding: 2rem 1.5rem;
            }

            .stat-card {
                padding: 2rem 1.5rem;
            }
        }

        /* Additional elegant touches */
        .hero-section .cta-buttons::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(0, 255, 136, 0.1) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
            z-index: -1;
        }

        /* Elegant scroll animations */
        .feature-card, .stat-card {
            opacity: 0;
            animation: fadeInUp 0.6s ease forwards;
        }

        .feature-card:nth-child(1) { animation-delay: 0.1s; }
        .feature-card:nth-child(2) { animation-delay: 0.2s; }
        .feature-card:nth-child(3) { animation-delay: 0.3s; }
        .feature-card:nth-child(4) { animation-delay: 0.4s; }
        .feature-card:nth-child(5) { animation-delay: 0.5s; }
        .feature-card:nth-child(6) { animation-delay: 0.6s; }

        .stat-card:nth-child(1) { animation-delay: 0.7s; }
        .stat-card:nth-child(2) { animation-delay: 0.8s; }
        .stat-card:nth-child(3) { animation-delay: 0.9s; }
        .stat-card:nth-child(4) { animation-delay: 1.0s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <!-- Include Customer Header -->
    <jsp:include page="customer_header.jsp" />

    <!-- Hero Section -->
    <section class="hero-section">
        <h1><i class="fas fa-car"></i> Welcome to DriveGo</h1>
        <p>Your trusted partner for premium vehicle rentals</p>
        <p>Discover our wide range of vehicles and book your perfect ride today!</p>
        
        <div class="cta-buttons">
            <a href="/customer/vehicles" class="cta-btn">
                <i class="fas fa-search"></i> Browse Vehicles
            </a>
            <a href="/customer/contact" class="cta-btn secondary">
                <i class="fas fa-envelope"></i> Contact Us
            </a>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <h2 class="section-title">Why Choose DriveGo?</h2>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-car-side"></i>
                    </div>
                    <h3>Wide Selection</h3>
                    <p>Choose from a diverse fleet of well-maintained vehicles to suit your needs and budget</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <h3>Best Prices</h3>
                    <p>Competitive rates and transparent pricing with no hidden fees. Get the best value for your money</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3>24/7 Support</h3>
                    <p>Round-the-clock customer support to assist you whenever you need help during your rental</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3>Fully Insured</h3>
                    <p>All our vehicles come with comprehensive insurance coverage for your peace of mind</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h3>Easy Booking</h3>
                    <p>Simple and quick online booking process. Reserve your vehicle in just a few clicks</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-map-marked-alt"></i>
                    </div>
                    <h3>Multiple Locations</h3>
                    <p>Pick up and drop off at convenient locations across the city at your convenience</p>
                </div>
            </div>

            <!-- Stats Section -->
            <div class="stats-section">
                <div class="stat-card">
                    <div class="stat-number">1000+</div>
                    <div class="stat-label">Happy Customers</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">50+</div>
                    <div class="stat-label">Premium Vehicles</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">15+</div>
                    <div class="stat-label">Pickup Locations</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-number">99%</div>
                    <div class="stat-label">Customer Satisfaction</div>
                </div>
            </div>
        </div>
    </section>
    </main>

    <jsp:include page="customer_footer.jsp" />

    <script>
        // Smooth scroll for CTA buttons
        document.querySelectorAll('.cta-btn').forEach(button => {
            button.addEventListener('click', function(e) {
                // Add a ripple effect
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = (e.clientX - rect.left - size / 2) + 'px';
                ripple.style.top = (e.clientY - rect.top - size / 2) + 'px';
                ripple.classList.add('ripple');
                this.appendChild(ripple);
                
                setTimeout(() => ripple.remove(), 600);
            });
        });

        // Animate stats on scroll
        const observerOptions = {
            threshold: 0.5,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const statNumbers = entry.target.querySelectorAll('.stat-number');
                    statNumbers.forEach(stat => {
                        const finalNumber = stat.textContent;
                        const isPercentage = finalNumber.includes('%');
                        const isPlusSign = finalNumber.includes('+');
                        const numericValue = parseInt(finalNumber);
                        
                        let currentNumber = 0;
                        const increment = numericValue / 50;
                        
                        const counter = setInterval(() => {
                            currentNumber += increment;
                            if (currentNumber >= numericValue) {
                                currentNumber = numericValue;
                                clearInterval(counter);
                            }
                            
                            let displayValue = Math.floor(currentNumber);
                            if (isPercentage) displayValue += '%';
                            if (isPlusSign) displayValue += '+';
                            
                            stat.textContent = displayValue;
                        }, 30);
                    });
                    
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        // Observe stats section
        const statsSection = document.querySelector('.stats-section');
        if (statsSection) observer.observe(statsSection);

        // Add ripple effect CSS
        const style = document.createElement('style');
        style.textContent = `
            .ripple {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: scale(0);
                animation: ripple-animation 0.6s linear;
                pointer-events: none;
            }
            
            @keyframes ripple-animation {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>
                <div class="stat-card">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Happy Customers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">50+</div>
                    <div class="stat-label">Vehicles Available</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">10+</div>
                    <div class="stat-label">Years Experience</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Customer Support</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />
</body>
</html>