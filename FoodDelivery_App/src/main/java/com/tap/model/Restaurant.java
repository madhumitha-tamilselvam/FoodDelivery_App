package com.tap.model;

public class Restaurant {
	

	    private int restaurantId;
	    private String name;
	    private String address;
	    private String phone;
	    private double rating;
	    private String cuisineType;
	    private boolean isActive;
	    private String eta;
	    private int adminUserId;
	    private String imagePath;

	    public Restaurant() {}

	    public Restaurant(int restaurantId, String name, String address, String phone,
	                      double rating, String cuisineType, boolean isActive,
	                      String eta, int adminUserId, String imagePath) {

	        this.restaurantId = restaurantId;
	        this.name = name;
	        this.address = address;
	        this.phone = phone;
	        this.rating = rating;
	        this.cuisineType = cuisineType;
	        this.isActive = isActive;
	        this.eta = eta;
	        this.adminUserId = adminUserId;
	        this.imagePath = imagePath;
	    }

	    // Getters & Setters

	    public int getRestaurantId() {
	        return restaurantId;
	    }

	    public void setRestaurantId(int restaurantId) {
	        this.restaurantId = restaurantId;
	    }

	    public String getName() {
	        return name;
	    }

	    public void setName(String name) {
	        this.name = name;
	    }

	    public String getAddress() {
	        return address;
	    }

	    public void setAddress(String address) {
	        this.address = address;
	    }

	    public String getPhone() {
	        return phone;
	    }

	    public void setPhone(String phone) {
	        this.phone = phone;
	    }

	    public double getRating() {
	        return rating;
	    }

	    public void setRating(double rating) {
	        this.rating = rating;
	    }

	    public String getCuisineType() {
	        return cuisineType;
	    }

	    public void setCuisineType(String cuisineType) {
	        this.cuisineType = cuisineType;
	    }

	    public boolean isActive() {
	        return isActive;
	    }

	    public void setActive(boolean active) {
	        isActive = active;
	    }

	    public String getEta() {
	        return eta;
	    }

	    public void setEta(String eta) {
	        this.eta = eta;
	    }

	    public int getAdminUserId() {
	        return adminUserId;
	    }

	    public void setAdminUserId(int adminUserId) {
	        this.adminUserId = adminUserId;
	    }

	    public String getImagePath() {
	        return imagePath;
	    }

	    public void setImagePath(String imagePath) {
	        this.imagePath = imagePath;
	    }
	}



