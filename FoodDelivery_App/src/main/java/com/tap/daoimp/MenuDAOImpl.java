package com.tap.daoimp;

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;
import com.tao.utility.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public void addMenu(Menu menu) {

        Connection con = DBConnection.getConnection();
        String QUERY = "INSERT INTO menu (restaurant_id, itemname, description, price, rating, isavailable, imagepath) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(QUERY);
            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setDouble(5, menu.getRating());
            ps.setBoolean(6, menu.isAvailable());
            ps.setString(7, menu.getImagePath());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    @Override
    public Menu getMenu(int menuId) {

        Connection con = DBConnection.getConnection();
        String QUERY = "SELECT * FROM menu WHERE menuid=?";
        PreparedStatement ps = null;
        Menu menu = null;

        try {
            ps = con.prepareStatement(QUERY);
            ps.setInt(1, menuId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                menu = new Menu(
                    rs.getInt("menuid"),
                    rs.getInt("restaurant_id"),
                    rs.getString("itemname"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getDouble("rating"),
                    rs.getBoolean("isavailable"),
                    rs.getString("imagepath")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return menu;
    }

    @Override
    public void updateMenu(Menu menu) {

        Connection con = DBConnection.getConnection();
        String QUERY = "UPDATE menu SET restaurant_id=?, itemname=?, description=?, price=?, rating=?, isavailable=?, imagepath=? WHERE menuid=?";
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(QUERY);

            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getDescription());
            ps.setDouble(4, menu.getPrice());
            ps.setDouble(5, menu.getRating());
            ps.setBoolean(6, menu.isAvailable());
            ps.setString(7, menu.getImagePath());
            ps.setInt(8, menu.getMenuId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    @Override
    public void deleteMenu(int menuId) {

        Connection con = DBConnection.getConnection();
        String QUERY = "DELETE FROM menu WHERE menuid=?";
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(QUERY);
            ps.setInt(1, menuId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    @Override
    public List<Menu> getAllMenus() {

        List<Menu> list = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String QUERY = "SELECT * FROM menu";
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(QUERY);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Menu(
                    rs.getInt("menuid"),
                    rs.getInt("restaurant_id"),
                    rs.getString("itemname"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getDouble("rating"),
                    rs.getBoolean("isavailable"),
                    rs.getString("imagepath")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return list;
    }
    public List<Menu> getMenuByRestaurantId(int restaurantId) {

        List<Menu> menuList = new ArrayList<>();
        Connection con = DBConnection.getConnection();
        String QUERY = "SELECT * FROM menu WHERE restaurant_id=?";
        PreparedStatement ps = null;

        try {
            ps = con.prepareStatement(QUERY);
            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                menuList.add(new Menu(
                    rs.getInt("menuid"),
                    rs.getInt("restaurant_id"),
                    rs.getString("itemname"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getDouble("rating"),
                    rs.getBoolean("isavailable"),
                    rs.getString("imagepath")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return menuList;
    }

}
