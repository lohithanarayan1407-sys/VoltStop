<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voltstop.dao.StationDAO" %>
<%@ page import="com.voltstop.dao.ChargerDAO" %>
<%@ page import="com.voltstop.model.Station" %>
<%@ page import="com.voltstop.model.Charger" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userId") == null || !"STATION_ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    int ownerId = (int) session.getAttribute("userId");
    int stationId = Integer.parseInt(request.getParameter("stationId"));

    StationDAO stationDAO = new StationDAO();
    Station station = stationDAO.findById(stationId);

    // Ownership check — block viewing/editing someone else's station
    if (station == null || station.getOwnerId() != ownerId) {
        response.sendRedirect("my-stations.jsp");
        return;
    }

    ChargerDAO chargerDAO = new ChargerDAO();
    List<Charger> chargers = chargerDAO.getChargersByStation(stationId);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — <%= station.getName() %> Chargers</title>
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
        <a href="logout" class="topbar__logout">Log out</a>
    </div>
</div>

<div class="dash-shell">
    <a href="my-stations.jsp" class="back-link">&larr; Back to my stations</a>

    <div class="dash-welcome">
        <h1><%= station.getName() %></h1>
        <p><%= station.getAddress() %><% if (station.getCity() != null) { %>, <%= station.getCity() %><% } %></p>
    </div>

    <% if (!chargers.isEmpty()) { %>
        <% for (Charger c : chargers) { %>
            <div class="list-item">
                <div class="list-item__info">
                    <h3><%= c.getChargerCode() %> — <%= c.getConnectorType() %></h3>
                    <p><%= c.getPowerKw() %> kW &middot; ₹<%= c.getPricePerKwh() %>/kWh</p>
                </div>
                <span class="status-badge active"><%= c.getStatus() %></span>
            </div>
        <% } %>
    <% } else { %>
        <div class="empty-state" style="margin-bottom: 32px;">
            <h3>No chargers yet</h3>
            <p>Add a charger below to start accepting bookings at this station.</p>
        </div>
    <% } %>

    <div class="auth-form-wrap" style="max-width: 100%; margin-top: 32px;">
        <h1 style="font-size: 20px;">Add a charger</h1>

        <form action="add-charger" method="post">
            <input type="hidden" name="stationId" value="<%= stationId %>">

            <div class="field">
                <label for="chargerCode">Charger code</label>
                <input type="text" id="chargerCode" name="chargerCode" placeholder="e.g. A1" required>
            </div>

            <div class="field">
                <label for="connectorType">Connector type</label>
                <select id="connectorType" name="connectorType">
                    <option value="TYPE1">Type 1</option>
                    <option value="TYPE2">Type 2</option>
                    <option value="CCS">CCS</option>
                    <option value="CHADEMO">CHAdeMO</option>
                    <option value="GBT">GB/T</option>
                </select>
            </div>

            <div class="field">
                <label for="powerKw">Power (kW)</label>
                <input type="number" step="0.01" id="powerKw" name="powerKw" placeholder="e.g. 50" required>
            </div>

            <div class="field">
                <label for="pricePerKwh">Price per kWh (₹)</label>
                <input type="number" step="0.01" id="pricePerKwh" name="pricePerKwh" placeholder="e.g. 12" required>
            </div>

            <button type="submit" class="btn-primary">Add charger</button>
        </form>
    </div>
</div>

</body>
</html>