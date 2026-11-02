package com.voltstop.dao;

import com.voltstop.model.User;
import com.voltstop.util.DBConnection;
import java.sql.*;

public class UserDAO {

    // Insert a new user, returns true if successful
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password_hash, phone, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Find a user by email — returns null if not found
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                return user;
            }
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Validate login credentials — returns the User if valid, null otherwise

    // Validate login credentials
    public User validateLogin(String email, String password) {
        User user = findByEmail(email);

        if (user == null || password == null) {
            return null;
        }

        String storedPassword = user.getPasswordHash();

        if (storedPassword != null && storedPassword.equals(password)) {
            return user;
        }

        return null;

    }
}