<%@include file="../../admin-header.jsp" %>

<style>
        /* Contact Messages Styles */
        
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            display: flex;
            align-items: center;
            gap: 15px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
        }
        
        .stat-icon {
            font-size: 2.5em;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }
        
        .stat-icon.new {
            background: #e3f2fd;
            color: #2196f3;
        }
        
        .stat-icon.read {
            background: #fff3e0;
            color: #ff9800;
        }
        
        .stat-icon.replied {
            background: #e8f5e9;
            color: #4caf50;
        }
        
        .stat-icon.closed {
            background: #fce4ec;
            color: #e91e63;
        }
        
        .stat-info h3 {
            font-size: 2em;
            color: #2c3e50;
            margin-bottom: 5px;
        }
        
        .stat-info p {
            color: #7f8c8d;
            font-size: 0.9em;
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .alert-error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .filter-bar {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.95em;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #2c3e50;
        }
        
        .filter-btn:hover {
            border-color: #667eea;
            color: #667eea;
        }
        
        .filter-btn.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: #667eea;
            color: white;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
        }
        
        th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85em;
            letter-spacing: 0.5px;
        }
        
        tbody tr {
            border-bottom: 1px solid #e0e0e0;
            transition: background-color 0.2s ease;
        }
        
        tbody tr:hover {
            background: #f8f9fa;
        }
        
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85em;
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
        
        .action-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9em;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-view {
            background: #667eea;
            color: white;
        }
        
        .btn-view:hover {
            background: #5568d3;
        }
        
        .btn-delete {
            background: #e74c3c;
            color: white;
            margin-left: 5px;
        }
        
        .btn-delete:hover {
            background: #c0392b;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #7f8c8d;
        }
        
        .empty-state i {
            font-size: 4em;
            margin-bottom: 20px;
            opacity: 0.3;
        }
        
        .empty-state h3 {
            font-size: 1.5em;
            margin-bottom: 10px;
        }
        
        .message-preview {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
            <i class="fas fa-envelope"></i>
            Contact Messages
        </h1>
        <div class="page-subtitle">Manage customer inquiries and support messages</div>
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

<!-- Statistics -->
<div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon new">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="stat-info">
                    <h3>${newCount}</h3>
                    <p>New Messages</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon read">
                    <i class="fas fa-envelope-open"></i>
                </div>
                <div class="stat-info">
                    <h3>${readCount}</h3>
                    <p>Read Messages</p>
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
            
            <div class="stat-card">
                <div class="stat-icon closed">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>${closedCount}</h3>
                    <p>Closed</p>
                </div>
            </div>
        </div>
        
        <!-- Filter Bar -->
        <div class="filter-bar">
            <a href="<c:url value='/admin/contacts'/>" 
               class="filter-btn ${empty filterStatus ? 'active' : ''}">
                <i class="fas fa-list"></i> All Messages
            </a>
            <a href="<c:url value='/admin/contacts?status=NEW'/>" 
               class="filter-btn ${filterStatus == 'NEW' ? 'active' : ''}">
                <i class="fas fa-envelope"></i> New
            </a>
            <a href="<c:url value='/admin/contacts?status=READ'/>" 
               class="filter-btn ${filterStatus == 'READ' ? 'active' : ''}">
                <i class="fas fa-envelope-open"></i> Read
            </a>
            <a href="<c:url value='/admin/contacts?status=REPLIED'/>" 
               class="filter-btn ${filterStatus == 'REPLIED' ? 'active' : ''}">
                <i class="fas fa-reply"></i> Replied
            </a>
            <a href="<c:url value='/admin/contacts?status=CLOSED'/>" 
               class="filter-btn ${filterStatus == 'CLOSED' ? 'active' : ''}">
                <i class="fas fa-check-circle"></i> Closed
            </a>
        </div>
        
        <!-- Messages Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${empty messages}">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <h3>No Messages Found</h3>
                        <p>There are no contact messages 
                           <c:if test="${not empty filterStatus}">
                               with status: <strong>${filterStatus}</strong>
                           </c:if>
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Subject</th>
                                <th>Message</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="msg" items="${messages}">
                                <tr>
                                    <td><strong>#${msg.id}</strong></td>
                                    <td><c:out value="${msg.name}"/></td>
                                    <td><c:out value="${msg.email}"/></td>
                                    <td><c:out value="${msg.subject}"/></td>
                                    <td>
                                        <div class="message-preview">
                                            <c:out value="${msg.message}"/>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="status-badge status-${msg.status.toLowerCase()}">
                                            ${msg.status}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${msg.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                                    </td>
                                    <td>
                                        <a href="<c:url value='/admin/contacts/${msg.id}'/>" 
                                           class="action-btn btn-view">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <form method="post" 
                                              action="<c:url value='/admin/contacts/${msg.id}/delete'/>" 
                                              style="display: inline;"
                                              onsubmit="return confirm('Are you sure you want to delete this message?');">
                                            <button type="submit" class="action-btn btn-delete">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

<%@include file="../../admin-footer.jsp" %>
