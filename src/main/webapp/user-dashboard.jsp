<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Dashboard</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>

<div class="topbar">
    <div class="topbar__brand">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
            <path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" fill="#FFB627"/>
        </svg>
        VoltStop
    </div>
    <div class="topbar__right">
        <span class="topbar__user">Hi, <%= userName %></span>
        <a href="logout" class="topbar__logout">Log out</a>
    </div>
</div>

<div class="dash-shell">
    <div class="dash-welcome">
        <h1>Welcome back, <%= userName %></h1>
        <p>Find a station, book a slot, and track your charge from one place.</p>
    </div>

    <div class="dash-grid">
        <div class="dash-card">
            <h3>Find a station</h3>
            <p>See nearby chargers with live availability.</p>
            <a href="station-search.jsp" class="btn-primary">Search stations</a>
        </div>
        <div class="dash-card">
            <h3>My vehicles</h3>
            <p>Manage your saved vehicles and battery details.</p>
            <a href="add-vehicle.jsp" class="btn-primary">Manage vehicles</a>
        </div>
        <div class="dash-card">
            <h3>My bookings</h3>
			<p>View your charging sessions, estimates and payments.</p>
			<a href="my-bookings.jsp" class="btn-primary">View bookings</a>
        </div>
    </div>

    <div class="empty-state">
        <h3>No bookings yet</h3>
        <p>Once you book a charging slot, it'll show up here with your estimated ready time.</p>
        <a href="station-search.jsp" class="btn-primary" style="display:inline-block; width:auto; padding-left:24px; padding-right:24px;">Find a station to get started</a>
    </div>
</div>

</body>
</html>