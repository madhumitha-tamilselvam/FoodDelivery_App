<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Foodie - Home</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    box-sizing:border-box;
}

body{
    margin:0;
    font-family:'Poppins',sans-serif;
    background:#f9fafb;
    color:#333;
}

/* ===== NAVBAR ===== */
.navbar{
    background:rgba(255,255,255,0.95);
    padding:18px 60px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
    position:sticky;
    top:0;
    z-index:100;
}

.navbar h2{
    margin:0;
    font-size:30px;
    font-weight:700;
    background:linear-gradient(135deg,#ff6a00,#ff3d00);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
}

.navbar ul{
    list-style:none;
    display:flex;
    gap:35px;
    margin:0;
    padding:0;
}

.navbar ul li{
    position:relative;
    cursor:pointer;
    font-size:16px;
    font-weight:500;
}

.navbar ul li::after{
    content:"";
    position:absolute;
    left:0;
    bottom:-6px;
    width:0;
    height:3px;
    background:#ff6a00;
    transition:0.3s;
    border-radius:5px;
}

.navbar ul li:hover::after{
    width:100%;
}

/* ===== HERO ===== */
.hero{
    height:460px;
    background:
      linear-gradient(rgba(0,0,0,0.55),rgba(0,0,0,0.55)),
      url("https://images.unsplash.com/photo-1600891964599-f61ba0e24092")
      center/cover no-repeat;
    display:flex;
    justify-content:center;
    align-items:center;
    flex-direction:column;
    color:white;
    text-align:center;
}

.hero h1{
    font-size:52px;
    margin-bottom:20px;
    animation:fadeIn 1s ease;
}

.hero input{
    width:520px;
    max-width:90%;
    padding:16px 22px;
    font-size:17px;
    border-radius:14px;
    border:none;
    outline:none;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    transition:0.3s;
}

.hero input:focus{
    transform:scale(1.03);
}

/* ===== SECTION TITLE ===== */
.section-title{
    font-size:34px;
    margin:45px 60px 20px;
    font-weight:600;
}

/* ===== RESTAURANT GRID ===== */
.restaurants{
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
    gap:35px;
    padding:0 60px 60px;
}

/* ===== CARD ===== */
.card{
    background:white;
    border-radius:20px;
    overflow:hidden;
    box-shadow:0 10px 30px rgba(0,0,0,0.12);
    transition:0.35s;
    position:relative;
}

.card:hover{
    transform:translateY(-10px);
    box-shadow:0 20px 45px rgba(0,0,0,0.18);
}

.card img{
    width:100%;
    height:190px;
    object-fit:cover;
    transition:0.4s;
}

.card:hover img{
    transform:scale(1.08);
}

.info{
    padding:18px;
}

.info h3{
    margin:0;
    font-size:20px;
    font-weight:600;
}

.info p{
    margin:8px 0 0;
    color:#777;
    font-size:14px;
}

/* ===== ANIMATION ===== */
@keyframes fadeIn{
    from{opacity:0;transform:translateY(20px);}
    to{opacity:1;transform:translateY(0);}
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px){
    .navbar{padding:15px 25px;}
    .section-title{margin:30px 25px;}
    .restaurants{padding:0 25px 40px;}
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>Foodie</h2>
    <ul>
        <li>Home</li>
        <li>Offers</li>
        <li>Login</li>
        <li>Cart</li>
    </ul>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Delicious Food Delivered Fast 🍽️</h1>
    <input type="text" placeholder="Search for restaurants, dishes...">
</div>

<!-- RESTAURANTS -->
<h2 class="section-title">Top Restaurants Near You</h2>

<div class="restaurants">
<%
    List<Restaurant> list = (List<Restaurant>) request.getAttribute("restaurants");
    if (list != null) {
        for (Restaurant r : list) {
%>

<a href="MenuServlet?restaurantId=<%= r.getRestaurantId() %>" style="text-decoration:none;color:inherit;">
    <div class="card">
        <img src="images/<%= r.getImagePath() %>" alt="Restaurant Image">
        <div class="info">
            <h3><%= r.getName() %></h3>
            <p>⏱ <%= r.getEta() %> mins • ₹200 for one</p>
        </div>
    </div>
</a>

<%
        }
    } else {
%>
<p style="margin-left:60px;">No restaurants found.</p>
<%
    }
%>
</div>

</body>
</html>
