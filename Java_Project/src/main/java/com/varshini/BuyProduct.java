package com.varshini;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class BuyProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        String productName = req.getParameter("product_name");
        String quantityStr = req.getParameter("quantity");
        String priceStr = req.getParameter("price");

        if (productName == null || productName.trim().isEmpty()) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product name is required.");
            return;
        }

        int quantity;
        float price;

        try {
            quantity = Integer.parseInt(quantityStr);
            price = Float.parseFloat(priceStr);
        } catch (NumberFormatException e) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity or price.");
            return;
        }

        HttpSession session = req.getSession();
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }
        int totalProducts = 0;
        if (session.getAttribute("totalProducts") != null) {
            totalProducts = (int) session.getAttribute("totalProducts");
        }

        if ("Add".equalsIgnoreCase(action)) {
            CartItem cartItem = cart.getOrDefault(productName, new CartItem(productName,0, price));
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            cart.put(productName, cartItem);

            totalProducts += quantity;

            session.setAttribute("successMessage", productName + " added successfully!");
        } else if ("Remove".equalsIgnoreCase(action)) {
            CartItem cartItem = cart.remove(productName);
            if (cartItem != null) {
                totalProducts -= cartItem.getQuantity();
            }

            session.setAttribute("successMessage", productName + " removed from the cart.");
        }

        session.setAttribute("cart", cart);
        session.setAttribute("totalProducts", totalProducts);
        String current=(String)req.getAttribute("current");
        System.out.println(current);
        if(current!=null && current.equals("topSale")) {
        	req.setAttribute("current","");
        	res.sendRedirect("topSale.jsp");
        	
        }
        else {
        res.sendRedirect("viewProductsCust.jsp");
        }
    }
}