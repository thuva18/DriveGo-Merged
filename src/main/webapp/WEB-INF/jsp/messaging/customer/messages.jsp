<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Messages - DriveGo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            color: #667eea;
            font-size: 2em;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .header h1 i {
            font-size: 1.2em;
        }
        
        .back-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 20px;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-icon {
            font-size: 3em;
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 15px;
        }
        
        .stat-icon.total {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        .stat-icon.new {
            background: linear-gradient(135deg, #f093fb, #f5576c);
            color: white;
        }
        
        .stat-icon.replied {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
        }
        
        .stat-info h3 {
            font-size: 2.5em;
            color: #667eea;
            margin-bottom: 5px;
        }
        
        .stat-info p {
            color: #888;
            font-size: 1.1em;
        }
        
        .messages-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        
        .message-card {
            background: #f8f9fa;
            border-left: 5px solid #667eea;
            padding: 25px;
            margin-bottom: 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .message-card:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .message-card.replied {
            border-left-color: #4caf50;
            background: #e8f5e9;
        }
        
        .message-card.new {
            border-left-color: #ff5722;
            background: #fff3e0;
        }
        
        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .message-subject {
            font-size: 1.4em;
            color: #333;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .message-status {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-new {
            background: #ff5722;
            color: white;
        }
        
        .status-read {
            background: #ff9800;
            color: white;
        }
        
        .status-replied {
            background: #4caf50;
            color: white;
        }
        
        .status-closed {
            background: #9e9e9e;
            color: white;
        }
        
        .message-meta {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            color: #666;
            font-size: 0.95em;
        }
        
        .message-meta i {
            color: #667eea;
        }
        
        .message-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 15px;
            line-height: 1.6;
            color: #444;
        }
        
        .message-content p {
            margin: 0;
        }
        
        .reply-section {
            background: linear-gradient(135deg, #e8f5e9, #c8e6c9);
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #4caf50;
            margin-top: 15px;
        }
        
        .reply-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            color: #2e7d32;
            font-weight: 600;
        }
        
        .reply-header i {
            font-size: 1.3em;
        }
        
        .reply-meta {
            font-size: 0.85em;
            color: #555;
            margin-bottom: 10px;
        }
        
        .reply-content {
            background: white;
            padding: 15px;
            border-radius: 6px;
            line-height: 1.6;
            color: #333;
        }
        
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #888;
        }
        
        .empty-state i {
            font-size: 5em;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        .empty-state h3 {
            font-size: 1.8em;
            margin-bottom: 15px;
            color: #555;
        }
        
        .empty-state p {
            font-size: 1.1em;
            margin-bottom: 30px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
                gap: 20px;
            }
            
            .header h1 {
                font-size: 1.5em;
            }
            
            .stats-container {
                grid-template-columns: 1fr;
            }
            
            .message-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>
                <i class="fas fa-inbox"></i>
                My Messages
            </h1>
            <a href="<c:url value='/customer/contact'/>" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Contact
            </a>
        </div>
        
        <!-- Statistics -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon total">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalMessages}</h3>
                    <p>Total Messages</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon new">
                    <i class="fas fa-envelope-open"></i>
                </div>
                <div class="stat-info">
                    <h3>${newCount}</h3>
                    <p>Pending</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon replied">
                    <i class="fas fa-reply"></i>
                </div>
                <div class="stat-info">
                    <h3>${repliedCount}</h3>
                    <p>Replied</p>
                </div>
            </div>
        </div>
        
        <!-- Messages List -->
        <div class="messages-container">
            <c:choose>
                <c:when test="${empty messages}">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>No Messages Yet</h3>
                        <p>You haven't sent any messages. Contact us if you need any assistance!</p>
                        <a href="<c:url value='/customer/contact'/>" class="btn-primary">
                            <i class="fas fa-paper-plane"></i> Send a Message
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="msg" items="${messages}">
                        <div class="message-card ${msg.status.toLowerCase()}">
                            <!-- Message Header -->
                            <div class="message-header">
                                <div class="message-subject">
                                    <i class="fas fa-envelope"></i>
                                    <c:out value="${msg.subject}"/>
                                </div>
                                <span class="message-status status-${msg.status.toLowerCase()}">
                                    <c:out value="${msg.status}"/>
                                </span>
                            </div>
                            
                            <!-- Message Meta -->
                            <div class="message-meta">
                                <span>
                                    <i class="fas fa-calendar"></i>
                                    Sent: <fmt:formatDate value="${msg.createdAt}" pattern="MMM dd, yyyy 'at' hh:mm a"/>
                                </span>
                                <span>
                                    <i class="fas fa-tag"></i>
                                    ID: #${msg.id}
                                </span>
                            </div>
                            
                            <!-- Original Message -->
                            <div class="message-content">
                                <p><c:out value="${msg.message}"/></p>
                            </div>
                            
                            <!-- Admin Reply (if exists) -->
                            <c:if test="${not empty msg.adminReply}">
                                <div class="reply-section">
                                    <div class="reply-header">
                                        <i class="fas fa-reply"></i>
                                        <span>Admin Reply</span>
                                    </div>
                                    <div class="reply-meta">
                                        <c:if test="${not empty msg.repliedBy}">
                                            <i class="fas fa-user"></i> Replied by: <c:out value="${msg.repliedBy}"/> • 
                                        </c:if>
                                        <c:if test="${not empty msg.repliedAt}">
                                            <i class="fas fa-clock"></i> 
                                            <fmt:formatDate value="${msg.repliedAt}" pattern="MMM dd, yyyy 'at' hh:mm a"/>
                                        </c:if>
                                    </div>
                                    <div class="reply-content">
                                        <c:out value="${msg.adminReply}"/>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
