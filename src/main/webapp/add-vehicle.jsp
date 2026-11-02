<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
    String redirectTo = request.getParameter("redirect");
    if (redirectTo == null) redirectTo = "user-dashboard.jsp";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Add Vehicle</title>
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
    <a href="user-dashboard.jsp" class="back-link">&larr; Back to dashboard</a>
    <div class="auth-form-wrap" style="max-width:100%;">
        <h1>Add your vehicle</h1>
        <p class="lede">We use your battery capacity to estimate charging time.</p>
        <form action="add-vehicle" method="post">
            <input type="hidden" name="redirect" value="<%= redirectTo %>">
            <div class="field">
                <label for="vehicleName">Vehicle name</label>
                <input type="text" id="vehicleName" name="vehicleName" placeholder="e.g. Tata Nexon EV" required>
            </div>
            <div class="field">
                <label for="batteryCapacityKwh">Battery capacity (kWh)</label>
                <input type="number" step="0.01" id="batteryCapacityKwh" name="batteryCapacityKwh" placeholder="e.g. 40.5" required>
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
            <button type="submit" class="btn-primary">Save vehicle</button>
        </form>
    </div>
</div>
</body>
</html>