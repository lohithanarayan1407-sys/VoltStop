package com.voltstop.dao;

import com.voltstop.model.Charger;
import com.voltstop.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ChargerDAO {

    public boolean addCharger(Charger charger) {
        String sql = "INSERT INTO chargers (station_id, charger_code, connector_type, power_kw, price_per_kwh) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, charger.getStationId());
            ps.setString(2, charger.getChargerCode());
            ps.setString(3, charger.getConnectorType());
            ps.setDouble(4, charger.getPowerKw());
            ps.setDouble(5, charger.getPricePerKwh());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Charger> getChargersByStation(int stationId) {
        List<Charger> chargers = new ArrayList<>();
        String sql = "SELECT * FROM chargers WHERE station_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, stationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                chargers.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return chargers;
    }

    private Charger mapRow(ResultSet rs) throws SQLException {
        Charger c = new Charger();
        c.setChargerId(rs.getInt("charger_id"));
        c.setStationId(rs.getInt("station_id"));
        c.setChargerCode(rs.getString("charger_code"));
        c.setConnectorType(rs.getString("connector_type"));
        c.setPowerKw(rs.getDouble("power_kw"));
        c.setPricePerKwh(rs.getDouble("price_per_kwh"));
        c.setStatus(rs.getString("status"));
        return c;
    }
    public com.voltstop.model.Charger findById(int chargerId) {
        String sql = "SELECT * FROM chargers WHERE charger_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, chargerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}