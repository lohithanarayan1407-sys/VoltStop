<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<body>
<h2>VoltStop — Database Connection Test</h2>
<%
	String url = "jdbc:mysql://localhost:3306/voltstop?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "lohi@1407"; // <-- replace this

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = com.voltstop.util.DBConnection.getConnection(); 
        out.println("<p style='color:green;'>Connected successfully to MySQL!</p>");

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT user_id, name, email, role FROM users");

        out.println("<table border='1' cellpadding='6'>");
        out.println("<tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th></tr>");
        while (rs.next()) {
            out.println("<tr><td>" + rs.getInt("user_id") + "</td><td>"
                    + rs.getString("name") + "</td><td>"
                    + rs.getString("email") + "</td><td>"
                    + rs.getString("role") + "</td></tr>");
        }
        out.println("</table>");

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Connection failed: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>