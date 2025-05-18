package com.resturent.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/ConfirmOrderServlet")
public class ConfirmOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("success.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement itemStmt = null;
        ResultSet rs = null;
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/resturent1", "root", "");

            
            orderStmt = conn.prepareStatement(
                "INSERT INTO orders (status) VALUES ('Pending')", 
                Statement.RETURN_GENERATED_KEYS
            );
            orderStmt.executeUpdate();
            rs = orderStmt.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);

                
                itemStmt = conn.prepareStatement("INSERT INTO order_items (order_id, item_id, quantity, price) VALUES (?, ?, ?, ?)");
                for (Map<String, Object> item : cart) {
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, (Integer)item.get("id"));
                    itemStmt.setInt(3, (Integer)item.get("quantity"));
                    itemStmt.setInt(4, (Integer)item.get("price"));
                    itemStmt.addBatch();
                }
                itemStmt.executeBatch();
            }
            
            session.removeAttribute("cart");
            response.sendRedirect("success.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp?error=db");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (orderStmt != null) orderStmt.close(); } catch (Exception e) {}
            try { if (itemStmt != null) itemStmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
