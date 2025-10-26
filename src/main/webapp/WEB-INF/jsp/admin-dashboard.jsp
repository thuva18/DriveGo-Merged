<%@include file="admin-header.jsp" %>

<style>
  /* ==== Chart stability fixes ==== */
  .chart-block{
    position: relative;
    height: 180px;      /* fixed box so Chart.js won’t “creep” */
    max-height: 180px;
    width: 100%;
  }
  .chart-block canvas{
    display: block;     /* remove inline baseline gap */
    width: 100% !important;
    height: 100% !important;
  }
  /* avoid accidental height animations that can retrigger resizes */
  .card, .chart-block { transition-property: none; }
</style>

<main class="main-content">
    <div class="page-header">
        <div class="page-header-content">
            <h1 class="page-title">
                <i class="fas fa-tachometer-alt"></i>
                Admin Dashboard
            </h1>
            <div class="page-subtitle">Welcome back, Administrator! Here's what's happening with your car rental business today.</div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="dashboard-actions">
        <a href="/vehicles/new" class="action-card">
            <i class="fas fa-plus"></i>
            <span>Add Vehicle</span>
        </a>
        <a href="/bookings/form" class="action-card">
            <i class="fas fa-calendar-plus"></i>
            <span>New Booking</span>
        </a>
        <a href="/payments" class="action-card">
            <i class="fas fa-credit-card"></i>
            <span>View Payments</span>
        </a>
        <a href="/reports" class="action-card">
            <i class="fas fa-chart-bar"></i>
            <span>Reports</span>
        </a>
    </div>

<!-- KPI Cards -->
<div class="grid kpi">
    <div class="card">
        <div class="card-header">
            <div class="card-title">
                <div class="card-icon green">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                Today's Revenue
            </div>
        </div>
        <div class="metric">
            <c:out value="${kpi.revenueToday}" default="LKR 0"/>
        </div>
        <div class="metric-change positive">
            <i class="fas fa-arrow-up"></i>
            <c:out value="${kpi.revenueDelta}" default="0% vs yesterday"/>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <div class="card-title">
                <div class="card-icon blue">
                    <i class="fas fa-calendar-check"></i>
                </div>
                Active Bookings
            </div>
        </div>
        <div class="metric"><c:out value="${kpi.activeBookings}" default="0"/></div>
        <div class="pill success">
            <i class="fas fa-plus"></i>
            <c:out value="${kpi.newBookingsNote}" default="+0 new"/>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <div class="card-title">
                <div class="card-icon orange">
                    <i class="fas fa-car"></i>
                </div>
                Fleet Available
            </div>
        </div>
        <div class="metric"><c:out value="${kpi.fleetAvailablePct}" default="0%"/></div>
        <div class="pill info">
            <c:out value="${kpi.fleetAvailableCount}" default="0 / 0 vehicles"/>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <div class="card-title">
                <div class="card-icon red">
                    <i class="fas fa-users"></i>
                </div>
                New Customers
            </div>
        </div>
        <div class="metric"><c:out value="${kpi.newCustomers}" default="0"/></div>
        <div class="pill secondary">
            <i class="fas fa-clock"></i>
            <c:out value="${kpi.newCustomersNote}" default="Total users"/>
        </div>
    </div>
</div>

<!-- Trends + Today’s bookings + Recent activity -->
<section class="grid" style="grid-template-columns:2fr 1fr; gap:16px; margin-top:16px">
  <!-- Trends -->
  <div class="card">
    <h3><i class="fa-solid fa-chart-line"></i> Trends (7 days)</h3>
    <div style="display:grid; gap:14px; grid-template-columns:1fr 1fr">
      <div>
        <div style="font-size:12px; color:#64748b; margin-bottom:4px">Bookings</div>
        <div class="chart-block"><canvas id="bookingsChart"></canvas></div>
      </div>
      <div>
        <div style="font-size:12px; color:#64748b; margin-bottom:4px">Revenue</div>
        <div class="chart-block"><canvas id="revenueChart"></canvas></div>
      </div>
    </div>
  </div>

  <!-- Recent Activity -->
  <div class="card">
    <h3><i class="fa-solid fa-bolt"></i> Recent Activity</h3>
    <ul style="list-style:none; padding:0; margin:0; display:grid; gap:10px">
      <c:forEach var="ev" items="${recent}">
        <li style="display:flex; gap:10px; align-items:start">
          <span class="pill" style="min-width:72px; justify-content:center">
            <c:out value="${ev.type}"/>
          </span>
          <div>
            <div style="font-weight:600">
              <c:out value="${ev.title}"/>
            </div>
            <div class="muted" style="font-size:12px">
              <c:out value="${ev.when}"/>
            </div>
          </div>
        </li>
      </c:forEach>

      <c:if test="${empty recent}">
        <li style="text-align:center; padding:2rem; color:#64748b">
          <i class="fas fa-inbox" style="font-size:2rem; margin-bottom:0.5rem; display:block"></i>
          No recent activity yet.
        </li>
      </c:if>
    </ul>
  </div>
</section>

