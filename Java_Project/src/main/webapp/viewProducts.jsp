<%@page import="com.varshini.DbConnection"%>
<%@page import="jakarta.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
   
    String searchQuery = request.getParameter("search"); // Get search input
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Products</title>
    <style>
    /* General Reset */
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
    width: 100%; /* Increased width of the table */
    border-collapse: collapse;
    margin: 20px 0;
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
    
 
  .search{
background-color:blue;
color:white;
border:none;
border-radius:4px;
cursor:pointer;
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

    form {
        padding: 15px;
        border-radius: 8px;
    }
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
     <a href="addProducts.jsp" target="contentFrame">Add Products</a>
        <a href="addCategory.jsp" target="contentFrame">Add Categories</a>
        <a href="reloadProduct.jsp" target="contentFrame">Reload Products</a>
        <a href="viewProducts.jsp" target="contentFrame">View Stocks</a>
        
        <a href="CashPayments.jsp">Cash Payments</a>
        <a href="notification.jsp" target="contentFrame">Notifications</a>
        <a href="orders.jsp" target="contentFrame">Orders</a>
        <a href="workers.jsp" target="contentFrame">Staffs</a>
</nav>
<!-- Search Form -->
<form method="GET" action="viewProducts.jsp" style="text-align: center; margin: 20px;">
    <input type="text" name="search" placeholder="Search for products or categories" value="<%= searchQuery != null ? searchQuery : "" %>" style="padding: 10px; width: 300px;">
    <button type="submit" style="padding: 10px;" class="search">Search</button>
</form>

<main>
    <%
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            conn = DbConnection.getConnected(); 
            String query;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String lowerSearchQuery = searchQuery.trim().toLowerCase();
//id, product_name, price, available,kind, buy_date, sold
                // Search logic: Match product_name, kind, or category name (case-insensitive)
                query = "SELECT p.id,p.product_name, p.price, p.available, p.kind, p.buy_date,p.sold, c.cname " +
                        "FROM products p " +
                        "JOIN category c ON p.category = c.cname " +
                        "WHERE LOWER(p.product_name) LIKE ? " +
                        "   OR LOWER(p.kind) LIKE ? " +
                        "   OR LOWER(c.cname) LIKE ?";
                st = conn.prepareStatement(query);
                st.setString(1, "%" + lowerSearchQuery + "%");
                st.setString(2, "%" + lowerSearchQuery + "%");
                st.setString(3, "%" + lowerSearchQuery + "%");
                rs = st.executeQuery();

                String currentCategory = "";
                while (rs.next()) {
                	int id = rs.getInt("id");
                    String categoryName = rs.getString("cname");
                    String productName = rs.getString("product_name");
                    float price = rs.getFloat("price");
                    int available = rs.getInt("available");
                    String kind = rs.getString("kind");
                    Date buyDate = rs.getDate("buy_date");
                    int sold = rs.getInt("sold");

                    if (!categoryName.equals(currentCategory)) {
                        currentCategory = categoryName;
        %>
                        <h2><%= categoryName %></h2>
                        <table>
                            <tr>
                            <th>Id</th>
                                <th>Product Name</th>
                                <th>Type</th>
                                <th>Price</th>
                                <th>Available</th>
                                <th>Arrived On</th>
                                <th>Sold</th>
                            </tr>
        <%
                    }
        %>
                            <form action="BuyProduct" method="POST">
                                <tr>
                                <td><%= id %></td>
                                    <td><%= productName %></td>
                                    <td><%= kind %></td>
                                    <td><%= price %></td>
                                    <td><%= available %></td>
                                    <td><%= buyDate %></td>
                                    <td><%= sold %></td>
                                  
                                </tr>
                            </form>
        <%
                }
        %>
                        </table>
        <%
            } 
            else{
            String queryCategories = "SELECT cname FROM category";  
            st = conn.prepareStatement(queryCategories);
            rs = st.executeQuery();
            
            while (rs.next()) {
                String categoryName = rs.getString("cname");
                
                out.println("<h2>" + categoryName + "</h2>");
                out.println("<table>");
                out.println("<tr><th>ID</th><th>Product Name</th><th>Type</th><th>Price</th><th>Available</th><th>Arrived On</th><th>Sold</th></tr>");
                
                String queryProducts = "SELECT id, product_name, price, available,kind, buy_date, sold FROM products WHERE category=?";
                PreparedStatement pst = conn.prepareStatement(queryProducts);
                pst.setString(1, categoryName); // Set category for filtering
                
                ResultSet productRs = pst.executeQuery();
                
                while (productRs.next()) {
                    int id = productRs.getInt("id");
                    String productName = productRs.getString("product_name");
                    float price = productRs.getFloat("price");
                    int available = productRs.getInt("available");
                    String kind = productRs.getString("kind");
                    Date boughtOn = productRs.getDate("buy_date");
                    
                    int sold = productRs.getInt("sold");
                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + productName + "</td>");
                    out.println("<td>" + kind + "</td>");
                    out.println("<td>" + price + "</td>");
                    out.println("<td>" + available + "</td>");
                    out.println("<td>" + boughtOn + "</td>");
                    out.println("<td>" + sold + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }}
        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    %>
</main>
</body>
</html>
