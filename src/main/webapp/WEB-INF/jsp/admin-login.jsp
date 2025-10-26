<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - DriveGo</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
</head>
<body>
    <div class="auth-container">
        <div class="auth-form-wrapper">
            <div class="auth-header">
                <h1>Welcome Back</h1>
                <p>Sign in to your DriveGo account</p>
            </div>

            <!-- Display success messages -->
            <c:if test="${param.success}">
                <div class="alert alert-success">
                    <span>Account created successfully! You can now sign in.</span>
                </div>
            </c:if>

            <c:if test="${param.logout}">
                <div class="alert alert-success">
                    <span>You have been logged out successfully.</span>
                </div>
            </c:if>

            <!-- Display error messages -->
            <c:if test="${param.error}">
                <div class="alert alert-error">
                    <span>Invalid username or password. Please try again.</span>
                </div>
            </c:if>

            <form action="/perform-login" method="post" class="auth-form">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="form-group">
                    <label for="username">Email Address</label>
                    <input type="email" 
                           id="username" 
                           name="username" 
                           placeholder="Enter your email address"
                           required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" 
                           id="password" 
                           name="password" 
                           placeholder="Enter your password"
                           required>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-full">Sign In</button>
                </div>

                <div class="auth-links">
                    <p>Don't have an account? <a href="/register">Create Account</a></p>
                    <p><a href="/index">Back to Home</a></p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>