<%@page import="com.varshini.CartItem"%>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Retrieve cart from session
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
        session.setAttribute("cart", cart);
    }

    String successMessage = (String) session.getAttribute("successMessage");
    session.removeAttribute("successMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Shopping Cart</title>
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

h1, h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #f76d57; /* Consistent carrot orange heading color */
}

table {
    width: 80%; /* Increased width of the table */
    border-collapse: collapse;
    margin: 20px 10%;
    background-color: #fff; /* White table background */
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

table th, table td {
    padding: 15px;
    text-align: center;
    border-bottom: 1px solid #ddd; /* Light gray row borders */
}

table th {
   /* background-color: #f57c00; /* Pumpkin orange header color */
   
background:#C35817;
    color: white;
    font-weight: bold;
}

table tr:nth-child(even) {
    background-color: #fff5e4; /* Light papaya orange row background */
}

table tr:hover {
    background-color: #ffcc80; /* Blaze orange hover effect background */
}

table tr td {
    color: #333;
    font-size: 16px;
    font-weight:bold;
}

/* Responsive Design */
@media (max-width: 600px) {
    nav {
        flex-direction: column;
        align-items: center;
    }

    nav a {
        margin: 10px 0;
    }

    main {
        padding: 15px;
    }
}
    

/* Styling Buttons (+, -, Add, Remove) */
button {
    padding: 10px 15px;
    border: none;
    color: white;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
    transition: background-color 0.3s ease-in-out;
    margin: 0 7px;
    outline: none;
    padding:5px;
}

button:hover {
    background-color: #2980b9; /* Darker button color for hover effect */
}

/* Decrease Button */
button.decrease {
    background-color: #e74c3c; /* Red background for decrease button */
    
}

button.decrease:hover {
    background-color: #c0392b; /* Darker red on hover */
}

/* Increase Button */
button.increase {
    background-color: #3498db; /* Blue background for increase button */
}

button.increase:hover {
    background-color: #2980b9; /* Darker blue on hover */
}

/* Remove Button */
button.remove {
    background-color: #e67e22; /* Orange background for remove button */
}

button.remove:hover {
    background-color: #d35400; /* Darker orange on hover */
}
button.remove{
	background-color:green;
	padding:7px;
}
/* Success Message Styling */
.success-message {
    color: green;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
    padding: 10px;
    border: 1px solid green;
    border-radius: 5px;
    background-color: #d4edda; /* Light green background for success messages */
    font-size: 16px;
}

/* Actions Button Styles */
.actions-form {
    display: flex;
    align-items: center;
    justify-content: center;
}


        .success-message {
            color: green;
            margin-bottom: 10px;
        }
        .cart-summary {
            margin-top: 20px;
            font-weight: bold;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .quantity-controls {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .quantity-controls button {
            width: 30px;
            height: 30px;
            margin: 0 5px;
        }
        a{
        	text-decoration:none;
        	
        }
        .pay {
        background-color:#0096FF;
        font-weight:bold;
        padding:9px;
        margin:15px;
        }
         #header{
	display:flex;
	flex-direction:row;
	justify-content:space-between;
}
a{
text-decoration:none;
color:white;
font-size:20px;
}

#header img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-left:5px;
        }
    </style>
</head>
<body>

<header>

<div id="header">
 <img class="img" src="SakthiStores_edit.png" alt="Sakthi Stores Logo"/>
 
    SAKTHI STORES
     <a href="AdminLogin.jsp" >Log Out</a>
    
    </div>
</header>

<nav class="sidebar" id="sidebar">

    <a href="viewProductsCust.jsp">View all Products</a>
    <a href="topSale.jsp">Top Selling Products</a>
    <a href="feedback.jsp">Feedback</a>
    <a href="cart.jsp">Cart</a>
    <a href="Bill.jsp">Generate Bill</a>
    <a href="PrevOrders.jsp">Your Orders</a>
</nav>
    <h2 style="text-align: center;margin-top:19px;">Your Shopping Cart</h2>
<div style="text-align: center; margin-top: 20px;">
        <a href="viewProductsCust.jsp">Continue Shopping</a>
    </div>
    <% if (successMessage != null) { %>
        <p style="color: green; text-align: center;"><%= successMessage %></p>
    <% } %>

    <% if (cart.isEmpty()) { %>
        <p style="text-align: center;">Your cart is empty!</p>
    <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            
                <% float grandTotal = 0; %>
                <% for (Map.Entry<String, CartItem> entry : cart.entrySet()) { %>
                    <% String productName = entry.getKey(); %>
                    <% CartItem item = entry.getValue(); %>
                    <% float itemTotal = item.getPrice() * item.getQuantity(); %>
                    <% grandTotal += itemTotal; %>
                    <tr>
                        <td><%= productName %></td>
                        <td>₹<%= item.getPrice() %></td>
                        <td>
                            <form method="post" action="UpdateCart" class="actions-form">
                                <div class="quantity-controls">
                                    <input type="hidden" name="product_name" value="<%= productName %>">
                                    <button class="decrease" type="submit" name="action" value="Decrease">-</button>
                                    <span><%= item.getQuantity() %></span>
                                    <button class="increase" type="submit" name="action" value="Increase">+</button>
                                </div>
                            </form>
                        </td>
                        <td>₹<%= itemTotal %></td>
                        <td>
                            <form method="post" action="UpdateCart">
                                <input type="hidden" name="product_name" value="<%= productName %>">
                                <button type="submit" name="action" value="Remove" class="remove">Remove</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
                <tr>
                    <td colspan="3" style="text-align: right;"><strong>Grand Total:</strong></td>
                    <td colspan="2">₹<%= grandTotal %></td>
                </tr>
            </tbody>
        </table>
    <% } %>

    <div style="text-align: center; margin-top: 20px;">
    <p>Pay by</p>
     <form action="Payment.jsp" method="post">
        <button class="pay" name="pay" value="Cash">Cash</button>
        <button class="pay" id="cardBtn" name="pay" value="Card">Card</button>
    </form>
       <!-- <a href="Bill.jsp">Generate Bill</a> --> 
    </div>
</body>
<script>
    document.getElementById('cardBtn').addEventListener('click', function() {
        // Redirect to Details.jsp
        window.location.href = 'Payment.jsp';
    });
</script>
</html>
