<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"STATION_ADMIN".equals(session.getAttribute("userRole"))) {
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
    <title>VoltStop — Station Dashboard</title>
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
        <span class="topbar__user">Hi, <%= userName %> (Station Admin)</span>
        <a href="logout" class="topbar__logout">Log out</a>
    </div>
</div>

<div class="dash-shell">
    <div class="dash-welcome">
        <h1>Manage your stations</h1>
        <p>Add chargers, review bookings, and track earnings for your stations.</p>
    </div>

    <div class="dash-grid">
        <div class="dash-card">
            <h3>My stations</h3>
            <p>Add a new station or edit an existing one's details.</p>
            <a href="my-stations.jsp" class="btn-primary">Manage stations</a>
        </div>
        <div class="dash-card">
            <h3>Chargers &amp; slots</h3>
            <p>Set up chargers and their availability windows.</p>
            <a href="add-station.jsp" class="btn-primary">Manage chargers</a>
        </div>
        <div class="dash-card">
            <h3>Earnings</h3>
            <p>View completed sessions and revenue by station.</p>
            <a href="earnings.jsp" class="btn-primary">View earnings</a>
        </div>
    </div>

    <div class="empty-state">
        <h3>No bookings yet</h3>
        <p>Once EV drivers start booking your chargers, their sessions will show up here.</p>
        <a href="add-station.jsp" class="btn-primary" style="display:inline-block; width:auto; padding-left:24px; padding-right:24px;">Add your first station</a>
    </div>
</div>

</body>
</html>