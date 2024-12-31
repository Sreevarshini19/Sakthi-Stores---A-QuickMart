<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success Message</title>
<style>
 * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family:Georgia, serif;
    background-color: #faf3e0; /* Soft cream background */
    color: #333;
    line-height: 1.6;
}

/* Header Styling */
header {
 /*background: rgba(255, 255, 255, 0.8); /* Full-length header background with slight transparency */
           
            color: White;
   background-color:#e67e22;
    padding: 15px;
    text-align: center;
    font-size: 28px;
    font-weight: bold;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0; /* Keeps header fixed at the top */
    z-index: 1000;
}

nav {
/*background:#CC6600;*/
background:#C35817;
  /*  background-color: #f57c00; /* Rich pumpkin orange */
    display: flex;
    
    justify-content: center;
    padding: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0; /* Keeps navigation fixed at the top */
    z-index: 999;
}

nav a {
    color:white ; /* White text for navigation links */
    text-decoration: none;
    margin: 0 15px;
    padding: 10px 15px;
    font-size: 16px;
    transition: background-color 0.3s, color 0.3s;
	font-weight:bold;
}

nav a:hover {
    background-color: #f39c12; /* Fire orange hover effect */
    color: #fff;
    border-radius: 5px;
    
}

main {
    max-width: 700px;
    margin: 30px auto;
    background-color: #fff; /* White background for the main content area */
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
}

h3 {
    text-align: center;
    margin-top: 20px;
    color: #C35817; /* Consistent carrot orange heading color */
    
}
</style>
</head>

<body>

<header id="header">
    SAKTHI STORES
</header>

<nav class="sidebar" id="sidebar">
    <a href="viewProductsCust.jsp" target="contentFrame">View all Products</a>
    <a href="topSale.jsp" target="contentFrame">Top Selling Products</a>
    <a href="offers.jsp" target="contentFrame">Offers + Discounts</a>
    <a href="cart.jsp" target="contentFrame">Cart</a>
    <a href="Bill.jsp" target="contentFrame">Bill</a>
    <a href="PrevOrders.jsp" target="contentFrame">Your Orders</a>
</nav>
<% 
String message =(String)request.getAttribute("message");
%>
<h3><%= message %></h3>	
</body>
</html>