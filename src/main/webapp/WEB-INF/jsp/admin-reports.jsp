<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="admin-header.jsp" %>

<style>
  .report-header {
    margin-bottom: 24px;
  }
  
  .report-header h2 {
    color: #2c3e50;
    font-size: 28px;
    font-weight: 600;
    margin: 0 0 8px 0;
  }
  
  .report-header p {
    color: #7f8c8d;
    margin: 0;
  }
  
  .alert-box {
    padding: 12px 16px;
    border-radius: 6px;
    margin-bottom: 16px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .alert-error {
    background-color: #fee;
    border: 1px solid #fcc;
    color: #c33;
  }
  
  .alert-success {
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
    color: #155724;
  }
  
  .filter-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 24px;
    margin-bottom: 20px;
  }
  
  .filter-form {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 16px;
    margin-bottom: 16px;
  }
  
  .form-field {
    display: flex;
    flex-direction: column;
  }
  
  .form-field label {
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 6px;
    font-size: 14px;
  }
  
  .form-field input,
  .form-field select {
    padding: 10px 12px;
    border: 2px solid #e1e8ed;
    border-radius: 6px;
    font-size: 14px;
    transition: all 0.3s ease;
  }
  
  .form-field input:focus,
  .form-field select:focus {
    outline: none;
    border-color: #16a34a;
    box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.1);
  }
  
  .form-field select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23666' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 12px center;
    padding-right: 36px;
  }
  
  .button-group {
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
    align-items: center;
  }
  
  .btn {
    padding: 10px 20px;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
  }
  
  .btn-primary {
    background: linear-gradient(135deg, #16a34a 0%, #22c55e 100%);
    color: white;
    box-shadow: 0 4px 12px rgba(22, 163, 74, 0.3);
  }
  
  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(22, 163, 74, 0.4);
  }
  
  .btn-secondary {
    background-color: #f3f4f6;
    color: #374151;
    border: 2px solid #e5e7eb;
  }
  
  .btn-secondary:hover {
    background-color: #e5e7eb;
    transform: translateY(-1px);
  }
  
  .report-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 24px;
    margin-bottom: 20px;
  }
  
  .report-card h3 {
    color: #2c3e50;
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 20px 0;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .chart-container {
    position: relative;
    height: 300px;
    margin-top: 16px;
  }
  
  .empty-state {
    text-align: center;
    padding: 40px 20px;
    color: #95a5a6;
  }
  
  .empty-state i {
    font-size: 48px;
    margin-bottom: 12px;
    opacity: 0.3;
  }
  
  .table-responsive {
    overflow-x: auto;
  }
  
  .data-table {
    width: 100%;
    border-collapse: collapse;
  }
  
  .data-table thead {
    background-color: #f8f9fa;
  }
  
  .data-table th {
    padding: 12px;
    text-align: left;
    font-weight: 600;
    color: #2c3e50;
    border-bottom: 2px solid #e9ecef;
    font-size: 13px;
  }
  
  .data-table td {
    padding: 12px;
    border-bottom: 1px solid #e9ecef;
    color: #495057;
  }
  
  .data-table tbody tr:hover {
    background-color: #f8f9fa;
  }
  
  .data-table tfoot {
    font-weight: 600;
    background-color: #f8f9fa;
  }
  
  .text-right {
    text-align: right !important;
  }
  
  .text-muted {
    color: #6c757d;
  }
  
  @media print {
    .no-print {
      display: none !important;
    }
    
    .print-header {
      display: block !important;
      text-align: center;
      margin-bottom: 20px;
      padding-bottom: 20px;
      border-bottom: 2px solid #000;
    }
  }
  
  .print-header {
    display: none;
  }
  
  @media (max-width: 768px) {
    .filter-form {
      grid-template-columns: 1fr;
    }
    
    .button-group {
      flex-direction: column;
      width: 100%;
    }
    
    .btn {
      width: 100%;
      justify-content: center;
    }
  }
</style>

<c:set var="reportType" value="${empty param.type ? 'revenue' : param.type}" />
<c:set var="typeValue" value="${reportType}" />

<!-- Print-only heading -->
<div class="print-header">
  <h2>DriveGo — <c:out value="${empty chartTitle ? 'Report' : chartTitle}"/></h2>
  <div>Range: <strong><c:out value="${param.from}"/></strong> to <strong><c:out value="${param.to}"/></strong></div>
  <div>Generated: <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(new java.util.Date()) %></div>
</div>

<div class="report-header no-print">
  <h2>📊 Reports</h2>
  <p>Choose a date range and type, then generate the report.</p>
</div>

<!-- Alert Messages -->
<c:if test="${not empty error}">
  <div class="alert-box alert-error no-print">
    <i class="fa fa-exclamation-circle"></i>
    <strong>Validation:</strong> <c:out value="${error}"/>
  </div>
</c:if>
<c:if test="${not empty info}">
  <div class="alert-box alert-success no-print">
    <i class="fa fa-check-circle"></i>
    <strong>Info:</strong> <c:out value="${info}"/>
  </div>
</c:if>

<!-- Filter Card -->
<div class="filter-card no-print">
  <form id="reportForm" method="get" action="<c:url value='/reports'/>">
    <div class="filter-form">
      <div class="form-field">
        <label for="reportNameInput">Report Name</label>
        <input type="text" id="reportNameInput" name="_name" placeholder="e.g., Q2 Revenue" value="<c:out value='${param._name}'/>">
      </div>
      
      <div class="form-field">
        <label for="from">From Date *</label>
        <input type="date" id="from" name="from" value="<c:out value='${param.from}'/>" required>
      </div>

      <div class="form-field">
        <label for="to">To Date *</label>
        <input type="date" id="to" name="to" value="<c:out value='${param.to}'/>" required>
      </div>

      <div class="form-field">
        <label for="type">Report Type *</label>
        <select name="type" id="type" required>
          <option value="revenue" <c:if test="${reportType=='revenue'}">selected</c:if>>💰 Revenue</option>
          <option value="fleet" <c:if test="${reportType=='fleet'}">selected</c:if>>🚗 Fleet Usage</option>
          <option value="customers" <c:if test="${reportType=='customers'}">selected</c:if>>👥 Customer Activity</option>
        </select>
      </div>
    </div>

    <div class="button-group">
      <button class="btn btn-primary" type="submit">
        <i class="fa fa-play"></i> Generate Report
      </button>
      <button class="btn btn-secondary" type="button" onclick="window.print()">
        <i class="fa fa-file-pdf"></i> Export PDF
      </button>
      <button class="btn btn-secondary" type="button" onclick="saveReportNow()">
        <i class="fa fa-save"></i> Save Report
      </button>
      <input type="hidden" name="save" value="0">
    </div>
  </form>
  
  <form id="saveForm" method="post" action="<c:url value='/reports'/>" style="display: none;">
    <input type="hidden" name="name" id="saveName" value="Report">
    <input type="hidden" name="type" id="saveType" value="${reportType}">
    <input type="hidden" name="from" id="saveFrom" value="${param.from}">
    <input type="hidden" name="to" id="saveTo" value="${param.to}">
    <input type="hidden" name="regenerate" value="1">
  </form>
</div>

<!-- Report Preview Section -->
<div class="report-card">
  <h3>
    <i class="fa fa-chart-bar"></i>
    <c:out value="${empty chartTitle ? 'Report Preview' : chartTitle}"/>
  </h3>

  <c:choose>
    <c:when test="${empty chartLabelsJson or empty chartDataJson}">
      <div class="empty-state">
        <i class="fa fa-chart-line"></i>
        <p><strong>No data for the selected range</strong></p>
        <p class="text-muted">Please select a date range and click "Generate Report"</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="chart-container">
        <canvas id="reportChart"></canvas>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<!-- Details Table -->
<div class="report-card">
  <h3><i class="fa fa-table"></i> Report Details</h3>

  <div class="table-responsive">
    <table class="data-table">
      <thead>
        <tr>
          <th>Label</th>
          <th class="text-right">Value</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="r" items="${reportRows}">
          <tr>
            <td><c:out value="${r.label}"/></td>
            <td class="text-right"><c:out value="${r.value}"/></td>
          </tr>
        </c:forEach>
        <c:if test="${empty reportRows}">
          <tr>
            <td colspan="2" class="text-muted text-center" style="padding: 30px;">
              No details to display
            </td>
          </tr>
        </c:if>
      </tbody>
      <c:if test="${not empty tableTotalLabel}">
        <tfoot>
          <tr>
            <th><c:out value="${tableTotalLabel}"/></th>
            <th class="text-right"><c:out value="${tableTotalValue}"/></th>
          </tr>
        </tfoot>
      </c:if>
    </table>
  </div>
</div>

<!-- Client-side validation -->
<script>
  (function () {
    const form = document.getElementById('reportForm');
    const from = document.getElementById('from');
    const to   = document.getElementById('to');
    if (!form) return;

    const today = new Date().toISOString().slice(0, 10);
    if (from) from.max = today;
    if (to)   to.max   = today;

    from && from.addEventListener('change', () => { if (to) to.min = from.value || ''; });
    to   && to.addEventListener('change',   () => { if (from) from.max = to.value || today; });

    form.addEventListener('submit', function (e) {
      const f = (from?.value || '').trim();
      const t = (to?.value   || '').trim();
      if (!f || !t) { e.preventDefault(); alert('Please select both Start date and End date.'); return; }
      if (f > t)    { e.preventDefault(); alert('Start date cannot be after End date.'); }
    });

    // Function to save report
    window.saveReportNow = function() {
      const saveForm = document.getElementById('saveForm');
      const saveName = document.getElementById('saveName');
      const saveType = document.getElementById('saveType');
      const saveFrom = document.getElementById('saveFrom');
      const saveTo = document.getElementById('saveTo');
      const nameInput = document.getElementById('reportNameInput');
      const typeSel = document.getElementById('type');
      const fromInput = document.getElementById('from');
      const toInput = document.getElementById('to');
      
      // Get current values
      const n = (nameInput?.value || '').trim();
      const typeVal = typeSel?.value || '${reportType}' || '';
      const fromVal = fromInput?.value || '${param.from}' || '';
      const toVal = toInput?.value || '${param.to}' || '';
      
      console.log('🔍 Save Report - Current Values:', {
        name: n,
        type: typeVal,
        from: fromVal,
        to: toVal
      });
      
      // Validate that we have all required data
      if (!fromVal || !toVal) {
        alert('⚠️ Please generate a report first by selecting dates and clicking "Generate Report"');
        return false;
      }
      
      if (!typeVal) {
        alert('⚠️ Please select a report type');
        return false;
      }
      
      // Generate default name if empty
      const def = typeVal.toUpperCase() + '-REPORT-' + fromVal + '-to-' + toVal;
      const finalName = n || def;
      
      // Set all form values explicitly
      saveName.value = finalName;
      saveType.value = typeVal;
      saveFrom.value = fromVal;
      saveTo.value = toVal;
      
      console.log('✅ Save Report - Submitting with Values:', {
        name: saveName.value,
        type: saveType.value,
        from: saveFrom.value,
        to: saveTo.value,
        regenerate: '1'
      });
      
      // Submit the form
      saveForm.submit();
    };
  })();
</script>

<!-- Chart: render only when attributes exist -->
<c:if test="${not empty chartLabelsJson and not empty chartDataJson}">
  <script id="labelsJson" type="application/json"><c:out value="${chartLabelsJson}" escapeXml="false"/></script>
  <script id="dataJson" type="application/json"><c:out value="${chartDataJson}" escapeXml="false"/></script>
  <script>
    // Parse JSON data safely
    function parseArrayText(txt){
      try { return JSON.parse(txt); } catch(e) {
        try { return JSON.parse((txt||'').replace(/'/g,'"')); } catch(e2) { return []; }
      }
    }
    const labels = parseArrayText(document.getElementById('labelsJson')?.textContent || '[]');
    const data   = parseArrayText(document.getElementById('dataJson')?.textContent   || '[]');
    let type = '<c:out value="${typeValue}"/>';
    type = String(type || 'revenue').toLowerCase();

    if (window.__reportChart) { try { window.__reportChart.destroy(); } catch(e){} }
    const el = document.getElementById('reportChart');
    if (!el) { console.warn('reportChart canvas not found'); }
    const ctx = el.getContext('2d');

    const grad = ctx.createLinearGradient(0,0,0,220);
    grad.addColorStop(0, 'rgba(22,163,74,0.35)');
    grad.addColorStop(1, 'rgba(22,163,74,0.08)');

    const fmtCurrency = n => (Number(n)||0).toLocaleString('en-LK',{style:'currency',currency:'LKR',maximumFractionDigits:0});
    const common = { 
      responsive:true, 
      maintainAspectRatio:false, 
      resizeDelay:100, 
      animation:false,
      layout:{ padding:{left:0,right:0,top:0,bottom:0} }, 
      plugins:{ 
        legend:{ display: type==='fleet' }, 
        tooltip:{ 
          backgroundColor:'#1f2937', 
          titleColor:'#fff', 
          bodyColor:'#e5e7eb', 
          callbacks:{ 
            label:(c)=>{ 
              const v=c.parsed.y??c.parsed; 
              return (type==='revenue')?fmtCurrency(v):String(v); 
            } 
          } 
        } 
      } 
    };
    
    const axes = (type==='fleet')?{}:{ 
      x:{ grid:{display:false}, ticks:{color:'#64748b'} }, 
      y:{ 
        beginAtZero:true, 
        grid:{color:'rgba(0,0,0,.06)'}, 
        ticks:{ 
          color:'#64748b', 
          callback:(v)=> type==='revenue' ? ('Rs '+Number(v).toLocaleString('en-LK')) : v 
        } 
      } 
    };

    let config;
    if (type==='revenue') {
      config = { 
        type:'line', 
        data:{ 
          labels, 
          datasets:[{ 
            label:'Revenue', 
            data, 
            tension:0.35, 
            borderWidth:2, 
            borderColor:'#16a34a', 
            pointRadius:3, 
            pointBackgroundColor:'#16a34a', 
            fill:true, 
            backgroundColor:grad 
          }] 
        }, 
        options:{...common, scales:axes, responsive:true} 
      };
    } else if (type==='fleet') {
      config = { 
        type:'doughnut', 
        data:{ 
          labels, 
          datasets:[{ 
            data, 
            backgroundColor:['#16a34a','#0ea5e9','#f59e0b','#86efac','#93c5fd'], 
            borderColor:'#ffffff', 
            borderWidth:2 
          }] 
        }, 
        options:{
          ...common, 
          cutout:'62%', 
          plugins:{
            ...common.plugins, 
            legend:{
              display:true, 
              position:'bottom', 
              labels:{
                boxWidth:12, 
                usePointStyle:true, 
                color:'#334155'
              }
            }
          } 
        } 
      };
    } else {
      config = { 
        type:'bar', 
        data:{ 
          labels, 
          datasets:[{ 
            data, 
            backgroundColor:['#86efac','#93c5fd','#fde68a'], 
            borderColor:['#16a34a','#0ea5e9','#f59e0b'], 
            borderWidth:1.25, 
            borderRadius:8, 
            maxBarThickness:56, 
            categoryPercentage:0.55, 
            barPercentage:0.9 
          }] 
        }, 
        options:{
          ...common, 
          scales:{
            ...axes, 
            x:{...axes.x, ticks:{color:'#64748b'}, stacked:false} 
          } 
        } 
      };
    }

    window.__reportChart = new Chart(ctx, config);
  </script>
</c:if>

<%@ include file="admin-footer.jsp" %>
