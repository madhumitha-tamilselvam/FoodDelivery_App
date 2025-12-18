package com.tap.daoimp;

import com.tao.utility.DBConnection;
import com.tap.dao.UserDAO;
import com.tap.model.User;

import java.sql.*;

public class UserDAOImpl implements UserDAO {

    @Override
    public User validateUser(String username, String password) {
        User user = null;
        String sql = "SELECT * FROM USER WHERE Username=? AND Password=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("Userid"));          // Matches DB
                user.setName(rs.getString("Name"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setRole(rs.getString("Role"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("Phone"));
                user.setAddress(rs.getString("Address"));
                user.setCreatedDate(rs.getString("Created_date"));
                user.setLastLoginDate(rs.getString("Lastlogin_date"));

                System.out.println("User validated. ID: " + user.getId() + ", Name: " + user.getName());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public boolean registerUser(User user) {
        String sql = "INSERT INTO USER (Name, Username, Password, Email, Phone, Address, Role, Created_date, Lastlogin_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getRole());

            int row = ps.executeUpdate();

            // Get auto-generated Userid
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                user.setId(rs.getInt(1));
                System.out.println("Registered user ID: " + user.getId());
            }

            return row > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
