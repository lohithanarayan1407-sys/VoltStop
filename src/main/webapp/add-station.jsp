<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"STATION_ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Add Station</title>
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

<div class="dash-shell" style="max-width: 560px;">
    <a href="my-stations.jsp" class="back-link">&larr; Back to my stations</a>

    <div class="auth-form-wrap" style="max-width: 100%;">
        <h1>Add a station</h1>
        <p class="lede">New stations need approval before they appear in search.</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="msg error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="add-station" method="post">
            <div class="field">
                <label for="name">Station name</label>
                <input type="text" id="name" name="name" placeholder="e.g. GreenCharge Hub" required>
            </div>

            <div class="field">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" placeholder="Street address" required>
            </div>

            <div class="field">
                <label for="city">City</label>
                <input type="text" id="city" name="city" placeholder="City">
            </div>

            <div class="field">
                <label for="latitude">Latitude (optional)</label>
                <input type="text" id="latitude" name="latitude" placeholder="e.g. 17.6868">
            </div>

            <div class="field">
                <label for="longitude">Longitude (optional)</label>
                <input type="text" id="longitude" name="longitude" placeholder="e.g. 83.2185">
            </div>

            <button type="submit" class="btn-primary">Add station</button>
        </form>
    </div>
</div>

</body>
</html>