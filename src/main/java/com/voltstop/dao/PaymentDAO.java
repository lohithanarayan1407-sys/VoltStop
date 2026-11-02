package com.voltstop.dao;

import com.voltstop.util.DBConnection;
import java.sql.*;

public class PaymentDAO {

    public void createPendingPayment(int bookingId, double amount) {
        String sql = "INSERT INTO payments (booking_id, amount, status) VALUES (?, ?, 'PENDING')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setDouble(2, amount);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void markPaid(int bookingId) {
        String sql = "UPDATE payments SET status = 'SUCCESS', transaction_time = CURRENT_TIMESTAMP WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
 // Paid bookings at stations owned by this operator. Each row: station, charger, date, amount, paid-at
    public java.util.List<String[]> getEarningsByOwner(int ownerId) {
        java.util.List<String[]> rows = new java.util.ArrayList<>();
        String sql = "SELECT s.name, c.charger_code, sl.slot_date, p.amount, p.transaction_time " +
                     "FROM payments p " +
                     "JOIN bookings b ON p.booking_id = b.booking_id " +
                     "JOIN slots sl ON b.slot_id = sl.slot_id " +
                     "JOIN chargers c ON sl.charger_id = c.charger_id " +
                     "JOIN stations s ON c.station_id = s.station_id " +
                     "WHERE s.owner_id = ? AND p.status = 'SUCCESS' " +
                     "ORDER BY p.transaction_time DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rows.add(new String[] {
                    rs.getString(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5)
                });
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return rows;
    }
}
