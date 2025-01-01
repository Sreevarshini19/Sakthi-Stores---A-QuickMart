<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.varshini.DbConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cash Payments</title>
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
     .container{
     margin-top:20px;
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
    <div class="container">
        <h2>Pending Payments by Cash</h2>
        <table class="payments-table">
            <thead>
                <tr>
                                    
                    <th>Payment ID</th>
                    <th>Order ID</th>
                    <th>Time</th>
                    <th>Payment Mode</th>
                    <th>Status</th>
                    <th>Mobile Number</th>
                    <th>Amount</th>
                    <th>Payment</th>
                </tr>
            </thead>
          <tbody>
    <% 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Database connection setup
            conn = DbConnection.getConnected();
            String sql = "SELECT * FROM payments WHERE payment_mode=? AND status=?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,"Cash");
            pstmt.setString(2,"Pending");
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                String status = rs.getString("status");
                String buttonText = "Paid";
                String buttonStyle = "background-color: green; color: white;"; // Default for 'Paid'
                if (status.equalsIgnoreCase("Pending")) {
                    buttonText = "Pay?";
                    buttonStyle = "background-color: red; color: white;"; // Red for 'Pay?'
                }
               
    %>
        <tr>
            <td><%= rs.getInt("PAYMENT_ID") %></td>
            <td><%= rs.getInt("ORDERID") %></td>
            <td><%= rs.getTimestamp("TIME") %></td>
            <td><%= rs.getString("PAYMENT_MODE") %></td>
            <td><%= rs.getString("STATUS") %></td>
            <td><%= rs.getString("MOBILE_NUM") %></td>
            <td><%= rs.getDouble("AMOUNT") %></td>
            <td>
                <form method="post" action="CashPayment" style="margin: 0;">
                    <input type="hidden" name="orderId" value="<%= rs.getInt("ORDERID") %>" />
                    <button type="submit" style="<%= buttonStyle %>">
                        <%= buttonText %>
                    </button>
                </form>
            </td>
        </tr>
    <% 
            }
        } catch (Exception e) {
            out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>
</tbody>
          
        </table>
    </div>
</body>
</html>
