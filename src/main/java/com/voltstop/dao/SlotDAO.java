package com.voltstop.dao;

import com.voltstop.util.DBConnection;
import java.sql.*;

public class SlotDAO {

    // Returns the slot_id for this charger/date/startTime — creates it if it doesn't exist yet.
    // Returns -1 if that slot is already booked.
    public int findOrCreateSlot(int chargerId, String date, String startTime, String endTime) {
        String findSql = "SELECT slot_id, is_booked FROM slots WHERE charger_id = ? AND slot_date = ? AND start_time = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(findSql)) {
            ps.setInt(1, chargerId);
            ps.setString(2, date);
            ps.setString(3, startTime);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getBoolean("is_booked")) return -1; // already taken
                return rs.getInt("slot_id");
            }
        } catch (SQLException e) { e.printStackTrace(); return -1; }

        String insertSql = "INSERT INTO slots (charger_id, slot_date, start_time, end_time, is_booked) VALUES (?, ?, ?, ?, FALSE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, chargerId);
            ps.setString(2, date);
            ps.setString(3, startTime);
            ps.setString(4, endTime);
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    public void markBooked(int slotId) {
        String sql = "UPDATE slots SET is_booked = TRUE WHERE slot_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, slotId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}