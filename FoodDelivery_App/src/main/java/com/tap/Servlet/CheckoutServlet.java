package com.tap.Servlet;

import com.tap.model.Cart;
import com.tap.model.CartItem;
import com.tap.model.Order;
import com.tap.model.OrderItem;
import com.tap.dao.OrderDAO;
import com.tap.dao.OrderItemDAO;
import com.tap.daoimp.OrderDAOImpl;
import com.tap.daoimp.OrderItemDAOImpl;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    // ✅ FIRST: Handle GET → open checkout page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher rd = request.getRequestDispatcher("checkout.jsp");
        rd.forward(request, response);
    }

    // ✅ NEXT: Handle POST → place order
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // GET LOGGED-IN USER
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // GET CART
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("Cart.jsp");
            return;
        }

        // GET RESTAURANT ID
        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
        if (restaurantId == null) restaurantId = 1;

        double totalAmount = cart.getTotal();
        String paymentMode = request.getParameter("paymentMode");

        // ---------- CREATE ORDER ----------
        Order order = new Order();
        order.setUserId(userId);
        order.setRestaurantId(restaurantId);
        order.setOrderDate(new Timestamp(System.currentTimeMillis()));
        order.setTotalAmount(totalAmount);
        order.setStatus("CONFIRMED");
        order.setPaymentMode(paymentMode);

        OrderDAO orderDAO = new OrderDAOImpl();
        int orderId = orderDAO.createOrder(order);

        session.setAttribute("orderId", orderId);

        // ---------- INSERT ORDER ITEMS ----------
        OrderItemDAO itemDAO = new OrderItemDAOImpl();

        for (CartItem c : cart.getItems().values()) {

            OrderItem item = new OrderItem();
            item.setOrderId(orderId);
            item.setMenuId(c.getId());
            item.setQuantity(c.getQuantity());
            item.setTotalPrice(c.getTotal());

            itemDAO.addOrderItem(item);
        }

        // CLEAR CART
        session.removeAttribute("cart");

        response.sendRedirect("order-confirmed.jsp");
    }
}
