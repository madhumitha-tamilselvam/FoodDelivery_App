<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Integer orderId = (Integer) session.getAttribute("orderId");
    if (orderId == null) {
        response.sendRedirect("HomeServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Order Confirmed</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
    box-sizing:border-box;
}

body{
    font-family:'Poppins',sans-serif;
    margin:0;
    min-height:100vh;
    background:
      linear-gradient(135deg,
        rgba(72,239,174,0.95),
        rgba(6,214,160,0.95),
        rgba(0,200,150,0.95)
      ),
      url("https://images.unsplash.com/photo-1504674900247-0877df9cc836")
      center/cover no-repeat;

    display:flex;
    justify-content:center;
    align-items:center;
    padding:40px;
}

.box{
    background:rgba(255,255,255,0.96);
    padding:45px;
    width:90%;
    max-width:520px;
    border-radius:30px;
    text-align:center;
    box-shadow:0 30px 70px rgba(0,0,0,0.3);
    animation:pop 0.6s ease-out;
}

@keyframes pop{
    0%{transform:scale(0.8);opacity:0;}
    100%{transform:scale(1);opacity:1;}
}

.success-icon{
    width:90px;
    height:90px;
    border-radius:50%;
    background:linear-gradient(135deg,#06d6a0,#00b894);
    display:flex;
    justify-content:center;
    align-items:center;
    margin:0 auto 20px;
    box-shadow:0 0 30px rgba(6,214,160,0.6);
}

.success-icon::after{
    content:"✔";
    color:white;
    font-size:42px;
    font-weight:700;
}

h1{
    color:#06d6a0;
    font-size:32px;
    margin-bottom:10px;
}

.order-id{
    background:#f1fff9;
    display:inline-block;
    padding:10px 18px;
    border-radius:14px;
    margin:15px 0;
    font-weight:600;
}

p{
    color:#444;
    font-size:16px;
    margin:10px 0;
}

.btn{
    display:inline-block;
    margin-top:25px;
    background:linear-gradient(135deg,#06d6a0,#05b38a);
    padding:14px 34px;
    color:white;
    border-radius:18px;
    text-decoration:none;
    font-weight:600;
    font-size:16px;
    transition:0.3s;
}

.btn:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 30px rgba(6,214,160,0.45);
}
</style>
</head>

<body>

<div class="box">

    <div class="success-icon"></div>

    <h1>Order Confirmed!</h1>

    <div class="order-id">
        🧾 Order ID: <b><%= orderId %></b>
    </div>

    <p>Thank you for ordering with us ❤️</p>
    <p>Your delicious food is being prepared 🍽️</p>

    <a href="home" class="btn">🏠 Back to Home</a>

</div>

</body>
</html>
