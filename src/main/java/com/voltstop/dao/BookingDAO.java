package com.voltstop.dao;

import com.voltstop.model.Booking;
import com.voltstop.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public int createBooking(Booking b) {
        String sql = "INSERT INTO bookings (user_id, vehicle_id, slot_id, battery_start_pct, battery_target_pct, estimated_time_mins, estimated_cost, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, 'BOOKED')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getVehicleId());
            ps.setInt(3, b.getSlotId());
            ps.setDouble(4, b.getBatteryStartPct());
            ps.setDouble(5, b.getBatteryTargetPct());
            ps.setInt(6, b.getEstimatedTimeMins());
            ps.setDouble(7, b.getEstimatedCost());
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, s.name AS station_name, c.charger_code, sl.slot_date, sl.start_time, p.status AS payment_status " +
                     "FROM bookings b " +
                     "JOIN slots sl ON b.slot_id = sl.slot_id " +
                     "JOIN chargers c ON sl.charger_id = c.charger_id " +
                     "JOIN stations s ON c.station_id = s.station_id " +
                     "LEFT JOIN payments p ON p.booking_id = b.booking_id " +
                     "WHERE b.user_id = ? ORDER BY b.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setBatteryStartPct(rs.getDouble("battery_start_pct"));
                b.setBatteryTargetPct(rs.getDouble("battery_target_pct"));
                b.setEstimatedTimeMins(rs.getInt("estimated_time_mins"));
                b.setEstimatedCost(rs.getDouble("estimated_cost"));
                b.setStatus(rs.getString("status"));
                b.setStationName(rs.getString("station_name"));
                b.setChargerCode(rs.getString("charger_code"));
                b.setSlotDate(rs.getString("slot_date"));
                b.setStartTime(rs.getString("start_time"));
                b.setPaymentStatus(rs.getString("payment_status"));
                list.add(b);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}