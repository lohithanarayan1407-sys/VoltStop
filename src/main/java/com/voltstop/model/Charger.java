package com.voltstop.model;

public class Charger {
    private int chargerId;
    private int stationId;
    private String chargerCode;
    private String connectorType; // TYPE1, TYPE2, CCS, CHADEMO, GBT
    private double powerKw;
    private double pricePerKwh;
    private String status; // AVAILABLE, MAINTENANCE, INACTIVE

    public Charger() {}

    public Charger(int stationId, String chargerCode, String connectorType, double powerKw, double pricePerKwh) {
        this.stationId = stationId;
        this.chargerCode = chargerCode;
        this.connectorType = connectorType;
        this.powerKw = powerKw;
        this.pricePerKwh = pricePerKwh;
    }

    public int getChargerId() { return chargerId; }
    public void setChargerId(int chargerId) { this.chargerId = chargerId; }

    public int getStationId() { return stationId; }
    public void setStationId(int stationId) { this.stationId = stationId; }

    public String getChargerCode() { return chargerCode; }
    public void setChargerCode(String chargerCode) { this.chargerCode = chargerCode; }

    public String getConnectorType() { return connectorType; }
    public void setConnectorType(String connectorType) { this.connectorType = connectorType; }

    public double getPowerKw() { return powerKw; }
    public void setPowerKw(double powerKw) { this.powerKw = powerKw; }

    public double getPricePerKwh() { return pricePerKwh; }
    public void setPricePerKwh(double pricePerKwh) { this.pricePerKwh = pricePerKwh; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}