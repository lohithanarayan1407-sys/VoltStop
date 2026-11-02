package com.voltstop.servlet;

import com.voltstop.dao.VehicleDAO;
import com.voltstop.model.Vehicle;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/add-vehicle")
public class AddVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }

        int userId = (int) session.getAttribute("userId");
        String vehicleName = request.getParameter("vehicleName");
        double batteryCapacityKwh = Double.parseDouble(request.getParameter("batteryCapacityKwh"));
        String connectorType = request.getParameter("connectorType");
        String redirectTo = request.getParameter("redirect");
        if (redirectTo == null || redirectTo.isBlank()) redirectTo = "user-dashboard.jsp";

        Vehicle v = new Vehicle(userId, vehicleName, batteryCapacityKwh, connectorType);
        new VehicleDAO().addVehicle(v);

        response.sendRedirect(redirectTo);
    }
}