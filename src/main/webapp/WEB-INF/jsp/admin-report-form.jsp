<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="admin-header.jsp" %>

<style>
  .form-container {
    max-width: 800px;
    margin: 0 auto;
  }
  
  .form-header {
    margin-bottom: 24px;
  }
  
  .form-header h2 {
    color: #2c3e50;
    font-size: 28px;
    font-weight: 600;
    margin: 0;
  }
  
  .alert-error {
    background-color: #fee;
    border: 1px solid #fcc;
    color: #c33;
    padding: 12px 16px;
    border-radius: 6px;
    margin-bottom: 20px;
  }
  
  .form-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 32px;
  }
  
  .form-group {
    margin-bottom: 24px;
  }
  
  .form-group label {
    display: block;
    margin-bottom: 8px;
    color: #2c3e50;
    font-weight: 600;
    font-size: 14px;
  }
  
  .form-group input[type="text"],
  .form-group input[type="date"],
  .form-group select {
    width: 100%;
    padding: 12px 16px;
    border: 2px solid #e1e8ed;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s ease;
    background-color: #fff;
  }
  
  .form-group input[type="text"]:focus,
  .form-group input[type="date"]:focus,
  .form-group select:focus {
    outline: none;
    border-color: #16a34a;
    box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.1);
  }
  
  .form-group select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23666' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 12px center;
    padding-right: 40px;
  }
  
  .checkbox-group {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px;
    background-color: #f8f9fa;
    border-radius: 6px;
    margin-bottom: 24px;
  }
  
  .checkbox-group input[type="checkbox"] {
    width: 20px;
    height: 20px;
    cursor: pointer;
    accent-color: #16a34a;
    margin: 0;
  }
  
  .checkbox-group label {
    margin: 0;
    font-weight: 500;
    color: #495057;
    cursor: pointer;
    user-select: none;
  }
  
  .form-actions {
    display: flex;
    gap: 12px;
    margin-top: 32px;
  }
  
  .btn {
    padding: 12px 24px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
    cursor: pointer;
    border: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
  }
  
  .btn-primary {
    background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
    color: white;
    box-shadow: 0 4px 12px rgba(22, 163, 74, 0.3);
  }
  
  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(16, 185, 129, 0.4);
  }
  
  .btn-secondary {
    background-color: #e9ecef;
    color: #495057;
  }
  
  .btn-secondary:hover {
    background-color: #dee2e6;
    transform: translateY(-1px);
  }
  
  .form-hint {
    color: #6c757d;
    font-size: 13px;
    margin-top: 6px;
  }
</style>

<c:set var="isNew" value="${isNew}"/>
<c:choose>
  <c:when test="${isNew}">
    <c:url var="actionUrl" value="/reports"/>
  </c:when>
  <c:otherwise>
    <c:url var="actionUrl" value="/reports/${report.id}"/>
  </c:otherwise>
</c:choose>

<div class="form-container">
  <div class="form-header">
    <h2><c:out value="${isNew ? '📊 Create New Report' : '✏️ Edit Report'}"/></h2>
  </div>

  <c:if test="${not empty error}">
    <div class="alert-error">
      <strong>Error:</strong> ${error}
    </div>
  </c:if>

  <div class="form-card">
    <form method="post" action="${actionUrl}">
      <div class="form-group">
        <label for="name">Report Name *</label>
        <input type="text" id="name" name="name" value="<c:out value='${report.name}'/>" 
               placeholder="e.g., Q4 Revenue Report" required>
        <div class="form-hint">Enter a descriptive name for this report</div>
      </div>

      <div class="form-group">
        <label for="type">Report Type *</label>
        <select id="type" name="type" required>
          <option value="">-- Select Report Type --</option>
          <option value="revenue" <c:if test="${report.type=='revenue'}">selected</c:if>>💰 Revenue Report</option>
          <option value="fleet" <c:if test="${report.type=='fleet'}">selected</c:if>>🚗 Fleet Usage Report</option>
          <option value="customers" <c:if test="${report.type=='customers'}">selected</c:if>>👥 Customer Report</option>
        </select>
        <div class="form-hint">Choose the type of analytics report to generate</div>
      </div>

      <div class="form-group">
        <label for="from">Start Date *</label>
        <input type="date" id="from" name="from" value="<c:out value='${report.fromDate}'/>" required>
        <div class="form-hint">Select the start date for the report period</div>
      </div>

      <div class="form-group">
        <label for="to">End Date *</label>
        <input type="date" id="to" name="to" value="<c:out value='${report.toDate}'/>" required>
        <div class="form-hint">Select the end date for the report period</div>
      </div>

      <div class="checkbox-group">
        <input type="checkbox" id="regenerate" name="regenerate" value="1" checked>
        <label for="regenerate">Generate/Regenerate report data now</label>
      </div>

      <div class="form-actions">
        <button class="btn btn-primary" type="submit">
          <i class="fa fa-save"></i> ${isNew ? 'Create Report' : 'Save Changes'}
        </button>
        <a href="<c:url value='/reports/manage'/>" class="btn btn-secondary">
          <i class="fa fa-times"></i> Cancel
        </a>
      </div>
    </form>
  </div>
</div>

<%@ include file="admin-footer.jsp" %>
