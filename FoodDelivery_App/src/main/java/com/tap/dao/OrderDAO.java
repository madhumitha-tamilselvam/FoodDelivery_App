package com.tap.dao;

import com.tap.model.Order;

public interface OrderDAO {
    int createOrder(Order order);  // returns generated orderId
}
