<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voltstop.dao.PaymentDAO" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userId") == null || !"STATION_ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    int ownerId = (int) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");

    List<String[]> rows = new PaymentDAO().getEarningsByOwner(ownerId);
    double total = 0;
    for (String[] r : rows) total += Double.parseDouble(r[3]);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Earnings</title>
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
    <a href="station-dashboard.jsp" class="back-link">&larr; Back to dashboard</a>

    <div class="dash-welcome">
        <h1>Earnings</h1>
        <p>Paid charging sessions at your stations.</p>
    </div>

    <div class="dash-card" style="margin-bottom: 28px; max-width: 320px;">
        <h3>Total earned</h3>
        <p style="font-size: 28px; font-weight: 600; margin: 0; color: var(--text);">₹<%= String.format("%.2f", total) %></p>
    </div>

    <% if (rows.isEmpty()) { %>
        <div class="empty-state">
            <h3>No earnings yet</h3>
            <p>Payments appear here once a driver books and pays for a charger at one of your stations.</p>
        </div>
    <% } else {
        for (String[] r : rows) { %>
        <div class="list-item">
            <div class="list-item__info">
                <h3><%= r[0] %> — <%= r[1] %></h3>
                <p>Session on <%= r[2] %> &middot; paid <%= r[4] %></p>
            </div>
            <span class="status-badge active">₹<%= r[3] %></span>
        </div>
    <%  }
    } %>
</div>

</body>
</html>