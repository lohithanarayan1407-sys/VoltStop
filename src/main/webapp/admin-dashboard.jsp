<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"SYSTEM_ADMIN".equals(session.getAttribute("userRole"))) {
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
    <title>VoltStop — Admin Dashboard</title>
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
        <span class="topbar__user">Hi, <%= userName %> (System Admin)</span>
        <a href="logout" class="topbar__logout">Log out</a>
    </div>
</div>

<div class="dash-shell">
    <div class="dash-welcome">
        <h1>Platform overview</h1>
        <p>Manage users, review stations, and monitor activity across VoltStop.</p>
    </div>

    <div class="dash-grid">
        <div class="dash-card">
            <h3>Users</h3>
            <p>View, suspend, or manage all registered accounts.</p>
            <a href="#" class="btn-primary">Manage users</a>
        </div>
        <div class="dash-card">
            <h3>Station approvals</h3>
            <p>Review and approve stations submitted by operators.</p>
            <a href="#" class="btn-primary">Review stations</a>
        </div>
        <div class="dash-card">
            <h3>Platform analytics</h3>
            <p>Total bookings, revenue, and active stations at a glance.</p>
            <a href="#" class="btn-primary">View analytics</a>
        </div>
    </div>

    <div class="empty-state">
        <h3>No pending approvals</h3>
        <p>New stations submitted by operators will appear here for review.</p>
    </div>
</div>

</body>
</html>