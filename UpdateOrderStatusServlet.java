package com.resturent.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null) {
            response.sendRedirect("kitchen.jsp");
            return;
        }
        try (Connection conn = com.resturent.util.DBconnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE orders SET status='Complete' WHERE order_id=?")) {
            ps.setInt(1, Integer.parseInt(orderIdStr));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("kitchen.jsp");
    }
}
