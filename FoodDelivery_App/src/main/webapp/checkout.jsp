<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Map" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("Cart.jsp");
        return;
    }

    Integer userId = (Integer) session.getAttribute("userId");
    Integer restaurantId = (Integer) session.getAttribute("restaurantId");
    if (restaurantId == null) restaurantId = 1;
%>

<!DOCTYPE html>
<html>
<head>
<title>Checkout Summary</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
*{
    box-sizing:border-box;
}

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    min-height:100vh;

    /* 🌈 COLORFUL BACKGROUND */
    background:
      linear-gradient(135deg,
        rgba(255,154,158,0.95),
        rgba(250,208,196,0.95),
        rgba(255,221,89,0.95)
      ),
      url("https://images.unsplash.com/photo-1504674900247-0877df9cc836")
      center/cover no-repeat;

    display:flex;
    justify-content:center;
    align-items:center;
    padding:40px 0;
}

.checkout-wrapper{
    width:90%;
    max-width:900px;
    background:rgba(255,255,255,0.97);
    border-radius:26px;
    padding:35px;
    box-shadow:0 35px 80px rgba(0,0,0,0.25);
}

h2{
    text-align:center;
    margin-bottom:20px;
    color:#222;
}

.section-title{
    margin-top:35px;
}

table{
    width:100%;
    border-collapse:collapse;
    margin-top:15px;
    overflow:hidden;
    border-radius:16px;
}

th{
    background:#fff1e6;
    padding:14px;
    font-weight:600;
    text-align:center;
}

td{
    padding:14px;
    text-align:center;
    border-top:1px solid #eee;
}

.summary-table th{
    width:40%;
    text-align:left;
}

.summary-table td{
    text-align:left;
}

select{
    width:100%;
    padding:12px;
    border-radius:12px;
    border:1px solid #ccc;
    font-size:15px;
    outline:none;
}

.confirm-btn{
    margin:35px auto 0;
    display:block;
    background:linear-gradient(135deg,#ff7a18,#ff3d00);
    color:white;
    padding:16px 40px;
    border:none;
    border-radius:18px;
    cursor:pointer;
    font-size:18px;
    font-weight:700;
    transition:0.3s;
}

.confirm-btn:hover{
    transform:translateY(-4px);
    box-shadow:0 18px 35px rgba(255,61,0,0.45);
}
</style>
</head>

<body>

<div class="checkout-wrapper">

<h2>🧾 Order Summary</h2>

<!-- ORDER DETAILS -->
<table class="summary-table">
    <tr><th>User ID</th><td><%= userId %></td></tr>
    <tr><th>Restaurant ID</th><td><%= restaurantId %></td></tr>
    <tr><th>Order Date</th><td><%= new java.util.Date() %></td></tr>
    <tr><th>Total Amount</th><td>₹ <strong><%= cart.getTotal() %></strong></td></tr>
    <tr>
        <th>Status</th>
        <td style="color:green;font-weight:600;">CONFIRMED</td>
    </tr>

    <tr>
        <th>Payment Mode</th>
        <td>
            <form action="CheckoutServlet" method="post" id="payForm">
                <select name="paymentMode" required>
                    <option value="">Select Payment Mode</option>
                    <option value="CASH">Cash On Delivery</option>
                    <option value="ONLINE">Online Payment</option>
                </select>
            </form>
        </td>
    </tr>
</table>

<h2 class="section-title">🛒 Order Items</h2>

<!-- ORDER ITEMS -->
<table>
    <tr>
        <th>Menu ID</th>
        <th>Item Name</th>
        <th>Quantity</th>
        <th>Total Price</th>
    </tr>

<%
    for (CartItem item : cart.getItems().values()) {
%>
    <tr>
        <td><%= item.getId() %></td>
        <td><%= item.getName() %></td>
        <td><%= item.getQuantity() %></td>
        <td>₹ <%= item.getTotal() %></td>
    </tr>
<%
    }
%>
</table>

<button class="confirm-btn" onclick="document.getElementById('payForm').submit();">
    ✔ Confirm Order
</button>

</div>

</body>
</html>
