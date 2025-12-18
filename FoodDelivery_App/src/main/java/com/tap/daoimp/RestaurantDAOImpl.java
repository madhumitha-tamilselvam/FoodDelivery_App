package com.tap.daoimp;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tao.utility.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public void addRestaurant(Restaurant r) {
        String sql = "INSERT INTO restaurant VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, r.getRestaurantId());
            ps.setString(2, r.getName());
            ps.setString(3, r.getAddress());
            ps.setString(4, r.getPhone());
            ps.setDouble(5, r.getRating());
            ps.setString(6, r.getCuisineType());
            ps.setBoolean(7, r.isActive());
            ps.setString(8, r.getEta());
            ps.setInt(9, r.getAdminUserId());
            ps.setString(10, r.getImagePath());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int id) {
        String sql = "SELECT * FROM restaurant WHERE restaurantid=?";
        Restaurant r = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                r = new Restaurant(
                        rs.getInt("restaurantid"), rs.getString("name"),
                        rs.getString("address"), rs.getString("phone"),
                        rs.getDouble("rating"), rs.getString("cusinetype"),
                        rs.getBoolean("isactive"), rs.getString("eta"),
                        rs.getInt("adminuserid"), rs.getString("imagepath"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return r;
    }

    @Override
    public void updateRestaurant(Restaurant r) {
        String sql = "UPDATE restaurant SET name=?, address=?, phone=?, rating=?, cusinetype=?, isactive=?, eta=?, adminuserid=?, imagepath=? WHERE restaurantid=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getName());
            ps.setString(2, r.getAddress());
            ps.setString(3, r.getPhone());
            ps.setDouble(4, r.getRating());
            ps.setString(5, r.getCuisineType());
            ps.setBoolean(6, r.isActive());
            ps.setString(7, r.getEta());
            ps.setInt(8, r.getAdminUserId());
            ps.setString(9, r.getImagePath());
            ps.setInt(10, r.getRestaurantId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int id) {
        String sql = "DELETE FROM restaurant WHERE restaurantid=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        String sql = "SELECT * FROM restaurant";
        List<Restaurant> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Restaurant r = new Restaurant(
                        rs.getInt("restaurantid"), rs.getString("name"),
                        rs.getString("address"), rs.getString("phone"),
                        rs.getDouble("rating"), rs.getString("cusinetype"),
                        rs.getBoolean("isactive"), rs.getString("eta"),
                        rs.getInt("adminuserid"), rs.getString("imagepath"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
