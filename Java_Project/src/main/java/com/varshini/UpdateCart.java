package com.varshini;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;
public class UpdateCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        String productName = request.getParameter("product_name");
        String action = request.getParameter("action");

        if (productName != null && action != null) {
            CartItem item = cart.get(productName);

            if (item != null) {
                switch (action) {
                    case "Increase":
                        // Increase quantity
                        item.setQuantity(item.getQuantity() + 1);
                        break;

                    case "Decrease":
                        // Decrease quantity (but not below 1)
                        if (item.getQuantity() > 1) {
                            item.setQuantity(item.getQuantity() - 1);
                        } else {
                            // If quantity becomes 0, remove the item
                            cart.remove(productName);
                        }
                        break;

                    case "Remove":
                        // Remove item from the cart
                        cart.remove(productName);
                        break;

                    default:
                        // Invalid action, do nothing
                        break;
                }
            }
        }

        // Update session and redirect back to the cart page
        session.setAttribute("cart", cart);
        session.setAttribute("successMessage", "Cart updated successfully!");
        response.sendRedirect("cart.jsp");
    }
}
