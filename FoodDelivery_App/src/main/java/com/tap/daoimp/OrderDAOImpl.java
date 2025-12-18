package com.tap.daoimp;

import com.tap.dao.OrderDAO;
import com.tap.model.Order;
import com.tao.utility.DBConnection;

import java.sql.*;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int createOrder(Order order) {

        String sql = "INSERT INTO `ORDER` (Userid, Restaurant_id, Orderdate, Total_amount, Status, PaymentMode) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getRestaurantId());
            ps.setTimestamp(3, order.getOrderDate());
            ps.setDouble(4, order.getTotalAmount());
            ps.setString(5, order.getStatus());
            ps.setString(6, order.getPaymentMode());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // return new orderId
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }
}
