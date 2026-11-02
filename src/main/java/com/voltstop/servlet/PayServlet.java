package com.voltstop.servlet;

import com.voltstop.dao.PaymentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/pay")
public class PayServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        new PaymentDAO().markPaid(bookingId);
        response.sendRedirect("my-bookings.jsp");
    }
}