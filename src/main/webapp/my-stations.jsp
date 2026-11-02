<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voltstop.dao.StationDAO" %>
<%@ page import="com.voltstop.model.Station" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userId") == null || !"STATION_ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    int ownerId = (int) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");

    StationDAO stationDAO = new StationDAO();
    List<Station> stations = stationDAO.getStationsByOwner(ownerId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — My Stations</title>
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

    <div class="dash-header-row">
        <div>
            <h1 style="font-family:'Space Grotesk',sans-serif; font-size:26px; margin:0 0 6px;">My stations</h1>
            <p style="color:var(--text-secondary); margin:0;">Manage the stations you operate.</p>
        </div>
        <a href="add-station.jsp" class="btn-primary btn-small">Add station</a>
    </div>

    <% if (stations.isEmpty()) { %>
        <div class="empty-state">
            <h3>No stations yet</h3>
            <p>Add your first station to start accepting bookings.</p>
            <a href="add-station.jsp" class="btn-primary" style="display:inline-block; width:auto; padding-left:24px; padding-right:24px;">Add a station</a>
        </div>
    <% } else {
        for (Station s : stations) {
            String badgeClass = "pending";
            String badgeLabel = "Pending approval";
            if ("ACTIVE".equals(s.getStatus())) { badgeClass = "active"; badgeLabel = "Active"; }
            else if ("INACTIVE".equals(s.getStatus())) { badgeClass = "inactive"; badgeLabel = "Inactive"; }
    %>
		<a href="chargers.jsp?stationId=<%= s.getStationId() %>" class="list-item" style="text-decoration:none; color:inherit;">
		    <div class="list-item__info">
		        <h3><%= s.getName() %></h3>
		        <p><%= s.getAddress() %><% if (s.getCity() != null && !s.getCity().isEmpty()) { %>, <%= s.getCity() %><% } %></p>
		    </div>
		    <span class="status-badge <%= badgeClass %>"><%= badgeLabel %></span>
		</a>
    <%  }
    } %>
</div>

</body>
</html>