<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Menu</title>

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
      linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
      url("https://images.unsplash.com/photo-1499028344343-cd173ffc68a9") center/cover no-repeat;
    padding-bottom:100px;
}

h2{
    text-align:center;
    color:#fff;
    font-size:36px;
    margin:30px 0;
    letter-spacing:1px;
}

.menu-container{
    width:92%;
    max-width:1200px;
    margin:0 auto;
    display:grid;
    grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
    gap:26px;
}

.menu-card{
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(8px);
    padding:16px;
    border-radius:22px;
    box-shadow:0 20px 40px rgba(0,0,0,0.25);
    transition:0.35s;
}

.menu-card:hover{
    transform:translateY(-8px) scale(1.02);
}

.menu-card img{
    width:100%;
    height:170px;
    border-radius:16px;
    object-fit:cover;
}

.menu-title{
    font-size:20px;
    font-weight:600;
    margin:12px 0 6px;
}

.menu-desc{
    font-size:14px;
    color:#555;
    min-height:40px;
}

.menu-price{
    font-size:20px;
    font-weight:700;
    color:#ff6b35;
    margin-top:10px;
}

.btn-add{
    margin-top:14px;
    padding:12px;
    background:linear-gradient(135deg,#ff7a18,#ff3d00);
    color:white;
    border-radius:14px;
    text-align:center;
    cursor:pointer;
    font-weight:600;
    transition:0.3s;
}

.btn-add:hover{
    transform:scale(1.05);
    box-shadow:0 10px 20px rgba(255,61,0,0.4);
}

.quantity-box{
    margin-top:14px;
    display:flex;
    justify-content:center;
    align-items:center;
    gap:16px;
    font-size:18px;
    font-weight:600;
}

.qty-btn{
    width:38px;
    height:38px;
    border-radius:50%;
    border:none;
    background:#ff6b35;
    color:white;
    font-size:22px;
    cursor:pointer;
    transition:0.3s;
}

.qty-btn:hover{
    background:#e85a24;
}

/* Proceed Button */
.proceed-container{
    position:fixed;
    bottom:0;
    left:0;
    width:100%;
    background:rgba(255,255,255,0.95);
    backdrop-filter:blur(10px);
    padding:16px;
    box-shadow:0 -8px 25px rgba(0,0,0,0.3);
    display:flex;
    justify-content:center;
}

.proceed-btn{
    width:280px;
    padding:14px;
    background:linear-gradient(135deg,#06d6a0,#05b38a);
    color:white;
    font-size:18px;
    font-weight:700;
    border-radius:18px;
    border:none;
    cursor:pointer;
    transition:0.3s;
}

.proceed-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 12px 25px rgba(6,214,160,0.45);
}
</style>

<script>
    let cart = {};

    function addToCart(menuId){
        cart[menuId] = 1;
        document.getElementById("add-btn-" + menuId).style.display="none";
        document.getElementById("qty-box-" + menuId).style.display="flex";
    }

    function increase(menuId){
        cart[menuId]++;
        document.getElementById("qty-" + menuId).innerText=cart[menuId];
    }

    function decrease(menuId){
        if(cart[menuId] > 1){
            cart[menuId]--;
            document.getElementById("qty-" + menuId).innerText=cart[menuId];
        }else{
            delete cart[menuId];
            document.getElementById("add-btn-" + menuId).style.display="block";
            document.getElementById("qty-box-" + menuId).style.display="none";
        }
    }

    function proceedToCart(){
        const form=document.createElement("form");
        form.method="post";
        form.action="CartServlet";

        let index=0;
        for(let id in cart){
            let idInput=document.createElement("input");
            idInput.type="hidden";
            idInput.name="menuId"+index;
            idInput.value=id;

            let qtyInput=document.createElement("input");
            qtyInput.type="hidden";
            qtyInput.name="quantity"+index;
            qtyInput.value=cart[id];

            form.appendChild(idInput);
            form.appendChild(qtyInput);
            index++;
        }

        let sizeInput=document.createElement("input");
        sizeInput.type="hidden";
        sizeInput.name="size";
        sizeInput.value=index;

        let action=document.createElement("input");
        action.type="hidden";
        action.name="action";
        action.value="bulkAdd";

        form.appendChild(sizeInput);
        form.appendChild(action);
        document.body.appendChild(form);
        form.submit();
    }
</script>
</head>

<body>

<h2>🍽️ Explore Our Menu</h2>

<div class="menu-container">
<%
List<Menu> menuList=(List<Menu>)request.getAttribute("menuList");
if(menuList!=null){
for(Menu m:menuList){
%>

<div class="menu-card">
    <img src="<%= m.getImagePath() %>">
    <div class="menu-title"><%= m.getItemName() %></div>
    <div class="menu-desc"><%= m.getDescription() %></div>
    <div class="menu-price">₹ <%= m.getPrice() %></div>

    <div id="add-btn-<%= m.getMenuId() %>" class="btn-add"
         onclick="addToCart(<%= m.getMenuId() %>)">
        Add to Cart
    </div>

    <div id="qty-box-<%= m.getMenuId() %>" class="quantity-box" style="display:none;">
        <button class="qty-btn" onclick="decrease(<%= m.getMenuId() %>)">−</button>
        <span id="qty-<%= m.getMenuId() %>">1</span>
        <button class="qty-btn" onclick="increase(<%= m.getMenuId() %>)">+</button>
    </div>
</div>

<%
}
}
%>
</div>

<div class="proceed-container">
    <button class="proceed-btn" onclick="proceedToCart()">Proceed to Cart</button>
</div>

</body>
</html>
