<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.varshini.DbConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sakthi Stores - Bill</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <style>
        /* Your existing styles */
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
    width: 40%; /* Increased width of the table */
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
        header, nav, main, table {
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .order-details {
            margin-bottom: 30px;
        }
        .products-table {
            margin-top: 15px;
            margin-left: 10%;
            width: 80%;
        }
        .bill-header, .bill-total, .bill-info {
            text-align: center;
        }
        .btn-center {
            display: block;
            margin: 20px auto;
        }
          #downloadBill {
          background-color: #f39c12; /* Fire orange button */
          color: white;
          padding: 10px 20px;
          font-size: 16px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
         margin: 20px;
          display: block;
          margin-left: auto;
          margin-right: auto;
         
      }

      #downloadBill:hover {
          background-color: #e67e22; /* Slightly darker on hover */
      }
      .order-card {
    margin-bottom: 20px;
    padding: 20px;
    background-color: #fff5e4; /* Light orange background */
    border: 1px solid #f3d5b5; /* Slightly darker border */
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.order-header {
    border-bottom: 2px solid #f39c12; /* Fire orange border */
    margin-bottom: 10px;
    padding-bottom: 10px;
}

.order-header h3 {
    margin: 0;
    color: #f76d57; /* Consistent carrot orange heading color */
    font-weight: bold;
}

.highlight {
    color: #f39c12;
    font-weight: bold;
}

.highlight-status {
    color: green;
    font-weight: bold;
}

.order-summary {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    margin-top: 10px;
}

.order-item {
    flex: 1;
    min-width: 120px;
}

.order-item strong {
    display: block;
    margin-bottom: 5px;
    font-size: 14px;
}

.products-table {
    margin-top: 15px;
    width: 70%;
    background-color: #fff;
    border-collapse: collapse;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
    <a href="viewProductsCust.jsp">View all Products</a>
    <a href="topSale.jsp">Top Selling Products</a>
    <a href="feedback.jsp">Feedback</a>
    <a href="cart.jsp">Cart</a>
    <a href="Bill.jsp">Generate Bill</a>
    <a href="PrevOrders.jsp">Your Orders</a>
</nav>

<main>
    <h2 style="text-align: center; margin-top: 19px; color: #f76d57;">Your Orders</h2>

    <div class="table-container">
        <div class="bill-info">
           

            <%
                Connection conn = null;
                PreparedStatement orderStmt = null;
                PreparedStatement itemStmt = null;
                ResultSet orderRs = null;
                ResultSet itemRs = null;

                try {
                    conn = DbConnection.getConnected(); // Assuming DbConnection is your class to get DB connection
                    
                    String orderQuery = "SELECT o.id, o.mobile_no, o.datetime, o.total_amount,p.payment_mode, p.status " +
                                        "FROM orders o " +
                                        "JOIN payments p ON o.id = p.orderid " +
                                        "WHERE o.mobile_no = ?";
                    orderStmt = conn.prepareStatement(orderQuery);
                    String mobile = (String) session.getAttribute("mobile_num");
                    orderStmt.setString(1, mobile);
                    orderRs = orderStmt.executeQuery();
						
                    while (orderRs.next()) {
                        int orderId = orderRs.getInt("id");
                        int totalAmount = orderRs.getInt("total_amount");
                        String paymentMode = orderRs.getString("payment_mode");
                        String paymentStatus = orderRs.getString("status");
                        String orderTime = orderRs.getString("datetime");
%>
                      
                        <div class="order-card">
    <div class="order-header">
        <h3>Order ID: <span class="highlight"><%= orderId %></span></h3>
        <p><strong>Order Time:</strong> <%= orderTime %></p>
    </div>
    <div class="order-summary">
        <div class="order-item">
            <strong>Payment Mode:</strong>
            <span><%= paymentMode %></span>
        </div>
        <div class="order-item">
            <strong>Payment Status:</strong>
            <span class="highlight-status"><%= paymentStatus %></span>
        </div>
        <div class="order-item">
            <strong>Total Amount:</strong>
            <span class="highlight"><%= totalAmount %></span>
        </div>
    </div>

    <table class="products-table">
        <tr>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        
<%
                        String itemQuery = "SELECT i.product_name, i.quantity, i.price " +
                                           "FROM order_items i " +
                                           "WHERE i.order_id = ?";
                        itemStmt = conn.prepareStatement(itemQuery);
                        itemStmt.setInt(1, orderId);
                        itemRs = itemStmt.executeQuery();

                        while (itemRs.next()) {
                            String productName = itemRs.getString("product_name");
                            int quantity = itemRs.getInt("quantity");
                            double price = itemRs.getDouble("price");

                            out.println("<tr>");
                            out.println("<td>" + productName + "</td>");
                            out.println("<td>" + quantity + "</td>");
                            out.println("<td>" + price + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                        out.println("</div>");
                    }

                    if (itemRs != null) itemRs.close();
                    if (itemStmt != null) itemStmt.close();
                    if (orderRs != null) orderRs.close();
                    if (orderStmt != null) orderStmt.close();
                    if (conn != null) conn.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <p>Thank you, visit us again!</p>
        </div>
    </div>
    <button id="downloadBill" class="btn-center">Download Bills</button>
</main>

<script>
    document.getElementById("downloadBill").addEventListener("click", () => {
        const { jsPDF } = window.jspdf;
        const billContent = document.querySelector("main");

        html2canvas(billContent).then((canvas) => {
            const imgData = canvas.toDataURL("image/png");
            const pdf = new jsPDF();
            const imgWidth = 190;
            const imgHeight = (canvas.height * imgWidth) / canvas.width;

            pdf.addImage(imgData, "PNG", 10, 10, imgWidth, imgHeight);
            pdf.save("Bill.pdf");
        });
    });
</script>

</body>
</html>
