<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveGo - Premium Car Rental Service</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #ffffff; color: #2c2c2c; overflow-x: hidden; }
        .hero { 
            position: relative; 
            min-height: 90vh; 
            background: url('/img/banner.png') center center/cover no-repeat;
            display: flex; 
            align-items: center; 
            justify-content: center; 
            overflow: hidden; 
        }
        .hero::before { 
            content: ''; 
            position: absolute; 
            top: 0; 
            left: 0; 
            right: 0; 
            bottom: 0; 
            background: rgba(0, 0, 0, 0.5); 
            z-index: 1; 
        }
        .hero-content { max-width: 1200px; margin: 0 auto; padding: 2rem; text-align: center; position: relative; z-index: 2; animation: fadeInUp 1s ease-out; }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .hero-badge { display: inline-block; padding: 0.75rem 1.5rem; background: rgba(8, 161, 49, 0.1); border: 1px solid rgba(8, 161, 49, 0.3); border-radius: 50px; color: #0cc23c; font-weight: 600; margin-bottom: 2rem; animation: fadeIn 1s ease-out 0.2s both; }
        .hero h1 { font-size: 4.5rem; font-weight: 900; color: #ffffff; margin-bottom: 1.5rem; line-height: 1.2; animation: fadeIn 1s ease-out 0.4s both; }
        .hero h1 .highlight { background: linear-gradient(135deg, #08a131, #0cc23c); background-clip: text; -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .hero p { font-size: 1.4rem; color: rgba(255, 255, 255, 0.8); margin-bottom: 3rem; max-width: 700px; margin-left: auto; margin-right: auto; line-height: 1.6; animation: fadeIn 1s ease-out 0.6s both; }
        .hero-buttons { display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; animation: fadeIn 1s ease-out 0.8s both; }
        .btn { padding: 1.2rem 2.5rem; border-radius: 50px; font-size: 1.1rem; font-weight: 700; text-decoration: none; transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 0.75rem; cursor: pointer; border: none; }
        .btn-primary { background: linear-gradient(135deg, #08a131, #0cc23c); color: #ffffff; box-shadow: 0 10px 30px rgba(8, 161, 49, 0.3); }
        .btn-primary:hover { transform: translateY(-3px); box-shadow: 0 15px 40px rgba(8, 161, 49, 0.4); }
        .btn-secondary { background: rgba(255, 255, 255, 0.1); color: #ffffff; border: 2px solid rgba(255, 255, 255, 0.2); backdrop-filter: blur(10px); }
        .btn-secondary:hover { background: rgba(255, 255, 255, 0.2); border-color: rgba(255, 255, 255, 0.3); }
        .features { padding: 8rem 2rem; background: #f8f9fa; position: relative; }
        .container { max-width: 1200px; margin: 0 auto; }
        .section-header { text-align: center; margin-bottom: 5rem; }
        .section-badge { display: inline-block; padding: 0.5rem 1.25rem; background: rgba(8, 161, 49, 0.1); color: #08a131; border-radius: 50px; font-weight: 600; font-size: 0.9rem; margin-bottom: 1rem; }
        .section-title { font-size: 3rem; font-weight: 900; color: #2c2c2c; margin-bottom: 1rem; }
        .section-subtitle { font-size: 1.2rem; color: #666; max-width: 600px; margin: 0 auto; }
        .features-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 2.5rem; }
        .feature-card { background: #ffffff; padding: 3rem 2rem; border-radius: 20px; text-align: center; transition: all 0.3s ease; border: 1px solid #e5e5e5; position: relative; overflow: hidden; }
        .feature-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px; background: linear-gradient(90deg, #08a131, #0cc23c); transform: scaleX(0); transition: transform 0.3s ease; }
        .feature-card:hover::before { transform: scaleX(1); }
        .feature-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1); }
        .feature-icon { width: 80px; height: 80px; margin: 0 auto 1.5rem; background: linear-gradient(135deg, rgba(8, 161, 49, 0.1), rgba(12, 194, 60, 0.1)); border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 2.5rem; color: #08a131; transition: all 0.3s ease; }
        .feature-card:hover .feature-icon { transform: scale(1.1) rotate(5deg); background: linear-gradient(135deg, #08a131, #0cc23c); color: #ffffff; }
        .feature-card h3 { font-size: 1.5rem; font-weight: 700; color: #2c2c2c; margin-bottom: 1rem; }
        .feature-card p { color: #666; line-height: 1.6; }
        .stats { padding: 6rem 2rem; background: linear-gradient(135deg, #0a1929 0%, #1a2332 100%); }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 3rem; max-width: 1200px; margin: 0 auto; }
        .stat-card { text-align: center; padding: 2rem; }
        .stat-number { font-size: 4rem; font-weight: 900; background: linear-gradient(135deg, #08a131, #0cc23c); background-clip: text; -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 0.5rem; line-height: 1; }
        .stat-label { font-size: 1.1rem; color: rgba(255, 255, 255, 0.8); font-weight: 600; }
        .how-it-works { padding: 8rem 2rem; background: #ffffff; }
        .steps-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 3rem; max-width: 1200px; margin: 0 auto; margin-top: 5rem; }
        .step-card { position: relative; padding: 3rem 2rem; text-align: center; }
        .step-number { width: 60px; height: 60px; margin: 0 auto 2rem; background: linear-gradient(135deg, #08a131, #0cc23c); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; font-weight: 900; color: #ffffff; box-shadow: 0 10px 30px rgba(8, 161, 49, 0.3); }
        .step-card h3 { font-size: 1.5rem; font-weight: 700; color: #2c2c2c; margin-bottom: 1rem; }
        .step-card p { color: #666; line-height: 1.6; }
        .cta-section { padding: 8rem 2rem; background: linear-gradient(135deg, #08a131 0%, #0a6e24 100%); text-align: center; position: relative; overflow: hidden; }
        .cta-content { position: relative; z-index: 2; max-width: 800px; margin: 0 auto; }
        .cta-content h2 { font-size: 3rem; font-weight: 900; color: #ffffff; margin-bottom: 1.5rem; }
        .cta-content p { font-size: 1.3rem; color: rgba(255, 255, 255, 0.9); margin-bottom: 3rem; }
        .cta-content .btn-primary { background: #ffffff; color: #08a131; }
        .cta-content .btn-primary:hover { background: #f0f0f0; }
        @media (max-width: 768px) {
            .hero h1 { font-size: 2.5rem; }
            .hero p { font-size: 1.1rem; }
            .section-title { font-size: 2rem; }
            .cta-content h2 { font-size: 2rem; }
            .hero-buttons { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
        }
    </style>
</head>
<body>
    <jsp:include page="customer_header.jsp" />
    <section class="hero">
        <div class="hero-content">
            <h1>Find Your Perfect <span class="highlight">Drive</span></h1>
            <p>Experience premium car rental services with unbeatable rates, flexible booking, and a wide selection of vehicles for every journey.</p>
            <div class="hero-buttons">
                <a href="/customer/vehicles" class="btn btn-primary"><i class="fas fa-car"></i> Browse Vehicles</a>
                <a href="#how-it-works" class="btn btn-secondary"><i class="fas fa-play-circle"></i> How It Works</a>
            </div>
        </div>
    </section>
    <section class="features">
        <div class="container">
            <div class="section-header">
                <span class="section-badge">Why Choose Us</span>
                <h2 class="section-title">Premium Features</h2>
                <p class="section-subtitle">Everything you need for a perfect car rental experience</p>
            </div>
            <div class="features-grid">
                <div class="feature-card"><div class="feature-icon"><i class="fas fa-car"></i></div><h3>Wide Selection</h3><p>Choose from our extensive fleet of well-maintained vehicles ranging from economy to luxury cars.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fas fa-shield-alt"></i></div><h3>Fully Insured</h3><p>All our vehicles come with comprehensive insurance coverage for your peace of mind.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fas fa-dollar-sign"></i></div><h3>Best Prices</h3><p>Competitive rates with transparent pricing and no hidden fees. Get the best value for your money.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fas fa-clock"></i></div><h3>24/7 Support</h3><p>Round-the-clock customer service to assist you whenever you need help.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fas fa-mobile-alt"></i></div><h3>Easy Booking</h3><p>Simple and fast online booking process. Reserve your car in just a few clicks.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fas fa-check-circle"></i></div><h3>Flexible Plans</h3><p>Choose from daily, weekly, or monthly rental options that suit your needs.</p></div>
            </div>
        </div>
    </section>
    <section class="stats">
        <div class="stats-grid">
            <div class="stat-card"><div class="stat-number">5000+</div><div class="stat-label">Happy Customers</div></div>
            <div class="stat-card"><div class="stat-number">150+</div><div class="stat-label">Quality Vehicles</div></div>
            <div class="stat-card"><div class="stat-number">24/7</div><div class="stat-label">Customer Support</div></div>
            <div class="stat-card"><div class="stat-number">99%</div><div class="stat-label">Satisfaction Rate</div></div>
        </div>
    </section>
    <section class="how-it-works" id="how-it-works">
        <div class="container">
            <div class="section-header">
                <span class="section-badge">Simple Process</span>
                <h2 class="section-title">How It Works</h2>
                <p class="section-subtitle">Get on the road in three easy steps</p>
            </div>
            <div class="steps-grid">
                <div class="step-card"><div class="step-number">1</div><h3>Choose Your Car</h3><p>Browse our fleet and select the perfect vehicle for your needs and budget.</p></div>
                <div class="step-card"><div class="step-number">2</div><h3>Book Online</h3><p>Complete your reservation in minutes with our secure online booking system.</p></div>
                <div class="step-card"><div class="step-number">3</div><h3>Hit The Road</h3><p>Pick up your car and start your journey. It's that simple!</p></div>
            </div>
        </div>
    </section>
    <section class="cta-section">
        <div class="cta-content">
            <h2>Ready to Start Your Journey?</h2>
            <p>Join thousands of satisfied customers who trust DriveGo for their car rental needs.</p>
            <a href="/customer/vehicles" class="btn btn-primary"><i class="fas fa-car"></i> Get Started Now</a>
        </div>
    </section>
    
    <!-- Include Customer Footer -->
    <jsp:include page="customer_footer.jsp" />
</body>
</html>
