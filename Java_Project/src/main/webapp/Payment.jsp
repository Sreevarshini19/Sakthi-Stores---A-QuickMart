<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.varshini.DbConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Process Payment</title>
</head>
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
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #faf3e0;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            margin-left:37%;
        }

        .form-container h2 {
            text-align: center;
            color: #f76d57;
            margin-bottom: 20px;
        }

        .form-container label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-container input:focus {
            border-color: #f39c12;
            outline: none;
        }

        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #f39c12;
            border: none;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .form-container input[type="submit"] {
            background-color: #e67e22;
            cursor:pointer;
        }

        .error {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
        }
        input{
        background-color:white;}
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
</style>
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
    <a href="Bill.jsp" target="contentFrame">Generate Bill</a>
    <a href="PrevOrders.jsp" target="contentFrame">Your Orders</a>
</nav>
 <h2 style="text-align: center;margin-top:19px;">Payment Status</h2>
    <div style="text-align: center; margin-top: 20px;">
        <% 
            String paymentMode = request.getParameter("pay");
            Connection conn = null;
            PreparedStatement pstmt = null;
            String mobile =null;
            Float amount=0.0f;
            try {
                // Database connection setup
                conn = DbConnection.getConnected();
                Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
                String sql = "INSERT INTO payments (payment_mode, time, status,mobile_num,amount,orderId) VALUES (?,?,? , ?,?,?)";
				 session=request.getSession();
				
				
				 if ("Cash".equalsIgnoreCase(paymentMode)) {
				        RequestDispatcher rd = request.getRequestDispatcher("Operations.jsp");
				        rd.include(request, response);
				        
				        mobile = (String) session.getAttribute("mobile_num");
				        if (mobile == null) {
				            throw new Exception("Session attribute 'mobile_num' is not set.");
				        }
				        if ( !mobile.matches("\\d{10}")) {
				            throw new Exception("Invalid mobile number. It must be a 10-digit numeric value.");
				        }

				        System.out.println("Mobile Number: " + mobile);
				        session.setAttribute("dateTime",currentTimestamp);
				        amount = ((Float) session.getAttribute("totalAmount")).floatValue();
				        if (amount == null) {
				            throw new Exception("Session attribute 'totalAmount' is not set.");
				        }
				        System.out.println("Total Amount: " + amount);
				        
				        int orderId = ((Integer) session.getAttribute("orderId")).intValue();
				        System.out.println("Generated Order ID: " + orderId);
				        
				        pstmt = conn.prepareStatement(sql);
				        pstmt.setString(1, "Cash");
				        pstmt.setTimestamp(2,currentTimestamp);
				        pstmt.setString(3, "Pending");
				        pstmt.setString(4, mobile);
				        pstmt.setFloat(5, amount);
				        pstmt.setInt(6, orderId);
				        int i=pstmt.executeUpdate();
				        System.out.println("Status"+i);
				        if(session.getAttribute("status").equals("success")){
				        	 out.println("Order placed successfully with Order ID: " + orderId);%>
				        	 <br>
<% 						        out.println("Payment: pending");
				        }
				        else{
				        	out.println("Error placing the order");
				        }
				    } 
				
				 else if ("Card".equalsIgnoreCase(paymentMode)) {
                    String cardNumber = request.getParameter("card_number");
                    
                    if (cardNumber == null) {
        %>
        
        
        
        
        
        
<div class="form-container">
    <h2>Enter Card Details</h2>
    <form id="paymentForm" method="post">
        <label for="card_holder">Card Holder Name:</label>
        <input type="text" id="card_holder" name="card_holder" required>

        <label for="card_number">Card Number:</label>
        <input type="text" id="card_number" name="card_number" maxlength="16" required>

        <label for="expiration_date">Expiration Date:</label>
        <input type="month" id="expiration_date" name="expiration_date" required>

        <label for="cvv">CVV:</label>
        <input type="password" id="cvv" name="cvv" maxlength="3" required>

        <input type="hidden" name="pay" value="Card">
        <div id="error-message" class="error"></div>
  <input type="submit"  value="Pay">
    </form>
</div>
                  
        <% } else {
                        // Process the card payment
                        String cardHolderName = request.getParameter("card_holder");
                        String expirationDate = request.getParameter("expiration_date");
                        String cvv = request.getParameter("cvv");
                        System.out.println("Hellopsis");
                        
                        if (cardHolderName != null && expirationDate != null && cvv != null) {
                            pstmt = conn.prepareStatement(sql);
                            
                            pstmt.setString(1, "Card");
                            RequestDispatcher rd=null;
                            rd=request.getRequestDispatcher("Operations.jsp");
                            rd.include(request,response);
                            System.out.println("Hellopii");
                            mobile= (String) session.getAttribute("mobile_num");
                            if (mobile == null) {
                                throw new Exception("Session attribute 'mobile_num' is not set.");
                            }

                            amount = (Float) session.getAttribute("totalAmount");
                            if (amount == null) {
                                throw new Exception("Session attribute 'totalAmount' is not set.");
                            }
                            Object status = session.getAttribute("status");
                            if (status!=null && "success".equals(status)) {
                               
                                int orderId = ((Integer) session.getAttribute("orderId")).intValue();
				        	System.out.println("Generated Order ID: " + orderId);
                                out.println("Payment Successful");
                                 request.setAttribute("message", "Payment successful\n \"Order placed with order Id\" "+orderId);
                                        rd = request.getRequestDispatcher("success.jsp");
                                        rd.forward(request, response);
                            } else {
                                request.setAttribute("message", "Payment failed");
                                rd = request.getRequestDispatcher("error.jsp");
                                rd.forward(request, response);
                            }
                            pstmt.setTimestamp(2,currentTimestamp);
                             pstmt.setString(3, "Completed");
                             pstmt.setString(4, mobile);
                             pstmt.setFloat(5, amount);
                            
                             int orderId=(int)session.getAttribute("orderId");
                            pstmt.setInt(6, orderId);
                            pstmt.executeUpdate();
                            System.out.println("Order placedd"+orderId);
        					out.println("Order placed successfully with Order ID: " + orderId);
                            
                            // Redirect to bill.jsp after payment processing
                            
                        } else {
                            out.println("<h2>Invalid Card Details</h2>");
                        }
                    }
                } else {
                    out.println("<h2>Invalid Payment Mode</h2>");
                }
            } catch (Exception e) {
            	System.out.println(e.getMessage());
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>
</body>

<script>
function test() {
    // Get form inputs
    const cardNumber = document.getElementById("card_number").value;
    const cardHolder = document.getElementById("card_holder").value;
    const expirationDate = document.getElementById("expiration_date").value;
    const cvv = document.getElementById("cvv").value;

    // Validate card number (should be exactly 16 digits)
    if (!/^\d{16}$/.test(cardNumber)) {
        alert("Card number must be exactly 16 digits.");
        return false;
    }

    // Validate card holder name (must not be empty)
    if (cardHolder.trim() === "") {
        alert("Card holder name cannot be empty.");
        return false;
    }

    // Validate expiration date (must not be empty)
    if (expirationDate === "") {
        alert("Expiration date is required.");
        return false;
    }

    // Validate CVV (should be exactly 3 digits)
    if (!/^\d{3}$/.test(cvv)) {
        alert("CVV must be exactly 3 digits.");
        return false;
    }

    // If all validations pass
    return true;
}
</script>


</html>






