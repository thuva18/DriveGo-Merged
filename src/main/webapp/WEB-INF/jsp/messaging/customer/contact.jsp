<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            color: #2c2c2c;
            min-height: 100vh;
            position: relative;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
            position: relative;
            z-index: 5;
        }

        .simple-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .simple-header h1 {
            font-size: 2.2rem;
            font-weight: 600;
            color: #2c2c2c;
            margin: 0;
        }

        .contact-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .contact-form-section, .contact-info-section {
            background: #ffffff;
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 255, 136, 0.1);
            border: 1px solid rgba(0, 255, 136, 0.2);
            position: relative;
            overflow: hidden;
        }

        .contact-form-section::before, .contact-info-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #08a131, #0cc23c);
        }

        .section-title {
            font-size: 2rem;
            color: #000000;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 700;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(135deg, #08a131, #0cc23c);
            border-radius: 2px;
        }

        .section-title i {
            color: #08a131;
            font-size: 1.8rem;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: #000000;
            font-weight: 600;
            font-size: 1rem;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e5e5e5;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fafafa;
            color: #000000;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #08a131;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(8, 161, 49, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 140px;
        }

        .submit-btn {
            width: 100%;
            padding: 1.2rem;
            background: linear-gradient(135deg, #08a131 0%, #0cc23c 100%);
            color: #000000;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 6px 20px rgba(8, 161, 49, 0.3);
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0, 255, 136, 0.5);
            background: linear-gradient(135deg, #00cc6a, #00a855);
        }

        .contact-info-item {
            display: flex;
            align-items: start;
            gap: 1.5rem;
            margin-bottom: 2.5rem;
            padding: 1.5rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
            border-radius: 15px;
            border-left: 4px solid #08a131;
            transition: all 0.3s ease;
        }

        .contact-info-item:hover {
            transform: translateX(5px);
            box-shadow: 0 8px 25px rgba(8, 161, 49, 0.15);
        }

        .contact-icon {
            font-size: 1.8rem;
            color: #08a131;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            border-radius: 50%;
            box-shadow: 0 4px 15px rgba(0, 255, 136, 0.2);
            flex-shrink: 0;
        }

        .contact-details h3 {
            color: #000000;
            margin-bottom: 0.75rem;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .contact-details p {
            color: #555555;
            line-height: 1.7;
            font-size: 0.95rem;
        }



        .success-message {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            padding: 1.2rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: none;
            border-left: 4px solid #28a745;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .success-message.show {
            display: flex;
            animation: slideDown 0.5s ease-out;
        }
        
        .error-message {
            background: linear-gradient(135deg, #f8d7da, #f5c6cb);
            color: #721c24;
            padding: 1.2rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: none;
            border-left: 4px solid #dc3545;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .error-message.show {
            display: flex;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .contact-content {
                grid-template-columns: 1fr;
                gap: 2rem;
            }

            .simple-header h1 {
                font-size: 1.8rem;
            }

            .contact-form-section, .contact-info-section {
                padding: 2rem 1.5rem;
            }



            .section-title {
                font-size: 1.6rem;
            }

            .contact-info-item {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .contact-icon {
                align-self: center;
            }
        }

        /* Additional elegant animations */
        .contact-form-section, .contact-info-section {
            opacity: 0;
            animation: fadeInUp 0.6s ease forwards;
        }

        .contact-form-section {
            animation-delay: 0.2s;
        }

        .contact-info-section {
            animation-delay: 0.4s;
        }

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
    <jsp:include page="../../customer_header.jsp" />

    <div class="container">
        <div class="simple-header">
            <h1>Contact Us</h1>
        </div>

        <div class="contact-content">
            <!-- Contact Form -->
            <div class="contact-form-section">
                <h2 class="section-title">
                    <i class="fas fa-paper-plane"></i>
                    Send us a Message
                </h2>
                
                <!-- Success Message -->
                <c:if test="${not empty success}">
                    <div class="success-message show">
                        <i class="fas fa-check-circle"></i> <c:out value="${success}"/>
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="error-message show">
                        <i class="fas fa-exclamation-circle"></i> <c:out value="${error}"/>
                    </div>
                </c:if>

                <form id="contactForm" method="post" action="${pageContext.request.contextPath}/customer/contact">
                    <div class="form-group">
                        <label for="name">Your Name *</label>
                        <input type="text" id="name" name="name" required placeholder="Enter your full name" value="<c:out value='${not empty param.name ? param.name : userName}'/>">
                    </div>

                    <c:if test="${not empty pageContext.request.userPrincipal}">
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" readonly 
                                   style="background-color: #f5f5f5; cursor: not-allowed;" 
                                   value="${pageContext.request.userPrincipal.name}" 
                                   title="Your account email will be used">
                            <small style="color: #666; font-size: 0.85rem; display: block; margin-top: 0.5rem;">
                                <i class="fas fa-info-circle"></i> Using your account email
                            </small>
                        </div>
                    </c:if>

                    <div class="form-group">
                        <label for="subject">Subject *</label>
                        <select id="subject" name="subject" required>
                            <option value="">Select a subject</option>
                            <option value="Booking Inquiry" ${param.subject == 'Booking Inquiry' ? 'selected' : ''}>Booking Inquiry</option>
                            <option value="Customer Support" ${param.subject == 'Customer Support' ? 'selected' : ''}>Customer Support</option>
                            <option value="Feedback" ${param.subject == 'Feedback' ? 'selected' : ''}>Feedback</option>
                            <option value="Complaint" ${param.subject == 'Complaint' ? 'selected' : ''}>Complaint</option>
                            <option value="Other" ${param.subject == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="message">Message *</label>
                        <textarea id="message" name="message" required placeholder="Tell us how we can help you..."><c:out value='${param.message}'/></textarea>
                    </div>

                    <c:choose>
                        <c:when test="${not empty pageContext.request.userPrincipal}">
                            <button type="submit" class="submit-btn">
                                <i class="fas fa-paper-plane"></i> Send Message
                            </button>
                        </c:when>
                        <c:otherwise>
                            <div style="background: #fff3cd; border: 1px solid #ffc107; padding: 1rem; border-radius: 8px; text-align: center; margin-top: 1rem;">
                                <i class="fas fa-exclamation-triangle" style="color: #856404;"></i>
                                <p style="margin: 0.5rem 0; color: #856404;">Please <a href="${pageContext.request.contextPath}/login" style="color: #08a131; font-weight: bold;">log in</a> to send a message.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </form>
            </div>

            <!-- Contact Information -->
            <div class="contact-info-section">
                <h2 class="section-title">
                    <i class="fas fa-info-circle"></i>
                    Contact Information
                </h2>

                <div class="contact-info-item">
                    <div class="contact-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="contact-details">
                        <h3>Our Address</h3>
                        <p>123 DriveGo Street<br>
                        Downtown District<br>
                        City, State 12345</p>
                    </div>
                </div>

                <div class="contact-info-item">
                    <div class="contact-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="contact-details">
                        <h3>Phone</h3>
                        <p>Main: +1 (555) 123-4567<br>
                        Support: +1 (555) 987-6543<br>
                        Available 24/7</p>
                    </div>
                </div>

                <div class="contact-info-item">
                    <div class="contact-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="contact-details">
                        <h3>Email</h3>
                        <p>General: info@drivego.com<br>
                        Support: support@drivego.com<br>
                        Bookings: bookings@drivego.com</p>
                    </div>
                </div>

                <div class="contact-info-item">
                    <div class="contact-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="contact-details">
                        <h3>Business Hours</h3>
                        <p>Monday - Friday: 8:00 AM - 8:00 PM<br>
                        Saturday: 9:00 AM - 6:00 PM<br>
                        Sunday: 10:00 AM - 4:00 PM</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- My Messages Section (only show if user is logged in) -->
        <c:if test="${not empty pageContext.request.userPrincipal}">
            <div class="messages-history-section" style="margin-top: 3rem;">
                <h2 class="section-title">
                    <i class="fas fa-inbox"></i>
                    My Messages & Replies
                </h2>
                
                <div class="messages-stats" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
                    <div class="stat-card" style="background: linear-gradient(135deg, #fff3cd, #ffeaa7); padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <i class="fas fa-envelope" style="font-size: 2.5rem; color: #f39c12; margin-bottom: 0.5rem;"></i>
                        <h3 style="font-size: 2rem; color: #2c2c2c; margin: 0;">${newCount}</h3>
                        <p style="color: #666; margin: 0; font-size: 0.9rem;">Pending</p>
                    </div>
                    <div class="stat-card" style="background: linear-gradient(135deg, #d4edda, #b8e6c0); padding: 1.5rem; border-radius: 12px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <i class="fas fa-reply" style="font-size: 2.5rem; color: #08a131; margin-bottom: 0.5rem;"></i>
                        <h3 style="font-size: 2rem; color: #2c2c2c; margin: 0;">${repliedCount}</h3>
                        <p style="color: #666; margin: 0; font-size: 0.9rem;">Replied</p>
                    </div>
                </div>
                
                <!-- Enhanced Message History Display -->
                <div class="message-history-container">
                    <c:choose>
                        <c:when test="${empty messages}">
                            <!-- No Messages Yet -->
                            <div class="no-messages-container" style="text-align: center; padding: 3rem; background: linear-gradient(135deg, #f8f9fa, #ffffff); border-radius: 15px; border: 2px dashed #dee2e6;">
                                <i class="fas fa-inbox" style="font-size: 4rem; color: #6c757d; margin-bottom: 1rem;"></i>
                                <h3 style="color: #6c757d; margin-bottom: 0.5rem;">No Messages Yet</h3>
                                <p style="color: #888; margin: 0;">Send your first message using the form above and we'll respond as soon as possible!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Filter and Sort Options -->
                            <div class="message-filters" style="background: #f8f9fa; padding: 1.5rem; border-radius: 12px; margin-bottom: 2rem; border: 1px solid #e9ecef;">
                                <div style="display: flex; flex-wrap: wrap; gap: 1rem; align-items: center; justify-content: space-between;">
                                    <div style="display: flex; gap: 1rem; align-items: center;">
                                        <span style="font-weight: 600; color: #495057;">Filter:</span>
                                        <select id="statusFilter" style="padding: 0.5rem; border: 1px solid #ced4da; border-radius: 6px; background: white;">
                                            <option value="all">All Messages</option>
                                            <option value="pending">Pending Only</option>
                                            <option value="replied">Replied Only</option>
                                        </select>
                                    </div>
                                    <div style="display: flex; gap: 1rem; align-items: center;">
                                        <span style="font-weight: 600; color: #495057;">Sort:</span>
                                        <select id="sortOrder" style="padding: 0.5rem; border: 1px solid #ced4da; border-radius: 6px; background: white;">
                                            <option value="newest">Newest First</option>
                                            <option value="oldest">Oldest First</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <!-- Messages List -->
                            <div class="messages-list">
                                <c:forEach var="msg" items="${messages}" varStatus="status">
                                    <div class="message-thread" data-status="${msg.status}" data-date="${msg.createdAt}" 
                                         style="background: white; border-radius: 15px; margin-bottom: 2rem; box-shadow: 0 5px 20px rgba(0,0,0,0.08); border: 1px solid #e9ecef; overflow: hidden; transition: all 0.3s ease;">
                                        
                                        <!-- Message Header -->
                                        <div class="message-header" style="background: linear-gradient(135deg, #f8f9fa, #ffffff); padding: 1.5rem; border-bottom: 1px solid #e9ecef;">
                                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 1rem;">
                                                <div style="flex: 1;">
                                                    <h3 style="margin: 0; color: #2c2c2c; font-size: 1.25rem; font-weight: 700; display: flex; align-items: center; gap: 0.5rem;">
                                                        <i class="fas fa-envelope" style="color: #08a131;"></i>
                                                        <c:out value="${msg.subject}"/>
                                                    </h3>
                                                    <div style="display: flex; flex-wrap: wrap; gap: 1rem; margin-top: 0.5rem; color: #6c757d; font-size: 0.9rem;">
                                                        <span><i class="fas fa-calendar"></i> <span class="format-date" data-date="${msg.createdAt}">${msg.createdAt}</span></span>
                                                        <span><i class="fas fa-hashtag"></i> Message #${msg.id}</span>
                                                    </div>
                                                </div>
                                                <div style="margin-left: 1rem;">
                                                    <c:choose>
                                                        <c:when test="${msg.status == 'NEW' or msg.status == 'READ'}">
                                                            <span class="status-badge pending" style="background: linear-gradient(135deg, #ffc107, #ffb300); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.85rem; font-weight: 700; display: inline-flex; align-items: center; gap: 0.5rem;">
                                                                <i class="fas fa-clock"></i> PENDING
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${msg.status == 'REPLIED'}">
                                                            <span class="status-badge replied" style="background: linear-gradient(135deg, #08a131, #0cc23c); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.85rem; font-weight: 700; display: inline-flex; align-items: center; gap: 0.5rem;">
                                                                <i class="fas fa-check-circle"></i> REPLIED
                                                            </span>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Message Body -->
                                        <div class="message-body" style="padding: 1.5rem;">
                                            
                                            <!-- Your Original Message -->
                                            <div class="message-bubble customer" style="background: linear-gradient(135deg, #e3f2fd, #bbdefb); border-radius: 18px; padding: 1.5rem; margin-bottom: 1.5rem; border-left: 4px solid #2196f3; position: relative;">
                                                <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem;">
                                                    <div style="width: 40px; height: 40px; background: linear-gradient(135deg, #08a131, #0cc23c); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <div>
                                                        <div style="font-weight: 700; color: #2c2c2c; font-size: 1rem;">You</div>
                                                        <div style="color: #6c757d; font-size: 0.85rem;" class="format-date" data-date="${msg.createdAt}">${msg.createdAt}</div>
                                                    </div>
                                                </div>
                                                <p style="margin: 0; color: #2c2c2c; line-height: 1.6; font-size: 1rem; white-space: pre-wrap;"><c:out value="${msg.message}"/></p>
                                                
                                                <!-- Edit/Delete Buttons for Pending Messages -->
                                                <c:if test="${msg.status == 'NEW' or msg.status == 'READ'}">
                                                    <div style="margin-top: 1.5rem; display: flex; gap: 0.75rem;">
                                                        <button class="edit-msg-btn" 
                                                                data-id="${msg.id}" 
                                                                data-subject="<c:out value='${msg.subject}'/>" 
                                                                data-message="<c:out value='${msg.message}'/>"
                                                                style="background: linear-gradient(135deg, #17a2b8, #20c997); color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 20px; cursor: pointer; font-size: 0.9rem; transition: all 0.3s; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem;"
                                                                onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 5px 15px rgba(23,162,184,0.4)';" 
                                                                onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                                                            <i class="fas fa-edit"></i> Edit Message
                                                        </button>
                                                        <button class="delete-msg-btn" data-id="${msg.id}" 
                                                                style="background: linear-gradient(135deg, #dc3545, #c82333); color: white; border: none; padding: 0.6rem 1.2rem; border-radius: 20px; cursor: pointer; font-size: 0.9rem; transition: all 0.3s; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem;"
                                                                onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 5px 15px rgba(220,53,69,0.4)';" 
                                                                onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='none';">
                                                            <i class="fas fa-trash"></i> Delete Message
                                                        </button>
                                                    </div>
                                                </c:if>
                                            </div>
                                            
                                            <!-- Admin Reply (if exists) -->
                                            <c:if test="${not empty msg.adminReply}">
                                                <div class="message-bubble admin" style="background: linear-gradient(135deg, #fff3e0, #ffe0b2); border-radius: 18px; padding: 1.5rem; border-left: 4px solid #ff9800; position: relative;">
                                                    <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem;">
                                                        <div style="width: 40px; height: 40px; background: linear-gradient(135deg, #ff9800, #f57c00); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">
                                                            <i class="fas fa-user-shield"></i>
                                                        </div>
                                                        <div>
                                                            <div style="font-weight: 700; color: #2c2c2c; font-size: 1rem;">Support Team</div>
                                                            <div style="color: #6c757d; font-size: 0.85rem;" class="format-date" data-date="${msg.repliedAt}">${msg.repliedAt}</div>
                                                        </div>
                                                    </div>
                                                    <p style="margin: 0; color: #2c2c2c; line-height: 1.6; font-size: 1rem; white-space: pre-wrap;"><c:out value="${msg.adminReply}"/></p>
                                                </div>
                                            </c:if>
                                            
                                            <!-- Waiting for Reply -->
                                            <c:if test="${empty msg.adminReply}">
                                                <div class="waiting-reply" style="background: linear-gradient(135deg, #f8f9fa, #e9ecef); border-radius: 18px; padding: 2rem; text-align: center; border: 2px dashed #6c757d;">
                                                    <div style="margin-bottom: 1rem;">
                                                        <i class="fas fa-hourglass-half" style="font-size: 2.5rem; color: #6c757d; animation: pulse 2s infinite;"></i>
                                                    </div>
                                                    <h4 style="margin: 0 0 0.5rem 0; color: #495057; font-size: 1.1rem;">Waiting for Admin Response</h4>
                                                    <p style="margin: 0; color: #6c757d; font-size: 0.95rem;">Our support team will respond to your message soon. Check back later for updates!</p>
                                                </div>
                                            </c:if>
                                            
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>


    </div>

    <!-- Include Customer Footer -->
    <jsp:include page="../../customer_footer.jsp" />

    <style>
        /* Add pulse animation for waiting messages */
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.5; }
            100% { opacity: 1; }
        }
        
        /* Hover effects for message threads */
        .message-thread:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12) !important;
        }
        
        /* Responsive design for message bubbles */
        @media (max-width: 768px) {
            .message-filters > div {
                flex-direction: column;
                align-items: flex-start !important;
            }
            .message-filters > div > div {
                flex-direction: column;
                align-items: flex-start !important;
                gap: 0.5rem !important;
            }
        }
    </style>

    <script>
        // Date formatting function
        function formatDateTime(dateTimeString) {
            if (!dateTimeString) return '';
            
            try {
                // Handle LocalDateTime format from Java
                const date = new Date(dateTimeString);
                
                // Format: Oct 21, 2025 at 6:41 PM
                const options = {
                    year: 'numeric',
                    month: 'short',
                    day: 'numeric',
                    hour: 'numeric',
                    minute: '2-digit',
                    hour12: true
                };
                
                return date.toLocaleDateString('en-US', options).replace(',', ' at');
            } catch (e) {
                // Fallback to original string if parsing fails
                return dateTimeString;
            }
        }

        // Message filtering and sorting functionality
        function initializeMessageFilters() {
            const statusFilter = document.getElementById('statusFilter');
            const sortOrder = document.getElementById('sortOrder');
            const messageThreads = document.querySelectorAll('.message-thread');
            
            if (!statusFilter || !sortOrder) return;
            
            function filterAndSortMessages() {
                const statusValue = statusFilter.value;
                const sortValue = sortOrder.value;
                
                // Convert NodeList to Array for sorting
                const threadsArray = Array.from(messageThreads);
                
                // Filter messages
                threadsArray.forEach(thread => {
                    const status = thread.dataset.status;
                    let shouldShow = true;
                    
                    if (statusValue === 'pending' && status !== 'NEW' && status !== 'READ') {
                        shouldShow = false;
                    } else if (statusValue === 'replied' && status !== 'REPLIED') {
                        shouldShow = false;
                    }
                    
                    thread.style.display = shouldShow ? 'block' : 'none';
                });
                
                // Sort visible messages
                const visibleThreads = threadsArray.filter(thread => thread.style.display !== 'none');
                const container = document.querySelector('.messages-list');
                
                visibleThreads.sort((a, b) => {
                    const dateA = new Date(a.dataset.date);
                    const dateB = new Date(b.dataset.date);
                    
                    if (sortValue === 'newest') {
                        return dateB.getTime() - dateA.getTime(); // Newest first
                    } else {
                        return dateA.getTime() - dateB.getTime(); // Oldest first
                    }
                });
                
                // Re-append sorted elements
                visibleThreads.forEach(thread => {
                    container.appendChild(thread);
                });
                
                // Update message count
                updateMessageCount(visibleThreads.length, messageThreads.length);
            }
            
            function updateMessageCount(visible, total) {
                let countElement = document.getElementById('messageCount');
                if (!countElement) {
                    countElement = document.createElement('div');
                    countElement.id = 'messageCount';
                    countElement.style.cssText = 'text-align: center; margin: 1rem 0; color: #6c757d; font-style: italic;';
                    document.querySelector('.message-filters').after(countElement);
                }
                
                if (visible === total) {
                    countElement.textContent = 'Showing all ' + total + ' message' + (total !== 1 ? 's' : '');
                } else {
                    countElement.textContent = 'Showing ' + visible + ' of ' + total + ' message' + (total !== 1 ? 's' : '');
                }
            }
            
            // Add event listeners
            statusFilter.addEventListener('change', filterAndSortMessages);
            sortOrder.addEventListener('change', filterAndSortMessages);
            
            // Initialize count
            updateMessageCount(messageThreads.length, messageThreads.length);
        }
        
        // Auto-hide success/error messages after 10 seconds
        window.addEventListener('DOMContentLoaded', function() {
            // Initialize message filters
            initializeMessageFilters();
            
            // Format all dates
            document.querySelectorAll('.format-date').forEach(function(element) {
                const rawDate = element.getAttribute('data-date');
                if (rawDate) {
                    element.textContent = formatDateTime(rawDate);
                }
            });
            const successMsg = document.querySelector('.success-message.show');
            const errorMsg = document.querySelector('.error-message.show');
            
            if (successMsg) {
                setTimeout(() => {
                    successMsg.classList.remove('show');
                }, 10000);
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
            
            if (errorMsg) {
                setTimeout(() => {
                    errorMsg.classList.remove('show');
                }, 10000);
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
            
            // Edit message buttons
            document.querySelectorAll('.edit-msg-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const id = this.dataset.id;
                    const subject = this.dataset.subject;
                    const message = this.dataset.message;
                    
                    // Scroll to form
                    document.getElementById('contactForm').scrollIntoView({ behavior: 'smooth' });
                    
                    // Fill form
                    document.getElementById('subject').value = subject;
                    document.getElementById('message').value = message;
                    
                    // Change form to update mode
                    const form = document.getElementById('contactForm');
                    form.innerHTML += '<input type="hidden" name="messageId" value="' + id + '">';
                    
                    // Change button text
                    const submitBtn = form.querySelector('.submit-btn');
                    submitBtn.innerHTML = '<i class="fas fa-save"></i> Update Message';
                    submitBtn.style.background = 'linear-gradient(135deg, #ff9800, #f39c12)';
                    
                    // Add cancel button
                    if (!document.getElementById('cancelEditBtn')) {
                        const cancelBtn = document.createElement('button');
                        cancelBtn.id = 'cancelEditBtn';
                        cancelBtn.type = 'button';
                        cancelBtn.className = 'submit-btn';
                        cancelBtn.innerHTML = '<i class="fas fa-times"></i> Cancel';
                        cancelBtn.style.background = 'linear-gradient(135deg, #6c757d, #495057)';
                        cancelBtn.style.marginLeft = '1rem';
                        cancelBtn.onclick = function() {
                            location.reload();
                        };
                        submitBtn.parentNode.insertBefore(cancelBtn, submitBtn.nextSibling);
                    }
                });
            });
            
            // Delete message buttons
            document.querySelectorAll('.delete-msg-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const id = this.dataset.id;
                    
                    if (confirm('Are you sure you want to delete this message? This action cannot be undone.')) {
                        // Create form and submit
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = '${pageContext.request.contextPath}/customer/contact/delete/' + id;
                        document.body.appendChild(form);
                        form.submit();
                    }
                });
            });
        });
    </script>
</body>
</html>
