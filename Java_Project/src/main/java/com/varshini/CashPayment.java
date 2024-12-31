package com.varshini;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class CashPayment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String query="Update payments set status=? where  orderId =?";
        try {
        Connection conn=DbConnection.getConnected();
        PreparedStatement pstmt=conn.prepareStatement(query);
        pstmt.setString(1, "Completed");
        pstmt.setInt(2, orderId);
        pstmt.executeUpdate();
       
        }
        catch(SQLException e) {
        	System.out.println(e.getMessage());
        }
        finally {
        	 response.sendRedirect("CashPayments.jsp");
        	    }
    }
 }