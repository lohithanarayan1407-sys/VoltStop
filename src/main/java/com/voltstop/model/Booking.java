package com.voltstop.model;

public class Booking {
    private int bookingId;
    private int userId;
    private int vehicleId;
    private int slotId;
    private double batteryStartPct;
    private double batteryTargetPct;
    private int estimatedTimeMins;
    private double estimatedCost;
    private String status;

    // Display-only fields, populated via JOIN when listing — not stored on this object in the DB itself
    private String stationName;
    private String chargerCode;
    private String slotDate;
    private String startTime;
    private String paymentStatus;

    public Booking() {}

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getVehicleId() { return vehicleId; }
    public void setVehicleId(int vehicleId) { this.vehicleId = vehicleId; }
    public int getSlotId() { return slotId; }
    public void setSlotId(int slotId) { this.slotId = slotId; }
    public double getBatteryStartPct() { return batteryStartPct; }
    public void setBatteryStartPct(double batteryStartPct) { this.batteryStartPct = batteryStartPct; }
    public double getBatteryTargetPct() { return batteryTargetPct; }
    public void setBatteryTargetPct(double batteryTargetPct) { this.batteryTargetPct = batteryTargetPct; }
    public int getEstimatedTimeMins() { return estimatedTimeMins; }
    public void setEstimatedTimeMins(int estimatedTimeMins) { this.estimatedTimeMins = estimatedTimeMins; }
    public double getEstimatedCost() { return estimatedCost; }
    public void setEstimatedCost(double estimatedCost) { this.estimatedCost = estimatedCost; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getStationName() { return stationName; }
    public void setStationName(String stationName) { this.stationName = stationName; }
    public String getChargerCode() { return chargerCode; }
    public void setChargerCode(String chargerCode) { this.chargerCode = chargerCode; }
    public String getSlotDate() { return slotDate; }
    public void setSlotDate(String slotDate) { this.slotDate = slotDate; }
    public String getStartTime() { return startTime; }
    public void setStartTime(String startTime) { this.startTime = startTime; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
}