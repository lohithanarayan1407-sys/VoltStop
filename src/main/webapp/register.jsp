<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VoltStop — Create account</title>
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
            <h1 class="auth-hero__headline">Charging, on <span class="accent">your</span> schedule.</h1>
            <p class="auth-hero__sub">Create an account to start booking slots, tracking charge time, and paying for sessions — all in one place.</p>
        </div>

        <ul class="auth-hero__features">
            <li><span class="dot"></span><span><strong>For drivers</strong> — book a slot, pay, get notified when it's done</span></li>
            <li><span class="dot"></span><span><strong>For station operators</strong> — manage chargers and bookings</span></li>
        </ul>
    </aside>

    <main class="auth-panel">
        <div class="auth-form-wrap">
            <h1>Create your account</h1>
            <p class="lede">Set up VoltStop in under a minute.</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="msg error"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="register" method="post">
                <div class="field">
                    <label for="name">Full name</label>
                    <input type="text" id="name" name="name" placeholder="Your name" required>
                </div>

                <div class="field">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>

                <div class="field">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                </div>

                <div class="field">
                    <label for="phone">Phone</label>
                    <input type="text" id="phone" name="phone" placeholder="10-digit number">
                </div>

                <div class="field">
                    <label for="role">I am a...</label>
                    <select id="role" name="role">
                        <option value="EV_USER">EV driver</option>
                        <option value="STATION_ADMIN">Station operator</option>
                    </select>
                </div>

                <button type="submit" class="btn-primary">Create account</button>
            </form>

            <p class="auth-switch">Already have an account? <a href="login.jsp">Log in</a></p>
        </div>
    </main>

</div>
</body>
</html>