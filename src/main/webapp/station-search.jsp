<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voltstop.dao.StationDAO" %>
<%@ page import="com.voltstop.dao.ChargerDAO" %>
<%@ page import="com.voltstop.model.Station" %>
<%@ page import="com.voltstop.model.Charger" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");

    StationDAO stationDAO = new StationDAO();
    ChargerDAO chargerDAO = new ChargerDAO();
    List<Station> stations = stationDAO.getActiveStations();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Find a station</title>
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
    <a href="user-dashboard.jsp" class="back-link">&larr; Back to dashboard</a>

    <div class="dash-welcome">
        <h1>Find a station</h1>
        <p>Active charging stations, with live pricing and power ratings.</p>
    </div>

    <% if (stations.isEmpty()) { %>
        <div class="empty-state">
            <h3>No stations available yet</h3>
            <p>Check back soon — new stations are added regularly.</p>
        </div>
    <% } else {
        for (Station s : stations) {
            List<Charger> chargers = chargerDAO.getChargersByStation(s.getStationId());
    %>
        <div style="background:var(--surface); border:1px solid var(--border); border-radius:8px; padding:24px; margin-bottom:16px;">
            <h3 style="font-family:'Space Grotesk',sans-serif; font-size:18px; margin:0 0 4px;"><%= s.getName() %></h3>
            <p style="color:var(--text-secondary); font-size:13px; margin:0 0 16px;">
                <%= s.getAddress() %><% if (s.getCity() != null && !s.getCity().isEmpty()) { %>, <%= s.getCity() %><% } %>
            </p>

            <% if (chargers.isEmpty()) { %>
                <p style="color:var(--text-secondary); font-size:13px;">No chargers set up at this station yet.</p>
            <% } else {
                for (Charger c : chargers) {
                    if (!"AVAILABLE".equals(c.getStatus())) continue;
            %>
                <div style="display:flex; justify-content:space-between; align-items:center; padding:12px 0; border-top:1px solid var(--border);">
                    <div>
                        <strong style="font-size:14px;"><%= c.getChargerCode() %> — <%= c.getConnectorType() %></strong>
                        <p style="color:var(--text-secondary); font-size:13px; margin:2px 0 0;">
                            <%= c.getPowerKw() %> kW &middot; ₹<%= c.getPricePerKwh() %>/kWh
                        </p>
                    </div>
                    <a href="book-slot.jsp?chargerId=<%= c.getChargerId() %>" class="btn-primary btn-small">Book this charger</a>
                </div>
            <%  }
            } %>
        </div>
    <%  }
    } %>
</div>

</body>
</html>