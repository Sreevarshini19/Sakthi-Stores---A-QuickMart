<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="com.varshini.DbConnection" %>
<%@ page import="com.varshini.CartItem" %>
<%
    session = request.getSession();
    Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("viewProductsCust.jsp");
        return;
    }

    String mobileNo = (String) session.getAttribute("mobile_num");
    System.out.println("Mobile Number: " + mobileNo);

    float totalAmount = 0.0f;
    int orderId = 0;
    Connection con = null;
    PreparedStatement orderStmt = null;
    PreparedStatement remFromTotal = null;
    PreparedStatement orderItemStmt = null;
    PreparedStatement addtoSold = null;
    ResultSet rs = null;
    int availableQuantity =0;
    try {
        con = DbConnection.getConnected();

        // Calculate the total amount and validate product availability
        for (CartItem item : cart.values()) {
            String checkAvailable = "SELECT available FROM products WHERE product_name=?";
            orderStmt = con.prepareStatement(checkAvailable);
            orderStmt.setString(1, item.getProductName());
             rs = orderStmt.executeQuery();
             
             if(rs.next()){
             availableQuantity = rs.getInt("available");// This should return updated available quantity
			System.out.println(availableQuantity);
             }
			System.out.println(item.getQuantity());
            if ( availableQuantity- item.getQuantity() < 0) {
                throw new Exception(item.getQuantity() + " " + item.getProductName() + " items are not available.");
            }

            totalAmount += item.getPrice() * item.getQuantity();
            System.out.println("Total Amount: " + totalAmount);
        }
session.setAttribute("totalAmount",totalAmount);
        // Insert into orders table
        String insertOrderQuery = "INSERT INTO orders (mobile_no, total_amount, datetime) VALUES (?, ?, CURRENT_TIMESTAMP)";
        orderStmt = con.prepareStatement(insertOrderQuery);
        orderStmt.setString(1, mobileNo);
        orderStmt.setFloat(2, totalAmount);
        orderStmt.executeUpdate();

        // Retrieve the generated order ID using SELECT query
        String selectOrderIdQuery = "SELECT id FROM orders WHERE mobile_no = ? ORDER BY datetime DESC FETCH FIRST 1 ROW ONLY";
        orderStmt = con.prepareStatement(selectOrderIdQuery);
        orderStmt.setString(1, mobileNo);
        rs = orderStmt.executeQuery();

        if (rs.next()) {
            orderId = rs.getInt("id");
            System.out.println("Generated Order ID: " + orderId);
        } else {
            throw new Exception("Order ID could not be retrieved.");
        }

        // Remove products from stock
        String query = "UPDATE products SET available = available - ? WHERE product_name = ?";
      String query1="update products set sold=sold + ? where product_name= ?";
        remFromTotal = con.prepareStatement(query);
        addtoSold=con.prepareStatement(query1);
         String insertOrderItemQuery = "INSERT INTO order_items (order_id, product_name, quantity, price) VALUES (?, ?, ?, ?)";
            orderItemStmt = con.prepareStatement(insertOrderItemQuery);
         int i=0;  
        for (CartItem item : cart.values()) {
        	System.out.println("hello");
        	System.out.println(item);
            remFromTotal.setInt(1, item.getQuantity());
            remFromTotal.setString(2, item.getProductName());
            remFromTotal.executeUpdate();
            addtoSold.setInt(1,item.getQuantity());
            addtoSold.setString(2,item.getProductName());
             i=addtoSold.executeUpdate();
            System.out.println("i"+i);
        //     Insert order items into the order_items table
           orderItemStmt.setInt(1, orderId);
            orderItemStmt.setString(2, item.getProductName());
            orderItemStmt.setInt(3, item.getQuantity());
            orderItemStmt.setFloat(4, item.getPrice());
             i=orderItemStmt.executeUpdate();
            System.out.println(i);
        }
        session.setAttribute("status","success");
        session.setAttribute("orderId",orderId);
        System.out.println("opera"+orderId);
        // Clear the cart and session data
        session.removeAttribute("cart");
        session.removeAttribute("totalProducts");
        
        //out.println("Order placed successfully with Order ID: " + orderId);
    } catch (SQLException e) {
        e.printStackTrace();
        session.setAttribute("status","error");
        out.println("Error occurred while placing the order: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("status","error");
        out.println("Error occurred: " + e.getMessage());
    } finally {
        // Close resources to prevent memory leaks
        try {
            if (rs != null) rs.close();
            if (orderStmt != null) orderStmt.close();
            if (orderItemStmt != null) orderItemStmt.close();
            if (con != null) con.close();
            session.setAttribute("status","success");
        } catch (SQLException e) {
        	request.setAttribute("status","error");
            e.printStackTrace();
        }
    }
%>
