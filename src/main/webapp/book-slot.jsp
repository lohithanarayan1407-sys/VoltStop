<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.voltstop.dao.*" %>
<%@ page import="com.voltstop.model.*" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
    int userId = (int) session.getAttribute("userId");
    int chargerId = Integer.parseInt(request.getParameter("chargerId"));

    ChargerDAO chargerDAO = new ChargerDAO();
    Charger charger = chargerDAO.findById(chargerId);
    Station station = new StationDAO().findById(charger.getStationId());

    VehicleDAO vehicleDAO = new VehicleDAO();
    List<Vehicle> vehicles = vehicleDAO.getVehiclesByUser(userId);
    if (vehicles.isEmpty()) {
        response.sendRedirect("add-vehicle.jsp?redirect=" + java.net.URLEncoder.encode("book-slot.jsp?chargerId=" + chargerId, "UTF-8"));
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Book a slot</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="topbar">
    <div class="topbar__brand">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"><path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" fill="#FFB627"/></svg>
        VoltStop
    </div>
    <div class="topbar__right"><a href="logout" class="topbar__logout">Log out</a></div>
</div>
<div class="dash-shell" style="max-width:560px;">
    <a href="station-search.jsp" class="back-link">&larr; Back to search</a>
    <div class="auth-form-wrap" style="max-width:100%;">
        <h1>Book <%= charger.getChargerCode() %> at <%= station.getName() %></h1>
        <p class="lede"><%= charger.getPowerKw() %> kW &middot; ₹<%= charger.getPricePerKwh() %>/kWh</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="msg error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="book-slot" method="post">
            <input type="hidden" name="chargerId" value="<%= chargerId %>">

            <div class="field">
                <label for="vehicleId">Vehicle</label>
                <select id="vehicleId" name="vehicleId">
                    <% for (Vehicle v : vehicles) { %>
                        <option value="<%= v.getVehicleId() %>"><%= v.getVehicleName() %> (<%= v.getBatteryCapacityKwh() %> kWh)</option>
                    <% } %>
                </select>
            </div>

            <div class="field">
                <label for="slotDate">Date</label>
                <input type="date" id="slotDate" name="slotDate" required>
            </div>

            <div class="field">
                <label for="startTime">Start time</label>
                <input type="time" id="startTime" name="startTime" required>
            </div>

            <div class="field">
                <label for="batteryStartPct">Current battery (%)</label>
                <input type="number" min="0" max="100" id="batteryStartPct" name="batteryStartPct" placeholder="e.g. 20" required>
            </div>

            <div class="field">
                <label for="batteryTargetPct">Charge up to (%)</label>
                <input type="number" min="1" max="100" id="batteryTargetPct" name="batteryTargetPct" value="100" required>
            </div>

            <button type="submit" class="btn-primary">Book this slot</button>
        </form>
    </div>
</div>
</body>
</html>