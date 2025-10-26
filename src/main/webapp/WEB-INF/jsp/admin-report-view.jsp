<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="admin-header.jsp" %>

<h2 class="page-title">Report REP-<fmt:formatNumber value="${report.id}" minIntegerDigits="4" groupingUsed="false"/></h2>

<div class="flex" style="gap:8px; margin-bottom:12px; flex-wrap:wrap">
  <a class="btn btn-sm" href="<c:url value='/reports/manage'/>"><i class="fa fa-arrow-left"></i> Back</a>
  <a class="btn btn-sm" href="<c:url value='/reports/${report.id}/edit'/>"><i class="fa fa-pen"></i> Edit</a>
  <form method="post" action="<c:url value='/reports/${report.id}/delete'/>" onsubmit="return confirm('Delete this report?');" style="display:inline-block">
    <button class="btn btn-sm btn-danger" type="submit"><i class="fa fa-trash"></i> Delete</button>
  </form>
  <a class="btn btn-sm" onclick="window.print()"><i class="fa fa-file-arrow-down"></i> Print / PDF</a>
  
</div>

<div class="card">
  <div class="grid" style="grid-template-columns: 1fr 1fr; gap:16px">
    <div>
      <h4>Info</h4>
      <ul class="meta">
        <li><strong>Name:</strong> ${report.name}</li>
        <li><strong>Type:</strong> ${report.type}</li>
        <li><strong>Range:</strong> ${report.fromDate} → ${report.toDate}</li>
        <li><strong>Created:</strong> ${report.createdAt}</li>
        <li><strong>Updated:</strong> ${report.updatedAt}</li>
      </ul>
    </div>
    <div>
      <h4>Chart</h4>
      <div class="chart-box">
        <canvas id="savedReportChart"></canvas>
        <div id="chartLoading" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center; color: #6b7280;">
          <div style="font-size: 18px; margin-bottom: 8px;">📊</div>
          <div>Loading Chart...</div>
        </div>
      </div>
      <div id="chartStatus" style="color: #6b7280; font-size: 14px; margin-top: 8px; font-style: italic;">Initializing chart library...</div>
    </div>
  </div>
</div>

<div class="card">
  <h4>Details</h4>
  <div class="table-wrap">
    <table class="table">
      <thead><tr><th>Label</th><th class="ta-right">Value</th></tr></thead>
      <tbody id="savedReportRows"><tr><td colspan="2" class="muted">Loading…</td></tr></tbody>
      <tfoot id="savedReportFoot"></tfoot>
    </table>
  </div>
</div>

<script id="payload" type="application/json"><c:out value="${report.payload}" escapeXml="false"/></script>

