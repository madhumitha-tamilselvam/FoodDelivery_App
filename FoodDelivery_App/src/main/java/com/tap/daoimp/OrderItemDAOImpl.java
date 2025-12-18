package com.tap.daoimp;

import com.tap.dao.OrderItemDAO;
import com.tap.model.OrderItem;
import com.tao.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public void addOrderItem(OrderItem item) {

        String sql = "INSERT INTO ORDERITEM (Orderid, Menuid, Quantity, Totalprice) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, item.getOrderId());
            ps.setInt(2, item.getMenuId());
            ps.setInt(3, item.getQuantity());
            ps.setDouble(4, item.getTotalPrice());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
