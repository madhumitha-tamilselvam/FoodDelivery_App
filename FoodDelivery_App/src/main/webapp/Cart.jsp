<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.Cart" %>
<%@ page import="com.tap.model.CartItem" %>
<%@ page import="java.util.Map" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");
    if(cart == null) cart = new Cart();
    Map<Integer, CartItem> items = cart.getItems();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
*{
    box-sizing:border-box;
}

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    min-height:100vh;
    background:
      linear-gradient(rgba(0,0,0,0.55),rgba(0,0,0,0.55)),
      url("https://images.unsplash.com/photo-1504674900247-0877df9cc836") center/cover no-repeat;
    display:flex;
    justify-content:center;
    align-items:flex-start;
    padding:40px 0;
}

.cart-wrapper{
    width:90%;
    max-width:1100px;
    background:rgba(255,255,255,0.95);
    border-radius:22px;
    padding:30px 35px;
    box-shadow:0 25px 60px rgba(0,0,0,0.3);
}

h2{
    text-align:center;
    font-size:34px;
    margin-bottom:35px;
    color:#222;
}

.cart-item{
    display:grid;
    grid-template-columns:2fr 1.5fr 1fr auto;
    align-items:center;
    gap:20px;
    background:#fff;
    padding:20px;
    margin-bottom:18px;
    border-radius:18px;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
    transition:0.3s;
}

.cart-item:hover{
    transform:translateY(-4px);
}

.item-name{
    font-size:18px;
    font-weight:600;
}

.item-price{
    color:#ff6b35;
    font-weight:600;
}

.quantity-controls{
    display:flex;
    align-items:center;
    gap:14px;
}

.quantity-controls button{
    width:36px;
    height:36px;
    border-radius:50%;
    border:none;
    background:#ff6b35;
    color:#fff;
    font-size:20px;
    cursor:pointer;
    transition:0.3s;
}

.quantity-controls button:hover{
    background:#e85a24;
}

.quantity-controls span{
    font-weight:600;
    font-size:16px;
}

.total-price{
    font-weight:600;
    font-size:18px;
    text-align:right;
}

.remove-btn{
    background:#e63946;
    border:none;
    color:#fff;
    padding:8px 14px;
    border-radius:10px;
    cursor:pointer;
    transition:0.3s;
}

.remove-btn:hover{
    background:#c62828;
}

.cart-summary{
    text-align:right;
    font-size:24px;
    font-weight:700;
    margin-top:30px;
}

.actions{
    display:flex;
    justify-content:flex-end;
    gap:20px;
    margin-top:30px;
}

.actions button{
    padding:14px 24px;
    font-size:16px;
    font-weight:600;
    border:none;
    border-radius:14px;
    cursor:pointer;
    transition:0.3s;
}

.add-btn{
    background:#ffb703;
    color:#fff;
}

.add-btn:hover{
    background:#f4a100;
}

.checkout-btn{
    background:#06d6a0;
    color:#fff;
}

.checkout-btn:hover{
    background:#05b38a;
}

.empty-cart{
    text-align:center;
    font-size:22px;
    color:#555;
    padding:60px 0;
}
</style>
</head>

<body>

<div class="cart-wrapper">
<h2>🛒 Your Cart</h2>

<%
if(items.isEmpty()){
%>
    <div class="empty-cart">Your cart is empty 😔</div>
<%
}else{
for(CartItem item : items.values()){
%>

<div class="cart-item">
    <div>
        <div class="item-name"><%= item.getName() %></div>
        <div class="item-price">₹ <%= item.getPrice() %></div>
    </div>

    <div class="quantity-controls">
        <form action="CartServlet" method="post">
            <input type="hidden" name="menuId" value="<%= item.getId() %>">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
            <button type="submit" <%= (item.getQuantity() == 1) ? "disabled" : "" %>>−</button>
        </form>

        <span><%= item.getQuantity() %></span>

        <form action="CartServlet" method="post">
            <input type="hidden" name="menuId" value="<%= item.getId() %>">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
            <button type="submit">+</button>
        </form>
    </div>

    <div class="total-price">₹ <%= item.getTotal() %></div>

    <form action="CartServlet" method="post">
        <input type="hidden" name="menuId" value="<%= item.getId() %>">
        <input type="hidden" name="action" value="remove">
        <button class="remove-btn">Remove</button>
    </form>
</div>

<%
}
%>

<div class="cart-summary">
    Total: ₹ <%= cart.getTotal() %>
</div>

<div class="actions">
    <button class="add-btn" onclick="history.back()">+ Add More Items</button>

    <form action="CheckoutServlet" method="get">
        <button class="checkout-btn">✔ Checkout</button>
    </form>
</div>

<%
}
%>

</div>
</body>
</html>
