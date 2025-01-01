<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4; /* Light background for better readability */
        }
        
        /* Header Styling */
        #header {
            background-color: #333;
            color: #fff;
            padding: 15px 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        /* Navigation Bar */
        nav {
            background-color: #222;
            color: white;
            display: flex;
            justify-content: center;
            padding: 10px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
        }
        
        nav a:hover {
            color: #f39c12; /* Highlight effect for navigation links */
        }
        
        /* Main Content */
        main {
            padding: 20px;
            background-color: #fff; /* White background for the main content area */
            min-height: calc(100vh - 100px); /* Adjust content area height */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        /* Responsive Styling */
        @media (max-width: 768px) {
            nav a {
                display: block;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>

    <div id="header">
        SAKTHI STORES
    </div>

    <nav class="sidebar" id="sidebar">
        <a href="viewProducts.jsp" target="contentFrame">View all Products</a>
        <a href="topSale.jsp" target="contentFrame">Top Selling Products</a>
        <a href="offers.jsp" target="contentFrame">Offers + Discounts</a>
        <a href="cart.jsp" target="contentFrame">Cart</a>
        <a href="bill.jsp" target="contentFrame">Generate Bill</a>
        <a href="pastOrders.jsp" target="contentFrame">Your Orders</a>
    </nav>
    <main id="mainContent">
        <iframe name="contentFrame" src="viewProducts.jsp"></iframe> <!-- Set default page -->
    </main>

    
</body>
</html>

