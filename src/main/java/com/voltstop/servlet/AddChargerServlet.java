package com.voltstop.servlet;

import com.voltstop.dao.ChargerDAO;
import com.voltstop.dao.StationDAO;
import com.voltstop.model.Charger;
import com.voltstop.model.Station;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/add-charger")
public class AddChargerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int ownerId = (int) session.getAttribute("userId");
        int stationId = Integer.parseInt(request.getParameter("stationId"));

        // Ownership check before writing anything
        StationDAO stationDAO = new StationDAO();
        Station station = stationDAO.findById(stationId);
        if (station == null || station.getOwnerId() != ownerId) {
            response.sendRedirect("my-stations.jsp");
            return;
        }

        String chargerCode = request.getParameter("chargerCode");
        String connectorType = request.getParameter("connectorType");
        double powerKw = Double.parseDouble(request.getParameter("powerKw"));
        double pricePerKwh = Double.parseDouble(request.getParameter("pricePerKwh"));

        Charger charger = new Charger(stationId, chargerCode, connectorType, powerKw, pricePerKwh);
        new ChargerDAO().addCharger(charger);

        response.sendRedirect("chargers.jsp?stationId=" + stationId);
    }
}