<script>
  function copyPayload(){}
  
  // Wait for Chart.js to load and DOM to be ready
  function initializeChart() {
    const statusEl = document.getElementById('chartStatus');
    
    // Check if Chart.js is loaded
    if (typeof Chart === 'undefined' || !Chart.register) {
      console.log('Chart.js not ready, waiting...');
      if (statusEl) statusEl.textContent = 'Loading Chart.js library...';
      // Try again in 500ms
      setTimeout(initializeChart, 500);
      return;
    }
    
    console.log('Chart.js is available:', Chart.version || 'version unknown');
      
      console.warn('Chart.js not ready yet, retrying...');
      if (statusEl) statusEl.textContent = 'Loading Chart.js library...';
      setTimeout(initializeChart, 500);
      return;
    }
    
    console.log('Chart.js is ready, version:', Chart.version);
    
    try {
      const raw = document.getElementById('payload')?.textContent || '{}';
      console.log('Raw payload:', raw);
      
      const data = JSON.parse(raw);
      console.log('Parsed data:', data);
      
      const parseArr = (t)=>{ 
        try { 
          return JSON.parse(t); 
        } catch(e){ 
          try { 
            return JSON.parse((t||'').replace(/'/g,'\"')); 
          } catch(e2){ 
            console.warn('Failed to parse array:', t); 
            return []; 
          } 
        } 
      };
      
      const labels = data.reportLabelsJson ? parseArr(data.reportLabelsJson) : [];
      const series = data.reportDataJson ? parseArr(data.reportDataJson) : [];
      const type = ('${report.type}').toLowerCase();
      
      console.log('Chart data - Labels:', labels, 'Series:', series, 'Type:', type);

      // details
      let rows = Array.isArray(data.reportRows) ? data.reportRows : [];
      if (!rows.length && typeof data.reportRows === 'string') {
        try { const parsed = JSON.parse(data.reportRows); if (Array.isArray(parsed)) rows = parsed; } catch(_){ /* ignore */ }
      }
      const tbody = document.getElementById('savedReportRows');
      if (tbody) {
        if (rows.length) {
          tbody.innerHTML = rows.map(function(r){
            var label = (r && r.label) ? r.label : '';
            var value = (r && r.value) ? r.value : '';
            return '<tr class="row-hover"><td>' + label + '</td><td class="ta-right">' + value + '</td></tr>';
          }).join('');
        } else {
          tbody.innerHTML = '<tr><td colspan="2" class="muted">No details to display.</td></tr>';
        }
      }
      const tfoot = document.getElementById('savedReportFoot');
      if (tfoot) {
        if (data.tableTotalLabel && data.tableTotalValue) {
          tfoot.innerHTML = '<tr><th>' + data.tableTotalLabel + '</th><th class="ta-right">' + data.tableTotalValue + '</th></tr>';
        } else {
          tfoot.innerHTML = '';
        }
      }

      // chart
      const el = document.getElementById('savedReportChart');
      if (!el) {
        console.error('Chart canvas element not found');
        if (statusEl) statusEl.textContent = 'Error: Chart canvas not found';
        return;
      }
      
      if (!labels.length || !series.length) {
        console.warn('No chart data available - Labels:', labels, 'Series:', series);
        console.warn('No chart data available - Labels:', labels, 'Series:', series);
        if (statusEl) statusEl.textContent = 'No data available - creating test chart';
        
        // Create a test chart to verify Chart.js is working
        try {
          const ctx = el.getContext('2d');
          const testChart = new Chart(ctx, {
            type: 'bar',
            data: {
              labels: ['Test 1', 'Test 2', 'Test 3'],
              datasets: [{
                label: 'Test Data',
                data: [10, 20, 30],
                backgroundColor: ['#16a34a', '#0ea5e9', '#94a3b8'],
                borderColor: ['#15803d', '#075985', '#64748b'],
                borderWidth: 1
              }]
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              plugins: {
                title: {
                  display: true,
                  text: 'Test Chart - No Report Data Available'
                }
              }
            }
          });
          if (statusEl) statusEl.textContent = 'Test chart created - Chart.js is working';
          console.log('Test chart created successfully');
        } catch(testError) {
          console.error('Failed to create test chart:', testError);
          if (statusEl) statusEl.textContent = 'Chart.js error: ' + testError.message;
        }
        return;
      }
      
      try {
        const ctx = el.getContext('2d');
        const grad = ctx.createLinearGradient(0,0,0,220);
        grad.addColorStop(0, 'rgba(22,163,74,0.35)');
        grad.addColorStop(1, 'rgba(22,163,74,0.08)');
        
        const common = { 
          responsive: true, 
          maintainAspectRatio: false, 
          resizeDelay: 100, 
          animation: { duration: 1000 }, 
          plugins: { 
            legend: { display: type === 'fleet' } 
          } 
        };
        
        let config;
        if (type === 'revenue') {
          config = { 
            type: 'line', 
            data: { 
              labels, 
              datasets: [{ 
                label: 'Revenue', 
                data: series, 
                tension: 0.35, 
                borderWidth: 2, 
                borderColor: '#16a34a', 
                pointRadius: 4, 
                pointBackgroundColor: '#16a34a', 
                fill: true, 
                backgroundColor: grad 
              }] 
            }, 
            options: {...common} 
          };
        } else if (type === 'fleet') {
          config = { 
            type: 'doughnut', 
            data: { 
              labels, 
              datasets: [{ 
                data: series, 
                backgroundColor: ['#16a34a','#0ea5e9','#94a3b8','#86efac','#93c5fd'], 
                borderColor: '#ffffff', 
                borderWidth: 2 
              }] 
            }, 
            options: {...common, cutout: '62%'} 
          };
        } else {
          config = { 
            type: 'bar', 
            data: { 
              labels, 
              datasets: [{ 
                data: series, 
                backgroundColor: ['#86efac','#93c5fd','#e2e8f0'], 
                borderColor: ['#16a34a','#0ea5e9','#94a3b8'], 
                borderWidth: 1.25, 
                borderRadius: 8 
              }] 
            }, 
            options: {...common} 
          };
        }
        
        console.log('Creating chart with config:', config);
        const chart = new Chart(ctx, config);
        console.log('Chart created successfully:', chart);
        
        // Hide loading indicator and show success message
        const loadingEl = document.getElementById('chartLoading');
        if (loadingEl) loadingEl.style.display = 'none';
        
        if (statusEl) {
          statusEl.textContent = 'Chart loaded successfully ✓';
          statusEl.style.color = '#16a34a';
        }
        
      } catch(chartError) {
        console.error('Failed to create chart:', chartError);
        const loadingEl = document.getElementById('chartLoading');
        if (loadingEl) {
          loadingEl.innerHTML = '<div style="color: #dc2626;">❌</div><div>Chart Error</div>';
        }
        if (statusEl) {
          statusEl.textContent = 'Error creating chart: ' + chartError.message;
          statusEl.style.color = '#dc2626';
        }
      }
      
    } catch(e) {
      console.error('Failed to render saved payload', e);
      const loadingEl = document.getElementById('chartLoading');
      if (loadingEl) {
        loadingEl.innerHTML = '<div style="color: #dc2626;">❌</div><div>Data Error</div>';
      }
      if (statusEl) {
        statusEl.textContent = 'Error loading chart data: ' + e.message;
        statusEl.style.color = '#dc2626';
      }
      const tbody = document.getElementById('savedReportRows');
      if (tbody) {
        tbody.innerHTML = '<tr><td colspan="2" class="muted">Error loading report data.</td></tr>';
      }
    }
  }
  
  // Initialize when both DOM and Chart.js are ready
  function startInitialization() {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', initializeChart);
    } else {
      initializeChart();
    }
  }
  
  // Wait for Chart.js to be ready with multiple checks
  if (typeof Chart !== 'undefined' && Chart.register) {
    console.log('Chart.js already loaded');
    startInitialization();
  } else {
    console.log('Waiting for Chart.js to load...');
    // Listen for our custom event
    window.addEventListener('chartjs-loaded', function() {
      console.log('Chart.js loaded via custom event');
      startInitialization();
    });
    
    // Periodic check as fallback
    var checkInterval = setInterval(function() {
      if (typeof Chart !== 'undefined' && Chart.register) {
        console.log('Chart.js detected via interval check');
        clearInterval(checkInterval);
        startInitialization();
      }
    }, 200);
    
    // Final fallback timeout
    setTimeout(function() {
      clearInterval(checkInterval);
      if (typeof Chart === 'undefined') {
        console.error('Chart.js failed to load after 5 seconds');
        const statusEl = document.getElementById('chartStatus');
        if (statusEl) statusEl.textContent = 'Failed to load Chart.js library';
      }
    }, 5000);
  }
  </script>

<%@ include file="admin-footer.jsp" %>
