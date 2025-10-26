<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Login - DriveGo</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }
        
        .auth-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #000000 0%, #1a1a1a 100%);
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }
        
        .auth-background {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }
        
        .auth-bubble {
            position: absolute;
            border-radius: 50%;
            background: rgba(0, 255, 136, 0.1);
            animation: float 20s infinite ease-in-out;
        }
        
        .auth-bubble.primary {
            width: 300px;
            height: 300px;
            top: 10%;
            left: 5%;
            animation-delay: 0s;
        }
        
        .auth-bubble.secondary {
            width: 200px;
            height: 200px;
            bottom: 15%;
            right: 10%;
            animation-delay: 5s;
        }
        
        .auth-bubble.tertiary {
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
        
        .auth-navbar {
            background: rgba(0, 0, 0, 0.5) !important;
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            z-index: 10;
        }
        
        .navbar-brand {
            color: #00ff88 !important;
            font-size: 1.5rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .navbar-brand img {
            height: 40px;
            width: auto;
        }
        
        .nav-link {
            color: rgba(255, 255, 255, 0.8) !important;
            margin: 0 0.5rem;
            transition: color 0.3s;
        }
        
        .nav-link:hover {
            color: #00ff88 !important;
        }
        
        .auth-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 3rem 2rem;
            z-index: 10;
            max-width: 480px;
            margin: 0 auto;
            width: 100%;
        }
        
        .auth-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 3rem 2.5rem;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
            width: 100%;
        }
        
        .auth-card-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .auth-icon-wrapper {
            width: 56px;
            height: 56px;
            background: #ffffff;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            color: white;
            flex-shrink: 0;
            padding: 0.5rem;
            border: 2px solid #f0f0f0;
        }
        
        .auth-icon-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }
        
        .auth-card-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: #1a1a1a;
            line-height: 1.2;
            margin-bottom: 0.25rem;
        }
        
        .auth-card-subtitle {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.4;
        }
        
        .form-group {
            margin-bottom: 1.75rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.625rem;
            font-weight: 600;
            color: #2c2c2c;
            font-size: 0.95rem;
        }
        
        /* FINAL CSS UPDATE - TIMESTAMP: 2025-10-19-13:15 */
        /* FORCE CSS UPDATE - V2.0 */
        .auth-input-group {
            position: relative !important;
            width: 100% !important;
        }
        
        .auth-input-icon {
            position: absolute !important;
            left: 15px !important;
            top: 50% !important;
            transform: translateY(-50%) !important;
            color: #999 !important;
            font-size: 16px !important;
            pointer-events: none !important;
            z-index: 999 !important;
            line-height: 1 !important;
            height: 16px !important;
            width: 16px !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
        }
        
        .auth-input {
            width: 100% !important;
            padding: 12px 16px 12px 45px !important;
            border: 2px solid #e5e5e5 !important;
            border-radius: 10px !important;
            font-size: 16px !important;
            line-height: 24px !important;
            transition: all 0.3s ease !important;
            background-color: #fafafa !important;
            display: block !important;
            height: 48px !important;
            box-sizing: border-box !important;
        }
        
        .auth-input::placeholder {
            color: #999 !important;
            font-size: 16px !important;
            line-height: 24px !important;
        }
        
        .auth-input:focus {
            outline: none;
            border-color: #00ff88;
            background-color: #ffffff;
            box-shadow: 0 0 0 4px rgba(0, 255, 136, 0.1);
        }
        
        .form-check {
            display: flex;
            align-items: center;
            gap: 0.625rem;
            margin-bottom: 1.5rem;
        }
        
        .form-check input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #00ff88;
        }
        
        .form-check label {
            color: #666;
            font-size: 0.9rem;
            cursor: pointer;
            user-select: none;
        }
        
        .auth-submit {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #00ff88, #00cc6a);
            color: #000;
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
        }
        
        .auth-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 255, 136, 0.35);
        }
        
        .auth-submit:active {
            transform: translateY(0);
        }
        
        .auth-divider {
            text-align: center;
            position: relative;
            margin: 2rem 0 1.75rem;
        }
        
        .auth-divider span {
            background: rgba(255, 255, 255, 0.95);
            padding: 0 1.25rem;
            color: #999;
            position: relative;
            z-index: 1;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .auth-divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e0e0e0;
        }
        
        .auth-link {
            color: #00ff88;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        
        .auth-link:hover {
            color: #00cc6a;
            text-decoration: underline;
        }
        
        .auth-alert {
            padding: 1.125rem 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.95rem;
            width: 100%;
        }
        
        .auth-alert i {
            font-size: 1.25rem;
            flex-shrink: 0;
        }
        
        .auth-alert.success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #6ee7b7;
        }
        
        .auth-alert.error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }
        
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-background">
            <span class="auth-bubble primary"></span>
            <span class="auth-bubble secondary"></span>
            <span class="auth-bubble tertiary"></span>
        </div>
        
        <nav class="auth-navbar">
            <div style="display: flex; align-items: center; justify-content: space-between;">
                <a class="navbar-brand" href="<c:url value='/index'/>">
                    <img src="<c:url value='/img/drive%20gow_.png'/>" alt="DriveGo Logo">
                </a>
                <div>
                    <a class="nav-link" href="<c:url value='/login'/>">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i> Login
                    </a>
                    <a class="nav-link" href="<c:url value='/register'/>">
                        <i class="fa-solid fa-user-plus"></i> Register
                    </a>
                </div>
            </div>
        </nav>
        
        <div class="auth-content">
            <c:if test="${param.success}">
                <div class="auth-alert success fade-in" style="width: 100%;">
                    <i class="fa-solid fa-circle-check"></i>
                    <span>Account created successfully! You can now sign in.</span>
                </div>
            </c:if>
            
            <c:if test="${param.error}">
                <div class="auth-alert error fade-in" style="width: 100%;">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span>Invalid email or password. Please try again.</span>
                </div>
            </c:if>
            
            <c:if test="${param.logout}">
                <div class="auth-alert success fade-in" style="width: 100%;">
                    <i class="fa-solid fa-circle-check"></i>
                    <span>You have been successfully logged out.</span>
                </div>
            </c:if>
            
            <div class="auth-card fade-in">
                <div class="auth-card-header">
                    <div class="auth-icon-wrapper">
                        <img src="<c:url value='/img/logo.png'/>" alt="DriveGo Logo">
                    </div>
                    <div>
                        <div class="auth-card-title">Welcome Back</div>
                        <div class="auth-card-subtitle">Sign in to your DriveGo account</div>
                    </div>
                </div>
                <div class="auth-card-body">
                    <form method="post" action="<c:url value='/perform-login'/>" class="auth-form">
                        <div class="form-group auth-input-group">
                            <label class="form-label" for="username">Email Address</label>
                            <span class="auth-input-icon">
                                <i class="fa-solid fa-envelope"></i>
                            </span>
                            <input type="email" id="username" name="username" class="auth-input" 
                                   placeholder="Enter your email address" autocomplete="email" required />
                        </div>
                        
                        <div class="form-group auth-input-group">
                            <label class="form-label" for="password">Password</label>
                            <span class="auth-input-icon">
                                <i class="fa-solid fa-lock"></i>
                            </span>
                            <input type="password" id="password" name="password" class="auth-input" 
                                   placeholder="Enter your password" autocomplete="current-password" required />
                        </div>
                        
                        <div class="form-group">
                            <div class="form-check">
                                <input type="checkbox" id="rememberMe" name="remember-me">
                                <label for="rememberMe">Remember me</label>
                            </div>
                        </div>
                        
                        <div>
                            <button type="submit" class="auth-submit">
                                <i class="fa-solid fa-arrow-right-to-bracket"></i> Sign In
                            </button>
                            
                            <div class="auth-divider">
                                <span>or</span>
                            </div>
                            
                            <div style="text-align: center; color: #555; font-size: 0.95rem; line-height: 1.6;">
                                Don't have an account?
                                <a class="auth-link" href="<c:url value='/register'/>">
                                    Create Account <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
