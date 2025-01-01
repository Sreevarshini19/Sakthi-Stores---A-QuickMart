<%@page import="com.varshini.DbConnection"%>
<%@page import="jakarta.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Products</title>
    <style>
     
     /* General Reset and Box-Sizing */
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




/* Form Styling */
form {
    display: flex;
    flex-direction: column;
    gap: 15px;
    
}

label {
    font-weight: bold;
    margin-bottom: 5px;
    color: #333;
}

input[type="text"],
input[type="number"],
select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: #f9f9f9;
    font-size: 16px;
    transition: border-color 0.3s ease-in-out;
}

input[type="text"]:focus,
input[type="number"]:focus,
select:focus {
    border-color: #1abc9c;
    outline: none;
    background-color: #fff;
}

button {
    background-color: #e67e22;
    color: white;
    border: none;
    padding: 10px 15px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
    transition: background-color 0.3s ease-in-out;
}

button:hover {
    background-color: #FF7F50;
}

/* Messages */
.message {
    text-align: center;
    font-size: 14px;
    margin-bottom: 20px;
}

.message.success {
    color: green;
}

.message.error {
    color: red;
}
#header{
	display:flex;
	flex-direction:row;
	gap:35%;
}

#header img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-left:5px;
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

    form {
        padding: 15px;
        border-radius: 8px;
    }
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

    <nav>
    <a href="addProducts.jsp" target="contentFrame">Add Products</a>
        <a href="addCategory.jsp" target="contentFrame">Add Categories</a>
        <a href="reloadProduct.jsp" target="contentFrame">Reload Products</a>
        <a href="viewProducts.jsp" target="contentFrame">View Stocks</a>
        
        <a href="CashPayments.jsp">Cash Payments</a>
        <a href="notification.jsp" target="contentFrame">Notifications</a>
        <a href="orders.jsp" target="contentFrame">Orders</a>
         <a href="workers.jsp" target="contentFrame">Staffs</a>
    </nav>

    <main>
        <h2>Add Products</h2>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p class="message error"><%= error %></p>
        <% 
            }

            String success = (String) request.getAttribute("success");
            if (success != null) {
        %>
            <p class="message success"><%= success %></p>
        <% 
            } 
        %>

        <form method="post" action="AddProducts">
            <label for="pname">Product Name</label>
            <input type="text" id="pname" name="pname" required placeholder="Enter product name" />

            <label for="pprice">Price</label>
            <input type="number" id="pprice" name="pprice" required placeholder="Enter product price" />

            <label for="quantity">Quantity</label>
            <input type="number" id="quantity" name="quantity" required placeholder="Enter product quantity" />
			
			<label for="type">Type</label>
            <input type="text" id="type" name="type" required placeholder="Enter product type(eg soap,juice..)" />
			
            
            <label for="category">Category</label>
            <select id="category" name="category" required>
            
                <option value="" disabled selected>Select a category</option>
                <% 
                    Connection conn = null;
                    Statement st = null;
                    ResultSet rs = null;
                    try {
                        conn = DbConnection.getConnected();
                        String query = "SELECT cname FROM category";
                        st = conn.createStatement();
                        rs = st.executeQuery(query);

                        while (rs.next()) {
                            String categoryName = rs.getString("cname");
                %>
                            <option value="<%= categoryName %>"><%= categoryName %></option>
                <% 
                        }
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    } finally {
                        if (rs != null) rs.close();
                        if (st != null) st.close();
                        if (conn != null) conn.close();
                    }
                %>
            </select>

            <label for="brand">Brand</label>
            <input type="text" id="brand" name="brand" required placeholder="Enter product brand" />

            <label for="notify">Notification Threshold</label>
            <input type="number" id="notify" name="notify" placeholder="Enter threshold quantity for notification" />

            <button type="submit">Add Product</button>
        </form>
    </main>
</body>
</html>
