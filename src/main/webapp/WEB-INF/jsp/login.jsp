<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .bubble {
            position: absolute;
            border-radius: 50%;
            background: rgba(0, 255, 136, 0.1);
            animation: float 20s infinite ease-in-out;
        }
        
        .bubble.bubble1 {
            width: 300px;
            height: 300px;
            top: 10%;
            left: 5%;
            animation-delay: 0s;
        }
        
        .bubble.bubble2 {
            width: 200px;
            height: 200px;
            bottom: 15%;
            right: 10%;
            animation-delay: 5s;
        }
        
        .bubble.bubble3 {
            width: 150px;
            height: 150px;
            top: 60%;
            left: 70%;
            animation-delay: 10s;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            33% { transform: translate(30px, -30px) scale(1.1); }
            66% { transform: translate(-20px, 20px) scale(0.9); }
        }
        
        .navbar {
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            z-index: 10;
        }
        
        .navbar img {
            height: 40px;
        }
        
        .nav-links {
            display: flex;
            gap: 1rem;
        }
        
        .nav-links a {
            color: #ffffff;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: background-color 0.3s;
        }
        
        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
            position: relative;
            z-index: 5;
        }
        
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 3rem;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.6s ease-out;
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
        
        .card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .logo-container img {
            height: 60px;
            width: auto;
            border-radius: 12px;
        }
        
        .header-text h1 {
            color: #2c2c2c;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .header-text p {
            color: #666;
            font-size: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c2c2c;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .input-container {
            position: relative;
            height: 48px;
        }
        
        .input-icon {
            position: absolute;
            left: 16px;
            top: 16px;
            color: #999;
            font-size: 16px;
            z-index: 2;
        }
        
        .form-input {
            width: 100%;
            height: 48px;
            padding: 0 16px 0 48px;
            border: 2px solid #e5e5e5;
            border-radius: 12px;
            font-size: 16px;
            background: #fafafa;
            transition: all 0.3s ease;
            outline: none;
            line-height: 16px;
        }
        
        .form-input:focus {
            border-color: #00ff88;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 255, 136, 0.1);
        }
        
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
        }
        
        .checkbox-group input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #00ff88;
        }
        
        .checkbox-group label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #00ff88 0%, #00cc6a 100%);
            color: #000;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 255, 136, 0.3);
        }
        
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .alert.success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert.error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .signup-link {
            text-align: center;
            color: #666;
        }
        
        .signup-link a {
            color: #00ff88;
            text-decoration: none;
            font-weight: 600;
        }
        
        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="bubble bubble1"></div>
    <div class="bubble bubble2"></div>
    <div class="bubble bubble3"></div>
    
    <nav class="navbar">
        <a href="<c:url value='/index'/>">
            <img src="<c:url value='/img/drive%20gow_.png'/>" alt="DriveGo Logo">
        </a>
        <div class="nav-links">
            <a href="<c:url value='/login'/>">
                <i class="fa-solid fa-arrow-right-to-bracket"></i> Login
            </a>
            <a href="<c:url value='/register'/>">
                <i class="fa-solid fa-user-plus"></i> Register
            </a>
        </div>
    </nav>
    
    <div class="container">
        <div class="login-card">
            <c:if test="${param.success}">
                <div class="alert success">
                    <i class="fa-solid fa-circle-check"></i>
                    <span>Account created successfully! You can now sign in.</span>
                </div>
            </c:if>
            
            <c:if test="${param.error}">
                <div class="alert error">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span>Invalid email or password. Please try again.</span>
                </div>
            </c:if>
            
            <c:if test="${param.logout}">
                <div class="alert success">
                    <i class="fa-solid fa-circle-check"></i>
                    <span>You have been logged out successfully.</span>
                </div>
            </c:if>
            
            <div class="card-header">
                <div class="logo-container">
                    <img src="<c:url value='/img/logo.png'/>" alt="DriveGo Logo">
                </div>
                <div class="header-text">
                    <h1>Welcome Back</h1>
                    <p>Sign in to your DriveGo account</p>
                </div>
            </div>
            
            <form action="<c:url value='/perform-login'/>" method="post">
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <div class="input-container">
                        <i class="fa-solid fa-envelope input-icon"></i>
                        <input type="email" 
                               id="email" 
                               name="username" 
                               class="form-input"
                               placeholder="your.email@example.com"
                               required 
                               autocomplete="email">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="input-container">
                        <i class="fa-solid fa-lock input-icon"></i>
                        <input type="password" 
                               id="password" 
                               name="password" 
                               class="form-input"
                               placeholder="Enter your password"
                               required 
                               autocomplete="current-password">
                    </div>
                </div>
                
                <div class="checkbox-group">
                    <input type="checkbox" id="remember" name="remember-me">
                    <label for="remember">Remember me</label>
                </div>
                
                <button type="submit" class="submit-btn">
                    <i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In
                </button>
                
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </form>
            
            <div class="signup-link">
                Don't have an account? <a href="<c:url value='/register'/>">Sign Up →</a>
            </div>
        </div>
    </div>
</body>
</html>
