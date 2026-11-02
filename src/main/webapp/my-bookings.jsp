<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voltstop.dao.BookingDAO" %>
<%@ page import="com.voltstop.model.Booking" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
    int userId = (int) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    List<Booking> bookings = new BookingDAO().getBookingsByUser(userId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — My Bookings</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="topbar">
    <div class="topbar__brand">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"><path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" fill="#FFB627"/></svg>
        VoltStop
    </div>
    <div class="topbar__right">
        <span class="topbar__user">Hi, <%= userName %></span>
        <a href="logout" class="topbar__logout">Log out</a>
    </div>
</div>
<div class="dash-shell">
    <a href="user-dashboard.jsp" class="back-link">&larr; Back to dashboard</a>
    <div class="dash-welcome">
        <h1>My bookings</h1>
        <p>Your charging sessions, past and upcoming.</p>
    </div>

    <% if (bookings.isEmpty()) { %>
        <div class="empty-state">
            <h3>No bookings yet</h3>
            <p>Find a station and book your first charging slot.</p>
            <a href="station-search.jsp" class="btn-primary" style="display:inline-block; width:auto; padding-left:24px; padding-right:24px;">Find a station</a>
        </div>
    <% } else {
        for (Booking b : bookings) {
    %>
        <div style="background:var(--surface); border:1px solid var(--border); border-radius:8px; padding:20px 24px; margin-bottom:12px;">
            <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                <div>
                    <h3 style="font-family:'Space Grotesk',sans-serif; font-size:16px; margin:0 0 4px;">
                        <%= b.getStationName() %> — <%= b.getChargerCode() %>
                    </h3>
                    <p style="color:var(--text-secondary); font-size:13px; margin:0 0 8px;">
                        <%= b.getSlotDate() %> at <%= b.getStartTime() %>
                    </p>
                    <p style="color:var(--text-secondary); font-size:13px; margin:0;">
                        <%= (int) b.getBatteryStartPct() %>% &rarr; <%= (int) b.getBatteryTargetPct() %>%
                        &middot; ~<%= b.getEstimatedTimeMins() %> min
                        &middot; ₹<%= String.format("%.2f", b.getEstimatedCost()) %>
                    </p>
                </div>
                <div style="text-align:right;">
                    <span class="status-badge <%= "COMPLETED".equals(b.getStatus()) ? "active" : "pending" %>"><%= b.getStatus() %></span>
                    <br><br>
                    <% if (!"SUCCESS".equals(b.getPaymentStatus())) { %>
                        <form action="pay" method="post">
                            <input type="hidden" name="bookingId" value="<%= b.getBookingId() %>">
                            <button type="submit" class="btn-primary btn-small">Pay now</button>
                        </form>
                    <% } else { %>
                        <span class="status-badge active">Paid</span>
                    <% } %>
                </div>
            </div>
        </div>
    <%  }
    } %>
</div>
</body>
</html>