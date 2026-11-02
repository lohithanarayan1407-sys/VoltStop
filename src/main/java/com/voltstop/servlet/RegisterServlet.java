package com.voltstop.servlet;

import com.voltstop.dao.UserDAO;
import com.voltstop.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        UserDAO userDAO = new UserDAO();

        // Check if email is already registered
        if (userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "An account with this email already exists.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(name, email, password, phone, role);
        boolean success = userDAO.registerUser(newUser);

        if (success) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}