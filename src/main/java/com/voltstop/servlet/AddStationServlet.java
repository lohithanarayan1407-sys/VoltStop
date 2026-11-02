package com.voltstop.servlet;

import com.voltstop.dao.StationDAO;
import com.voltstop.model.Station;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/add-station")
public class AddStationServlet extends HttpServlet {
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
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String latStr = request.getParameter("latitude");
        String lngStr = request.getParameter("longitude");

        Double latitude = (latStr != null && !latStr.isBlank()) ? Double.parseDouble(latStr) : null;
        Double longitude = (lngStr != null && !lngStr.isBlank()) ? Double.parseDouble(lngStr) : null;

        Station station = new Station(ownerId, name, address, city, latitude, longitude);

        StationDAO stationDAO = new StationDAO();
        boolean success = stationDAO.addStation(station);

        if (success) {
            response.sendRedirect("my-stations.jsp");
        } else {
            request.setAttribute("error", "Could not add station. Please try again.");
            request.getRequestDispatcher("add-station.jsp").forward(request, response);
        }
    }
}