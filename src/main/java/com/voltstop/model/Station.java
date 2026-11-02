package com.voltstop.model;

public class Station {
    private int stationId;
    private int ownerId;
    private String name;
    private String address;
    private String city;
    private Double latitude;
    private Double longitude;
    private String status; // PENDING_APPROVAL, ACTIVE, INACTIVE

    public Station() {}

    public Station(int ownerId, String name, String address, String city, Double latitude, Double longitude) {
        this.ownerId = ownerId;
        this.name = name;
        this.address = address;
        this.city = city;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public int getStationId() { return stationId; }
    public void setStationId(int stationId) { this.stationId = stationId; }

    public int getOwnerId() { return ownerId; }
    public void setOwnerId(int ownerId) { this.ownerId = ownerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }

    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}