<!-- Today's Bookings Table -->
<section class="grid" style="grid-template-columns:1fr; gap:16px; margin-top:16px">
  <div class="card">
    <h3><i class="fa-solid fa-calendar-day"></i> Bookings Created Today</h3>
    <div class="table-wrap">
      <table class="table">
        <thead>
        <tr>
          <th>Booking ID</th><th>Customer</th><th>Vehicle</th><th>Pickup → Return</th><th>Status</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="b" items="${todayBookings}">
          <tr class="row-hover">
            <td><c:out value="${b.code}"/></td>
            <td><c:out value="${b.customer}"/></td>
            <td><c:out value="${b.vehicle}"/></td>
            <td><c:out value="${b.timeRange}"/></td>
            <td>
              <c:choose>
                <c:when test="${b.status=='CONFIRMED'}"><span class="badge ok">CONFIRMED</span></c:when>
                <c:when test="${b.status=='PENDING'}"><span class="badge warn">PENDING</span></c:when>
                <c:when test="${b.status=='CANCELLED'}"><span class="badge muted">CANCELLED</span></c:when>
                <c:otherwise><span class="badge info"><c:out value="${b.status}"/></span></c:otherwise>
              </c:choose>
            </td>
          </tr>
        </c:forEach>

        <c:if test="${empty todayBookings}">
          <tr>
            <td colspan="5" style="text-align:center; padding:2rem; color:#64748b">
              <i class="fas fa-calendar-times" style="font-size:2rem; margin-bottom:0.5rem; display:block"></i>
              No bookings created today yet.
            </td>
          </tr>
        </c:if>
        </tbody>
      </table>
    </div>
  </div>
</section>

<script>
  // ------- If Chart.js isn't on the page (e.g., not included in header.jsp), load it, then init.
  (function ensureChartJs(callback){
    if (window.Chart) { callback(); return; }
    var s = document.createElement('script');
    s.src = 'https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js';
    s.onload = callback;
    document.head.appendChild(s);
  })(function initCharts(){
    // ====== Server-provided JSON arrays (real data only) ======
    const bookingsLabels = ${chartBookingsLabelsJson};
    const bookingsData   = ${chartBookingsDataJson};

    const revenueLabels  = ${chartRevenueLabelsJson};
    const revenueData    = ${chartRevenueDataJson};

    // Destroy old instances if the page hot-reloads
    if (window.__bookingsChart) { try { window.__bookingsChart.destroy(); } catch(e){} }
    if (window.__revenueChart)  { try { window.__revenueChart.destroy();  } catch(e){} }

    // Delay one frame so layout (chart-block heights) is settled before measuring
    requestAnimationFrame(function(){
      // Bookings (smooth line)
      (function(){
        const el = document.getElementById('bookingsChart'); if (!el) return;
        const ctx = el.getContext('2d');
        const g = ctx.createLinearGradient(0,0,0,200);
        g.addColorStop(0,'rgba(22,163,74,0.28)'); g.addColorStop(1,'rgba(22,163,74,0.06)');

        window.__bookingsChart = new Chart(ctx, {
          type: 'line',
          data: {
            labels: bookingsLabels,
            datasets: [{
              label: 'Bookings',
              data: bookingsData,
              borderColor: '#16a34a',
              backgroundColor: g,
              fill: true,
              tension: 0.35,
              borderWidth: 2,
              pointRadius: 2
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            resizeDelay: 200,         // <— prevents resize thrashing
            animation: false,
            plugins: { legend: { display: false } },
            scales: {
              x: { grid: { display:false }, ticks:{ color:'#64748b' } },
              y: { beginAtZero:true, grid:{ color:'rgba(2,6,12,.06)' }, ticks:{ color:'#64748b' } }
            }
          }
        });
      })();

      // Revenue (compact bars)
      (function(){
        const el = document.getElementById('revenueChart'); if (!el) return;
        const ctx = el.getContext('2d');
        const g = ctx.createLinearGradient(0,0,0,200);
        g.addColorStop(0,'rgba(22,163,74,0.35)'); g.addColorStop(1,'rgba(22,163,74,0.08)');

        window.__revenueChart = new Chart(ctx, {
          type: 'bar',
          data: {
            labels: revenueLabels,
            datasets: [{
              label: 'Revenue',
              data: revenueData,
              backgroundColor: g,
              borderColor: '#16a34a',
              borderWidth: 1.25,
              borderRadius: 8,
              maxBarThickness: 38,
              categoryPercentage: 0.6,
              barPercentage: 0.9
            }]
          },
          options: {
            responsive: true,
            maintainAspectRatio: false,
            resizeDelay: 200,         // <— prevents resize thrashing
            animation: false,
            plugins: {
              legend: { display: false },
              tooltip: {
                backgroundColor:'#0f172a', titleColor:'#fff', bodyColor:'#e2e8f0',
                callbacks: {
                  label: (c)=> (Number(c.parsed.y)||0).toLocaleString('en-LK',{style:'currency',currency:'LKR',maximumFractionDigits:0})
                }
              }
            },
            scales: {
              x: { grid: { display:false }, ticks:{ color:'#64748b' } },
              y: {
                beginAtZero:true,
                grid:{ color:'rgba(2,6,12,.06)' },
                ticks:{ color:'#64748b', callback:(v)=> 'Rs ' + Number(v).toLocaleString('en-LK') }
              }
            }
          }
        });
      })();
    });
  });
</script>
</main>

<%@ include file="admin-footer.jsp" %>
