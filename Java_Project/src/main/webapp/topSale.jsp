<%@page import="com.varshini.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.varshini.CartItem" %>
<%
    session = request.getSession();
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
    String successMessage = (String) session.getAttribute("successMessage");
    Integer totalProducts = (Integer) session.getAttribute("totalProducts");
    if (totalProducts == null) {
        totalProducts = 0;
    }
    session.removeAttribute("successMessage");

%>
<!DOCTYPE html>
<html>
<head>
    <title>Top Sale</title>
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
    max-width: 1000px;
    margin: 20px auto;
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
    width: 100%; /* Increased width of the table */
    border-collapse: collapse;
    margin: auto;
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
    
.actions-form {
    display: flex;
    align-items: center;
    justify-content: center;
}

.actions-form input[type="number"] {
    width: 50px;
    text-align: center;
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 3px;
    font-size: 14px;
    margin: 0 5px;
}

.actions-form button {
    margin: 0 5px;
    padding: 5px 10px;
    border: none;
    background-color: #3498db; /* Primary button color */
    color: white;
    cursor: pointer;
    border-radius: 5px;
    transition: background-color 0.3s ease-in-out;
}

.actions-form button:hover {
    background-color: #2980b9; /* Darker button on hover */
}

.actions-form button[type="submit"] {
    background-color: #27ae60; /* Green color for Buy button */
    color: white;
}

.actions-form button[type="submit"]:hover {
    background-color: #2ecc71; /* Hover effect for Buy button */
}

.actions-form button[type="button"].decrease {
    background-color: #e74c3c; /* Red color for decrease button */
    color: white;
}

.actions-form button[type="button"].decrease:hover {
    background-color: #c0392b; /* Hover effect for decrease button */
}

.actions-form button[type="button"].increase {
    background-color: #3498db; /* Blue color for increase button */
    color: white;
}

.actions-form button[type="button"].increase:hover {
    background-color: #2980b9; /* Hover effect for increase button */
}
    
        .success-message {
            color: green;
            margin-bottom: 10px;
            font-weight:bold;
            text-align:center;
            font-size:large;
            margin:12px;
        }
        .cart-summary {
            margin-top: 20px;
            font-weight: bold;
        }
      

button{
border:none;
padding:4px 8px;
border-radius:5px;
cursor:pointer;
transition: background-color 0.3s ease-in-out;
color:white;
}

/* Decrease Button */
button.decrease {
    background-color: red; /* Red background for decrease button */
    
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
    background-color: red; /* Orange background for remove button */
    padding:7px;
}

button.remove:hover {
    background-color: #d35400; /* Darker orange on hover */
}
button.add{
	background-color:green;
	padding:7px;
}
input{
padding:4px;
margin:2px;
}
h2{
margin-top:16px;
}
 #header{
	display:flex;
	flex-direction:row;
	justify-content:space-between;
	}

#header img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-left:5px;
        }
    
    a{
text-decoration:none;
color:white;
font-size:20px;
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
    <a href="viewProductsCust.jsp" target="contentFrame">View all Products</a>
    <a href="topSale.jsp" target="contentFrame">Top Selling Products</a>
    <a href="feedback.jsp" target="contentFrame">Feedback</a>
    <a href="cart.jsp" target="contentFrame">Cart</a>
    <a href="Bill.jsp" target="contentFrame">Bill</a>
    <a href="PrevOrders.jsp" target="contentFrame">Your Orders</a>
</nav>
<main>
<% if (successMessage != null) { %>
    <p class="success-message"><%= successMessage %></p>
<% } %>
<%
	try{
		session=request.getSession();
		request.setAttribute("current","topSale");
		Connection conn=DbConnection.getConnected();
	
			String query = "SELECT cname from category";

		Statement st=conn.createStatement();
		ResultSet rs=st.executeQuery(query);
		while(rs.next()){
			 String categoryName = rs.getString("cname");
			 System.out.println(categoryName);
		      %>
		                  <h2><%= categoryName %></h2>
		                  <table>
		                      <tr><th>Product Name</th><th>Type</th><th>Price</th><th>Available</th><th>Arrived On</th><th>Actions</th></tr>
		                      <%
		                          String queryProducts = "SELECT p.product_name, p.price, p.available, p.kind, p.buy_date, SUM(oi.quantity) AS total_sold "+
		                        		  "FROM products p"+
		                        		  " JOIN order_items oi ON p.product_name = oi.product_name"+
		                        		  " WHERE p.category = ?"+
		                        		  " GROUP BY p.id, p.product_name, p.price, p.available, p.kind, p.buy_date"+
		                        		  " ORDER BY total_sold DESC FETCH FIRST 5 ROWS ONLY";
		                          PreparedStatement pst = conn.prepareStatement(queryProducts);
		                          pst.setString(1, categoryName);
		                          ResultSet productRs = pst.executeQuery();
				System.out.println(productRs);
		                          while (productRs.next()) {
		                              String productName = productRs.getString("product_name");
		                              float price = productRs.getFloat("price");
		                              int available = productRs.getInt("available");
		                              String kind = productRs.getString("kind");
		                              Date buy = productRs.getDate("buy_date");
		                              if (cart != null && cart.containsKey(productName)) {
		                                  CartItem item = cart.get(productName);
		                                  available -= item.getQuantity();
		                              }
		                      %>
		                          <form action="BuyProduct" method="POST">
		                              <tr>
		                                  <td><%= productName %></td>
		                                  <td><%= kind %></td>
		                                  <td><%= price %></td>
		                                  <td><%= available %></td>
		                                  <td><%= buy %></td>
		                                  <td>
		                                      <input type="hidden" name="product_name" value="<%= productName %>">
		                                      <input type="hidden" name="price" value="<%= price %>">
		                                       <button type="button" class="decrease">-</button>
		                                      <input type="number" name="quantity" min="1" max="<%= available %>" value="1">
		                                      <button type="button" class="increase">+</button>
		                                      <button type="submit" name="action" value="Add" class="add">Add</button>
		                                      <button type="submit" name="action" value="Remove" class="remove">Remove</button>
		                                  </td>
		                              </tr>
		                          </form>
		                      <% } %>
		                  </table>
		      <%
			
		}
	}
catch(Exception e){
	System.out.println(e.getMessage());
}
%>
</main>
</body>

<script>
    // JavaScript to handle increase and decrease buttons
    document.querySelectorAll('.increase').forEach(button => {
        button.addEventListener('click', function() {
            const input = this.previousElementSibling;
            let currentValue = parseInt(input.value);
            const maxValue = parseInt(input.max);
			
            if (currentValue < maxValue) {
                input.value = currentValue + 1;
                price.value=price.value*input.value;
            }
        });
    });

    document.querySelectorAll('.decrease').forEach(button => {
        button.addEventListener('click', function() {
        	const price=this.closest('tr').querySelector('.price');
            const input = this.nextElementSibling;
            let currentValue = parseInt(input.value);

            if (currentValue > 1) {
                input.value = currentValue - 1;
            }
        });
    });
</script>
</html>