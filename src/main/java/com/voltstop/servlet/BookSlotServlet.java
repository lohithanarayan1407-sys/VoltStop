package com.voltstop.servlet;

import com.voltstop.dao.*;
import com.voltstop.model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalTime;

@WebServlet("/book-slot")
public class BookSlotServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
        int userId = (int) session.getAttribute("userId");

        int chargerId = Integer.parseInt(request.getParameter("chargerId"));
        int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
        String slotDate = request.getParameter("slotDate");
        String startTimeStr = request.getParameter("startTime");
        double batteryStartPct = Double.parseDouble(request.getParameter("batteryStartPct"));
        double batteryTargetPct = Double.parseDouble(request.getParameter("batteryTargetPct"));

        ChargerDAO chargerDAO = new ChargerDAO();
        VehicleDAO vehicleDAO = new VehicleDAO();
        Charger charger = chargerDAO.findById(chargerId);
        Vehicle vehicle = vehicleDAO.findById(vehicleId);

        // --- Charge-time & cost estimate ---
        // Energy needed (kWh) = (% to charge / 100) * battery capacity
        double pctToCharge = batteryTargetPct - batteryStartPct;
        double energyNeededKwh = (pctToCharge / 100.0) * vehicle.getBatteryCapacityKwh();
        double estimatedHours = energyNeededKwh / charger.getPowerKw();
        int estimatedMins = (int) Math.ceil(estimatedHours * 60);
        double estimatedCost = energyNeededKwh * charger.getPricePerKwh();

        // Slot end time = start + estimated duration (rounded up to the nearest 30 min block)
        LocalTime start = LocalTime.parse(startTimeStr);
        int blockMins = ((estimatedMins + 29) / 30) * 30; // round up to nearest 30
        if (blockMins < 30) blockMins = 30;
        LocalTime end = start.plusMinutes(blockMins);

        SlotDAO slotDAO = new SlotDAO();
        int slotId = slotDAO.findOrCreateSlot(chargerId, slotDate, start.toString(), end.toString());

        if (slotId == -1) {
            request.setAttribute("error", "That slot is no longer available. Please pick a different time.");
            request.getRequestDispatcher("book-slot.jsp?chargerId=" + chargerId).forward(request, response);
            return;
        }

        Booking booking = new Booking();
        booking.setUserId(userId);
        booking.setVehicleId(vehicleId);
        booking.setSlotId(slotId);
        booking.setBatteryStartPct(batteryStartPct);
        booking.setBatteryTargetPct(batteryTargetPct);
        booking.setEstimatedTimeMins(estimatedMins);
        booking.setEstimatedCost(estimatedCost);

        int bookingId = new BookingDAO().createBooking(booking);
        slotDAO.markBooked(slotId);
        new PaymentDAO().createPendingPayment(bookingId, estimatedCost);

        response.sendRedirect("my-bookings.jsp");
    }
}