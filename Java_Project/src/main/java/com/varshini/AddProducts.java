package com.varshini;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AddProducts extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pname = request.getParameter("pname");
        String pprice = request.getParameter("pprice");
        String quantity = request.getParameter("quantity");
        String category = request.getParameter("category"); 
       String notify=request.getParameter("notify");
       String type=request.getParameter("type");
        Connection conn = null;
        PreparedStatement pst = null;
        System.out.println(pname+" "+pprice+" "+quantity+" "+category+" "+category+" "+type);
        try {
            conn = DbConnection.getConnected(); // Ensure `DbConnection` is implemented correctly
            String query="Select count(*) as pcount from products where product_name=?";
            pst = conn.prepareStatement(query);
            pst.setString(1, pname);
            ResultSet rs=pst.executeQuery();
            rs.next();
            if(rs.getInt("pcount")>0) {
            	request.setAttribute("error", "Product already exists");
                RequestDispatcher rd =  request.getRequestDispatcher("addProducts.jsp"); // Redirect to same JSP
                rd.forward(request, response);
                return;
            }
            String sql = "INSERT INTO products (product_name, price, available, category,to_notify,kind,sold) VALUES (?, ?, ?,?, ?,?,0)";
            pst = conn.prepareStatement(sql);
            pst.setString(1, pname);
            pst.setString(2, pprice);
            pst.setString(3, quantity);
            pst.setString(4, category); 
            pst.setString(5, notify);
            pst.setString(6, type);
            pst.executeUpdate();
         // Success message
            request.setAttribute("success", "Product added successfully!");
            RequestDispatcher rd = request.getRequestDispatcher("addProducts.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
        	System.out.println(e.getMessage());
        	 request.setAttribute("error", "Error adding the product");
             RequestDispatcher rd =  request.getRequestDispatcher("addProducts.jsp"); // Redirect to same JSP
             rd.forward(request, response);
        } finally {
            try {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
