package com.voltstop.dao;

import com.voltstop.model.Vehicle;
import com.voltstop.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDAO {

    public boolean addVehicle(Vehicle v) {
        String sql = "INSERT INTO vehicles (user_id, vehicle_name, battery_capacity_kwh, connector_type) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, v.getUserId());
            ps.setString(2, v.getVehicleName());
            ps.setDouble(3, v.getBatteryCapacityKwh());
            ps.setString(4, v.getConnectorType());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Vehicle> getVehiclesByUser(int userId) {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT * FROM vehicles WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Vehicle findById(int vehicleId) {
        String sql = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, vehicleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private Vehicle mapRow(ResultSet rs) throws SQLException {
        Vehicle v = new Vehicle();
        v.setVehicleId(rs.getInt("vehicle_id"));
        v.setUserId(rs.getInt("user_id"));
        v.setVehicleName(rs.getString("vehicle_name"));
        v.setBatteryCapacityKwh(rs.getDouble("battery_capacity_kwh"));
        v.setConnectorType(rs.getString("connector_type"));
        return v;
    }
}