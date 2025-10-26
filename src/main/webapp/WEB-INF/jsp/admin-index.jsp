<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="admin-header.jsp" %>

<div class="grid" style="gap:20px">
    <!-- Welcome Card -->
    <div class="card" style="grid-column: 1 / -1; text-align:center">
        <h2>🚗 Welcome to <span style="color:var(--brand)">DriveGo Admin Console</span></h2>
        <p style="color:var(--muted); margin-top:6px">
            Manage bookings, payments, vehicles, customers, and reports all in one place.
        </p>
    </div>

    <!-- Quick Start -->
    <div class="card">
        <h3><i class="fa-solid fa-bolt"></i> Quick Start</h3>
        <p>Open the admin dashboard to see KPIs and today’s activity.</p>
        <a href="<c:url value='/dashboard'/>" class="btn btn-primary">
            <i class="fa-solid fa-gauge-high"></i> Go to Dashboard
        </a>
    </div>

    <!-- Dev Tools -->
    <div class="card">
        <h3><i class="fa-solid fa-wrench"></i> Dev Tools</h3>
        <p>Ping the test servlet to confirm routing and deployment.</p>
        <a href="<c:url value='/test'/>" class="btn">
            <i class="fa-solid fa-check"></i> Ping TestServlet
        </a>
    </div>

    <!-- Project Info -->
    <div class="card">
        <h3><i class="fa-solid fa-circle-info"></i> Project</h3>
        <p>Use the menu to manage vehicles, bookings, users, and payments.</p>
        <ul style="color:var(--muted)">
            <li>CRUD pages for all modules</li>
            <li>Reports with export support (CSV / PDF)</li>
            <li>Role-based Admin access</li>
        </ul>
    </div>

    <!-- Quick Links -->
    <div class="card" style="grid-column: 1 / -1">
        <h3><i class="fa-solid fa-link"></i> Quick Links</h3>
        <div style="display:flex; flex-wrap:wrap; gap:10px; margin-top:8px">
            <a href="<c:url value='/vehicles/list.jsp'/>" class="btn"><i class="fa-solid fa-car"></i> Vehicles</a>
            <a href="<c:url value='/bookings/search.jsp'/>" class="btn"><i class="fa-solid fa-list-check"></i> Bookings</a>
            <a href="<c:url value='/users/register.jsp'/>" class="btn"><i class="fa-solid fa-users"></i> Customers</a>
            <a href="<c:url value='/payments/checkout.jsp'/>" class="btn"><i class="fa-solid fa-credit-card"></i> Payments</a>
            <a href="<c:url value='/reports'/>" class="btn"><i class="fa-solid fa-chart-column"></i> Reports</a>
            <a href="<c:url value='/history/booking_history.jsp'/>" class="btn"><i class="fa-solid fa-clock-rotate-left"></i> History</a>
        </div>
    </div>

    <!-- Next Steps -->
    <div class="card" style="grid-column: 1 / -1">
        <h3><i class="fa-solid fa-list-ul"></i> Next Steps</h3>
        <ul style="color:var(--muted)">
            <li>Replace dummy numbers on the Dashboard with real DB values</li>
            <li>Build CRUD pages for Vehicles, Users, Bookings, Payments</li>
            <li>Add exportable Reports (CSV/PDF) once queries are ready</li>
        </ul>
    </div>
</div>

<%@ include file="admin-footer.jsp" %>
