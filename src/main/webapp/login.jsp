<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Log in</title>
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="auth-page">

    <aside class="auth-hero">
        <div class="auth-hero__brand">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                <path d="M13 2L4 14h6l-1 8 9-12h-6l1-8z" fill="#FFB627"/>
            </svg>
            VoltStop
        </div>

        <div>
            <h1 class="auth-hero__headline">Your next <span class="accent">charge</span>, already booked.</h1>
            <p class="auth-hero__sub">Find a nearby station, reserve a slot, and know exactly when your car will be ready — before you even leave home.</p>
        </div>

        <ul class="auth-hero__features">
            <li><span class="dot"></span><span><strong>Nearby stations</strong> — see live availability around you</span></li>
            <li><span class="dot"></span><span><strong>Slot booking</strong> — reserve a charger for a specific time</span></li>
            <li><span class="dot"></span><span><strong>Charge estimate</strong> — know your ready time before you arrive</span></li>
        </ul>
    </aside>

    <main class="auth-panel">
        <div class="auth-form-wrap">
            <h1>Log in</h1>
            <p class="lede">Welcome back — enter your details to continue.</p>

            <% if (request.getParameter("registered") != null) { %>
                <div class="msg success">Account created. Log in to continue.</div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="msg error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="login" method="post">
                <div class="field">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>

                <div class="field">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <button type="submit" class="btn-primary">Log in</button>
            </form>

            <p class="auth-switch">Don't have an account? <a href="register.jsp">Create one</a></p>
        </div>
    </main>

</div>
</body>
</html>