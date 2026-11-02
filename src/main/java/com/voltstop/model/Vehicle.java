package com.voltstop.model;

public class Vehicle {
    private int vehicleId;
    private int userId;
    private String vehicleName;
    private double batteryCapacityKwh;
    private String connectorType;

    public Vehicle() {}

    public Vehicle(int userId, String vehicleName, double batteryCapacityKwh, String connectorType) {
        this.userId = userId;
        this.vehicleName = vehicleName;
        this.batteryCapacityKwh = batteryCapacityKwh;
        this.connectorType = connectorType;
    }

    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getVehicleName() { return vehicleName; }
    public void setVehicleName(String vehicleName) { this.vehicleName = vehicleName; }
    public double getBatteryCapacityKwh() { return batteryCapacityKwh; }
    public void setBatteryCapacityKwh(double batteryCapacityKwh) { this.batteryCapacityKwh = batteryCapacityKwh; }
    public String getConnectorType() { return connectorType; }
    public void setConnectorType(String connectorType) { this.connectorType = connectorType; }
}