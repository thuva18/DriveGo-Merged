<%@include file="../../admin-header.jsp" %>

<style>
        /* Contact Detail Styles */
        
        .message-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .message-header {
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }
        
        .message-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .meta-label {
            font-size: 0.85em;
            color: #7f8c8d;
            text-transform: uppercase;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        
        .meta-value {
            font-size: 1.1em;
            color: #2c3e50;
            font-weight: 500;
        }
        
        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-new {
            background: #e3f2fd;
            color: #2196f3;
        }
        
        .status-read {
            background: #fff3e0;
            color: #ff9800;
        }
        
        .status-replied {
            background: #e8f5e9;
            color: #4caf50;
        }
        
        .status-closed {
            background: #fce4ec;
            color: #e91e63;
        }
        
        .message-body {
            margin: 20px 0;
        }
        
        .message-body h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.2em;
        }
        
        .message-content {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #667eea;
            line-height: 1.6;
            color: #2c3e50;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        
        .reply-section {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .reply-section h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 1.3em;
        }
        
        .existing-reply {
            background: #e8f5e9;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #4caf50;
            margin-bottom: 20px;
        }
        
        .existing-reply-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.9em;
            color: #666;
        }
        
        .existing-reply-content {
            color: #2c3e50;
            line-height: 1.6;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2c3e50;
            font-weight: 600;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            font-family: inherit;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: #667eea;
            color: white;
        }
        
        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
        }
        
        .btn-success {
            background: #4caf50;
            color: white;
        }
        
        .btn-success:hover {
            background: #43a047;
        }
        
        .btn-danger {
            background: #e74c3c;
            color: white;
        }
        
        .btn-danger:hover {
            background: #c0392b;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        .status-actions {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .status-actions h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.1em;
        }
        
        .back-link {
            margin-top: 20px;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-size: 1.1em;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>

<div class="page-header">
    <div class="page-header-content">
        <h1 class="page-title">
            <i class="fas fa-envelope-open"></i>
            Message Details #${message.id}
        </h1>
        <div class="page-subtitle">View and respond to customer message</div>
    </div>
    <div class="page-actions">
        <a href="<c:url value='/admin/contacts'/>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Messages
        </a>
    </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty success}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span><c:out value="${success}"/></span>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <span><c:out value="${error}"/></span>
    </div>
</c:if>
        
        <!-- Message Details -->
        <div class="message-card">
            <div class="message-header">
                <div class="message-meta">
                    <div class="meta-item">
                        <span class="meta-label">From</span>
                        <span class="meta-value"><c:out value="${message.name}"/></span>
                    </div>
                    
                    <div class="meta-item">
                        <span class="meta-label">Email</span>
                        <span class="meta-value">
                            <a href="mailto:${message.email}" style="color: #667eea;">
                                <c:out value="${message.email}"/>
                            </a>
                        </span>
                    </div>
                    
                    <div class="meta-item">
                        <span class="meta-label">Status</span>
                        <span class="status-badge status-${message.status.toLowerCase()}">
                            ${message.status}
                        </span>
                    </div>
                    
                    <div class="meta-item">
                        <span class="meta-label">Received</span>
                        <span class="meta-value">
                            <fmt:formatDate value="${message.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                </div>
                
                <div class="meta-item" style="margin-top: 15px;">
                    <span class="meta-label">Subject</span>
                    <span class="meta-value" style="font-size: 1.3em;">
                        <c:out value="${message.subject}"/>
                    </span>
                </div>
            </div>
            
            <div class="message-body">
                <h3><i class="fas fa-comment-dots"></i> Message</h3>
                <div class="message-content">
                    <c:out value="${message.message}"/>
                </div>
            </div>
        </div>
        
        <!-- Existing Reply (if any) -->
        <c:if test="${not empty message.adminReply}">
            <div class="reply-section">
                <h3><i class="fas fa-reply"></i> Your Reply</h3>
                <div class="existing-reply">
                    <div class="existing-reply-header">
                        <span>
                            <i class="fas fa-user"></i> 
                            Replied by: <strong>${message.repliedBy}</strong>
                        </span>
                        <span>
                            <i class="fas fa-clock"></i>
                            <fmt:formatDate value="${message.repliedAt}" pattern="yyyy-MM-dd HH:mm"/>
                        </span>
                    </div>
                    <div class="existing-reply-content">
                        <c:out value="${message.adminReply}"/>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- Reply Form -->
        <div class="reply-section">
            <h3>
                <i class="fas fa-paper-plane"></i> 
                <c:choose>
                    <c:when test="${not empty message.adminReply}">Update Reply</c:when>
                    <c:otherwise>Send Reply</c:otherwise>
                </c:choose>
            </h3>
            
            <form method="post" action="<c:url value='/admin/contacts/${message.id}/reply'/>">
                <div class="form-group">
                    <label for="reply">Reply Message *</label>
                    <textarea id="reply" 
                              name="reply" 
                              class="form-control" 
                              placeholder="Type your reply here..."
                              required><c:if test="${not empty message.adminReply}"><c:out value="${message.adminReply}"/></c:if></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-paper-plane"></i> Send Reply
                </button>
            </form>
        </div>
        
        <!-- Status Actions -->
        <div class="status-actions">
            <h3><i class="fas fa-tasks"></i> Quick Actions</h3>
            <div class="action-buttons">
                <form method="post" action="<c:url value='/admin/contacts/${message.id}/status'/>" style="display: inline;">
                    <input type="hidden" name="status" value="READ">
                    <button type="submit" class="btn btn-secondary">
                        <i class="fas fa-envelope-open"></i> Mark as Read
                    </button>
                </form>
                
                <form method="post" action="<c:url value='/admin/contacts/${message.id}/status'/>" style="display: inline;">
                    <input type="hidden" name="status" value="CLOSED">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-check-circle"></i> Close Message
                    </button>
                </form>
                
                <form method="post" 
                      action="<c:url value='/admin/contacts/${message.id}/delete'/>" 
                      style="display: inline;"
                      onsubmit="return confirm('Are you sure you want to delete this message?');">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Message
                    </button>
                </form>
            </div>
        </div>
    </div>

<%@include file="../../admin-footer.jsp" %>
