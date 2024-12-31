package com.varshini;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ReloadProducts extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pname = request.getParameter("product"); // Matches form input name
        String pprice = request.getParameter("rate");   // Matches form input name
        String quantity = request.getParameter("quantity");
        String to_notify = request.getParameter("to_notify");

        Connection conn = null;
        PreparedStatement pst = null;

        try {
            conn = DbConnection.getConnected(); // Ensure `DbConnection` is implemented correctly

            String sql = "UPDATE products SET available = available + ?, price = ?,to_notify=? ,sold=0 WHERE product_name = ? ";
            
            pst = conn.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(quantity)); // Convert quantity to int
            pst.setDouble(2, Double.parseDouble(pprice)); // Convert price to double
            pst.setString(3, to_notify);
            pst.setString(4, pname);
            

            int rowsUpdated = pst.executeUpdate();

            if (rowsUpdated > 0) {
                // Success message
                request.setAttribute("success", "Product reloaded successfully!");
            } else {
                // No rows updated (product or brand not found)
                request.setAttribute("error", "No matching product found for the selected brand.");
            }
            RequestDispatcher rd = request.getRequestDispatcher("reloadProduct.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            // Log and handle the error
            e.printStackTrace();
            request.setAttribute("error", "Error updating the product: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("reloadProduct.jsp");
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
