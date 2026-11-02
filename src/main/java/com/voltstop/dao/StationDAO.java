package com.voltstop.dao;

import com.voltstop.model.Station;
import com.voltstop.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StationDAO {

    public boolean addStation(Station station) {
        String sql = "INSERT INTO stations (owner_id, name, address, city, latitude, longitude) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, station.getOwnerId());
            ps.setString(2, station.getName());
            ps.setString(3, station.getAddress());
            ps.setString(4, station.getCity());
            if (station.getLatitude() != null) ps.setDouble(5, station.getLatitude()); else ps.setNull(5, Types.DECIMAL);
            if (station.getLongitude() != null) ps.setDouble(6, station.getLongitude()); else ps.setNull(6, Types.DECIMAL);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Station> getStationsByOwner(int ownerId) {
        List<Station> stations = new ArrayList<>();
        String sql = "SELECT * FROM stations WHERE owner_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stations.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stations;
    }

    public Station findById(int stationId) {
        String sql = "SELECT * FROM stations WHERE station_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, stationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Active stations, for the EV user search page (built in the next step)
    public List<Station> getActiveStations() {
        List<Station> stations = new ArrayList<>();
        String sql = "SELECT * FROM stations WHERE status = 'ACTIVE' ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                stations.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stations;
    }

    private Station mapRow(ResultSet rs) throws SQLException {
        Station s = new Station();
        s.setStationId(rs.getInt("station_id"));
        s.setOwnerId(rs.getInt("owner_id"));
        s.setName(rs.getString("name"));
        s.setAddress(rs.getString("address"));
        s.setCity(rs.getString("city"));
        double lat = rs.getDouble("latitude");
        s.setLatitude(rs.wasNull() ? null : lat);
        double lng = rs.getDouble("longitude");
        s.setLongitude(rs.wasNull() ? null : lng);
        s.setStatus(rs.getString("status"));
        return s;
    }
}