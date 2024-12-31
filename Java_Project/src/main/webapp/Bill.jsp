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
     /* Consistent carrot orange heading color */
}
    

.bill-header {
    text-align: center;
    margin-bottom: 20px;
    color:black;
}
.bill-header h2{
	font-weight:bold;
}
.bill-info {
    margin-bottom: 20px;
}

table {
    width: 100%; /* Full width */
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

.table-container {
    max-width: 600px;
    margin: 0 auto;
    border: 1px solid #ddd;
    padding: 15px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.bill-total {
    font-weight: bold;
    text-align: right;
}
    p{
    text-align:center;}
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
    <h2 style="text-align: center;margin-top:19px; color: #f76d57;">Your Shopping Cart</h2>

    <div class="table-container">
        <div class="bill-info">
        
    <div class="bill-header">
        <h2>SAKTHI STORES</h2>
        <p>6th Main Road, Nanganallur, Chennai - 600061</p>
        <p>Phone: 9360430227</p>
        <hr>
    </div>
            <h3>Bill Details</h3>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                String mobile = (String) session.getAttribute("mobile_num");

Timestamp s=(Timestamp) session.getAttribute("dateTime");
System.out.println(s);
                try {
                	    conn = DbConnection.getConnected(); // Assuming DbConnection is your class to get DB connection
                	   /* String query = "SELECT o.id, o.mobile_no, o.total_amount, o.datetime, " +
                	                   "p.payment_mode, p.status, p.amount, i.product_name, i.quantity, i.price " +
                	                   "FROM orders o " +
                	                   "JOIN payments p ON o.id = p.orderid " +
                	                   "JOIN order_items i ON o.id = i.order_id " +
                	                   "WHERE o.mobile_no = ? AND p.time = ? AND p.status = 'Completed'";
*/
String query = "SELECT o.id, o.mobile_no, o.total_amount, o.datetime, p.payment_mode, p.status, p.amount, i.product_name, i.quantity, i.price FROM orders o JOIN payments p ON o.id = p.orderid JOIN order_items i ON o.id = i.order_id WHERE o.mobile_no = ? AND p.status = 'Completed' and p.time=?"; 

        
        
                	    stmt = conn.prepareStatement(query);
                	    stmt.setString(1, mobile);
                	    stmt.setTimestamp(2,s);
                	    rs = stmt.executeQuery();

                	    if (rs.next()) {
                	        out.println("<p>Payment Status:" + rs.getString("status")+"</p>");
                	        int orderId = rs.getInt("id");
            	            out.println("   <h4>" + orderId + "</h4>");
                	        out.println("<table>");
                	        out.println("  <tr>");
                	        out.println("      <th>Product Name</th>");
                	        out.println("      <th>Quantity</th>");
                	        out.println("      <th>Price</th>");
                	        out.println("      <th>Total Amount</th>");
                	        out.println("  </tr>");

                	        double grandTotal = 0;
                	        do {
                	           
                	            String productName = rs.getString("product_name");
                	            int quantity = rs.getInt("quantity");
                	            double price = rs.getDouble("price");
                	            double totalAmount = rs.getDouble("total_amount");
                	            grandTotal += totalAmount;

                	            out.println("  <tr>");
                	            out.println("      <td>" + productName + "</td>");
                	            out.println("      <td>" + quantity + "</td>");
                	            out.println("      <td>" + price + "</td>");
                	            out.println("      <td>" + totalAmount + "</td>");
                	            out.println("  </tr>");
                	        } while (rs.next());

                	        out.println("  <tr>");
                	        out.println("      <td colspan=\"4\" class=\"bill-total\">Grand Total:</td>");
                	        out.println("      <td>" + grandTotal + "</td>");
                	        out.println("  </tr>");
                	        out.println("</table>");
                	    } else {
                	        out.println("<p>No orders found for the provided details.</p>");
                	    }
                	} catch (Exception e) {
                	    e.printStackTrace();
                	} finally {
                	    try {
                	        if (rs != null) rs.close();
                	        if (stmt != null) stmt.close();
                	        if (conn != null) conn.close();
                	    } catch (SQLException ex) {
                	        ex.printStackTrace();
                	    }
                	}

                  /*  conn = DbConnection.getConnected(); // Assuming DbConnection is your class to get DB connection
                    String query = "SELECT o.id, o.mobile_no, o.total_amount, o.datetime, " +
                                   "p.payment_mode, p.status, p.amount, i.product_name, i.quantity, i.price " +
                                   "FROM orders o " +
                                   "JOIN payments p ON o.id = p.orderid " +
                                   "JOIN order_items i ON o.id = i.order_id " +
                                   "WHERE o.mobile_no = ? and p.time=? and p.status='Completed' "; // Assumes a specific customer's order
					
                    stmt = conn.prepareStatement(query);
                    stmt.setString(1,mobile);
                    stmt.setTimestamp(2,s);
                    rs = stmt.executeQuery();
                    out.println("<p>Payment Status:</p>"+ rs.getString("status"));
                    out.println("<table>");
                    out.println("  <tr>");
                    out.println("      <th>Order ID</th>");
                    out.println("      <th>Product Name</th>");
                    out.println("      <th>Quantity</th>");
                    out.println("      <th>Price</th>");
                    out.println("      <th>Total Amount</th>");
                    out.println("  </tr>");

                    double grandTotal = 0;
                    while (rs.next()) {
                        int orderId = rs.getInt("id");
                        String productName = rs.getString("product_name");
                        int quantity = rs.getInt("quantity");
                        double price = rs.getDouble("price");
                        double totalAmount = rs.getDouble("total_amount");
                        grandTotal += totalAmount;

                        out.println("  <tr>");
                        out.println("      <td>" + orderId + "</td>");
                        out.println("      <td>" + productName + "</td>");
                        out.println("      <td>" + quantity + "</td>");
                        out.println("      <td>" + price + "</td>");
                        out.println("      <td>" + totalAmount + "</td>");
                        out.println("  </tr>");
                    }
                    rs.close();
                    stmt.close();
                    conn.close();

                    out.println("  <tr>");
                    out.println("      <td colspan=\"4\" class=\"bill-total\">Grand Total:</td>");
                    out.println("      <td>" + grandTotal + "</td>");
                    out.println("  </tr>");
                    out.println("</table>");

                } catch (Exception e) {
                    e.printStackTrace();
                }*/
            %>
            <p>Thank you, visit us again!</p>
        </div>
    </div>
    <button id="downloadBill">Download Bill</button></body>
<script>
    document.getElementById("downloadBill").addEventListener("click", () => {
        const { jsPDF } = window.jspdf;

        if (!jsPDF) {
            console.error("jsPDF library not loaded.");
            return;
        }

        const billContent = document.querySelector(".table-container");

        // Use html2canvas to capture the content
        html2canvas(billContent).then((canvas) => {
            const imgData = canvas.toDataURL("image/png");
            const pdf = new jsPDF();

            // Add the image to the PDF
            const imgWidth = 190; // PDF width in mm
            const imgHeight = (canvas.height * imgWidth) / canvas.width; // Maintain aspect ratio

            pdf.addImage(imgData, "PNG", 10, 10, imgWidth, imgHeight);
            pdf.save("Bill.pdf");
        }).catch((error) => {
            console.error("Error generating PDF:", error);
        });
    });
</script>
    

</html>
