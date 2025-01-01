<%@page import="com.varshini.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback</title>
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
            max-width: 800px;
            margin: 30px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #e67e22;
            margin-bottom: 20px;
        }

        form {
            margin-top: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
             background-color:white;
        }

        button {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #2ecc71;
        }

        .feedback-container {
            margin-top: 30px;
            border-top: 2px solid #ddd;
            padding-top: 20px;
        }

        .feedback-item {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .feedback-item h3 {
            color: #3498db;
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
        <h1>Feedback Form</h1>

        <!-- Feedback Form -->
        <form action="feedback.jsp" method="post">
            <label for="name">Your Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="rating">Rating (1-5):</label>
            <select id="rating" name="rating" required>
                <option value="" disabled selected>Select Rating</option>
                <option value="1">1 - Poor</option>
                <option value="2">2 - Fair</option>
                <option value="3">3 - Good</option>
                <option value="4">4 - Very Good</option>
                <option value="5">5 - Excellent</option>
            </select>

            <label for="review">Your Review:</label>
            <textarea id="review" name="review" rows="4" required></textarea>

            <button type="submit">Submit Feedback</button>
        </form>

        <div class="feedback-container">
            <h2>Previous Feedbacks</h2>
            <% 
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DbConnection.getConnected();
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String name = request.getParameter("name");
                        String rating = request.getParameter("rating");
                        String review = request.getParameter("review");

                        String insertQuery = "INSERT INTO feedback (name, rating, review) VALUES (?, ?, ?)";
                        ps = con.prepareStatement(insertQuery);
                        ps.setString(1, name);
                        ps.setInt(2, Integer.parseInt(rating));
                        ps.setString(3, review);
                        ps.executeUpdate();
                    }

                    String selectQuery = "SELECT * FROM feedback ORDER BY id DESC";
                    ps = con.prepareStatement(selectQuery);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String userName = rs.getString("name");
                        int userRating = rs.getInt("rating");
                        String userReview = rs.getString("review");
            %>
            <div class="feedback-item">
                <h3><%= userName %></h3>
                <p><strong>Rating:</strong> <%= userRating %>/5</p>
                <p><%= userReview %></p>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (ps != null) try { ps.close(); } catch (SQLException e) {}
                    if (con != null) try { con.close(); } catch (SQLException e) {}
                }
            %>
        </div>
    </main>
</body>
</html>
