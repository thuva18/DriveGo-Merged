<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="admin-header.jsp" %>

<style>
  .reports-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
    flex-wrap: wrap;
    gap: 16px;
  }
  
  .reports-header-left h2 {
    margin: 0 0 8px 0;
    color: #2c3e50;
    font-size: 28px;
    font-weight: 600;
  }
  
  .reports-header-left p {
    margin: 0;
    color: #7f8c8d;
    font-size: 14px;
  }
  
  .alert-success {
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
    color: #155724;
    padding: 12px 16px;
    border-radius: 6px;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .alert-success::before {
    content: "✓";
    font-weight: bold;
    font-size: 18px;
  }
  
  .reports-table-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .reports-table-card table {
    width: 100%;
    border-collapse: collapse;
  }
  
  .reports-table-card thead {
    background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
    color: white;
  }
  
  .reports-table-card thead th {
    padding: 16px 12px;
    text-align: left;
    font-weight: 600;
    font-size: 13px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    border: none;
  }
  
  .reports-table-card tbody tr {
    border-bottom: 1px solid #e9ecef;
    transition: background-color 0.2s ease;
  }
  
  .reports-table-card tbody tr:hover {
    background-color: #f8f9fa;
    cursor: pointer;
  }
  
  .reports-table-card tbody td {
    padding: 14px 12px;
    vertical-align: middle;
    font-size: 14px;
    color: #495057;
  }
  
  .report-id {
    font-family: 'Courier New', monospace;
    font-weight: 600;
    color: #16a34a;
    font-size: 13px;
  }
  
  .report-name {
    font-weight: 500;
    color: #2c3e50;
  }
  
  .report-type-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 600;
    text-transform: capitalize;
  }
  
  .report-type-revenue {
    background-color: #d4edda;
    color: #155724;
  }
  
  .report-type-fleet {
    background-color: #d1ecf1;
    color: #0c5460;
  }
  
  .report-type-customers {
    background-color: #fff3cd;
    color: #856404;
  }
  
  .report-date {
    color: #6c757d;
    font-size: 13px;
  }
  
  .actions-cell {
    text-align: right;
  }
  
  .action-buttons {
    display: flex;
    gap: 8px;
    justify-content: flex-end;
    align-items: center;
  }
  
  .action-buttons .btn {
    padding: 6px 12px;
    font-size: 13px;
    border-radius: 5px;
    transition: all 0.2s ease;
    border: none;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }
  
  .btn-view {
    background-color: #16a34a;
    color: white;
  }
  
  .btn-view:hover {
    background-color: #15803d;
    transform: translateY(-1px);
    box-shadow: 0 2px 6px rgba(22, 163, 74, 0.4);
  }
  
  .btn-edit {
    background-color: #f59e0b;
    color: white;
  }
  
  .btn-edit:hover {
    background-color: #d97706;
    transform: translateY(-1px);
    box-shadow: 0 2px 6px rgba(245, 158, 11, 0.4);
  }
  
  .btn-delete {
    background-color: #ef4444;
    color: white;
  }
  
  .btn-delete:hover {
    background-color: #dc2626;
    transform: translateY(-1px);
    box-shadow: 0 2px 6px rgba(239, 68, 68, 0.4);
  }
  
  .btn-primary {
    background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
    color: white;
    padding: 12px 24px;
    border-radius: 6px;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s ease;
    border: none;
    box-shadow: 0 4px 12px rgba(22, 163, 74, 0.3);
    display: inline-flex;
    align-items: center;
    gap: 8px;
  }
  
  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
  }
  
  .empty-state {
    text-align: center;
    padding: 60px 20px;
    color: #95a5a6;
  }
  
  .empty-state i {
    font-size: 64px;
    margin-bottom: 16px;
    opacity: 0.3;
  }
  
  .empty-state p {
    font-size: 16px;
    margin: 8px 0;
  }
  
  .form-inline {
    display: inline;
  }
  
  @media (max-width: 768px) {
    .reports-header {
      flex-direction: column;
      align-items: flex-start;
    }
    
    .action-buttons {
      flex-direction: column;
      gap: 4px;
    }
    
    .action-buttons .btn {
      width: 100%;
      justify-content: center;
    }
  }
</style>

<div class="reports-header">
  <div class="reports-header-left">
    <h2><i class="fa fa-chart-bar"></i> Reports Management</h2>
    <p>Create, view, and manage your generated reports</p>
  </div>
  <a href="<c:url value='/reports/new'/>" class="btn-primary">
    <i class="fa fa-plus"></i> Create New Report
  </a>
</div>

<c:if test="${not empty info}">
  <div class="alert-success">
    <c:out value="${info}"/>
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert-error" style="background-color: #fee; border: 1px solid #fcc; color: #c33; padding: 12px 16px; border-radius: 6px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
    <i class="fa fa-exclamation-circle"></i>
    <span><c:out value="${error}"/></span>
  </div>
</c:if>

<div class="reports-table-card">
  <c:choose>
    <c:when test="${not empty reports}">
      <table>
        <thead>
          <tr>
            <th style="width: 120px;">Report ID</th>
            <th>Report Name</th>
            <th style="width: 140px;">Type</th>
            <th style="width: 120px;">Start Date</th>
            <th style="width: 120px;">End Date</th>
            <th style="width: 240px; text-align: right;">Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="r" items="${reports}">
            <tr class="clickable-row" data-href="<c:url value='/reports/${r.id}'/>">
              <td>
                <span class="report-id">
                  REP-<fmt:formatNumber value="${r.id}" minIntegerDigits="4" groupingUsed="false"/>
                </span>
              </td>
              <td>
                <span class="report-name"><c:out value='${r.name}'/></span>
              </td>
              <td>
                <span class="report-type-badge report-type-${r.type}">
                  <c:choose>
                    <c:when test="${r.type == 'revenue'}">💰 Revenue</c:when>
                    <c:when test="${r.type == 'fleet'}">🚗 Fleet</c:when>
                    <c:when test="${r.type == 'customers'}">👥 Customers</c:when>
                    <c:otherwise><c:out value="${r.type}"/></c:otherwise>
                  </c:choose>
                </span>
              </td>
              <td><span class="report-date">${r.fromDate}</span></td>
              <td><span class="report-date">${r.toDate}</span></td>
              <td class="actions-cell">
                <div class="action-buttons">
                  <a class="btn btn-view" href="<c:url value='/reports/${r.id}'/>" title="View Report">
                    <i class="fa fa-eye"></i> View
                  </a>
                  <a class="btn btn-edit" href="<c:url value='/reports/${r.id}/edit'/>" title="Edit Report">
                    <i class="fa fa-pen"></i> Edit
                  </a>
                  <form method="post" action="<c:url value='/reports/${r.id}/delete'/>" class="form-inline" 
                        onsubmit="return confirm('Are you sure you want to delete this report?');">
                    <button class="btn btn-delete" type="submit" title="Delete Report">
                      <i class="fa fa-trash"></i> Delete
                    </button>
                  </form>
                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:when>
    <c:otherwise>
      <div class="empty-state">
        <i class="fa fa-file-chart-line"></i>
        <p><strong>No reports yet</strong></p>
        <p>Click "Create New Report" to generate your first report</p>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<script>
  (function(){
    document.querySelectorAll('tr.clickable-row').forEach(function(tr){
      tr.addEventListener('click', function(e){
        if (e.target.closest('a,button,form')) return; // allow button/link clicks
        var href = tr.getAttribute('data-href');
        if (href) window.location.href = href;
      });
    });
  })();
</script>

<%@ include file="admin-footer.jsp" %>
