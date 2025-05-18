package com.resturent.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.resturent.util.DBconnection;

@WebServlet("/SalesAnalysisServlet")
public class SalesAnalysisServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = DBconnection.getConnection();

            // Get sales by category
            Map<String, Integer> salesByCategory = getSalesByCategory(conn);
            request.setAttribute("salesByCategory", salesByCategory);

            // Get top selling items
            List<Map<String, Object>> topSellingItems = getTopSellingItems(conn, 5);
            request.setAttribute("topSellingItems", topSellingItems);

            // Get sales by date (last 7 days)
            Map<String, Integer> salesByDate = getSalesByDate(conn, 7);
            request.setAttribute("salesByDate", salesByDate);

            // Get total sales
            int totalSales = getTotalSales(conn);
            request.setAttribute("totalSales", totalSales);

            // Get total orders
            int totalOrders = getTotalOrders(conn);
            request.setAttribute("totalOrders", totalOrders);

            // Get average order value
            double avgOrderValue = (double) totalSales / totalOrders;
            request.setAttribute("avgOrderValue", avgOrderValue);

            request.getRequestDispatcher("/sales-analysis.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private Map<String, Integer> getSalesByCategory(Connection conn) throws SQLException {
        Map<String, Integer> salesByCategory = new HashMap<>();

        String sql = "SELECT i.category, SUM(oi.quantity * oi.price) as total_sales " +
                "FROM order_items oi " +
                "JOIN item i ON oi.item_id = i.id " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE o.status = 'Complete' " +
                "GROUP BY i.category";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String category = rs.getString("category");
                int totalSales = rs.getInt("total_sales");
                salesByCategory.put(category, totalSales);
            }
        }

        return salesByCategory;
    }

    private List<Map<String, Object>> getTopSellingItems(Connection conn, int limit) throws SQLException {
        List<Map<String, Object>> topSellingItems = new ArrayList<>();

        String sql = "SELECT i.name, i.category, SUM(oi.quantity) as total_quantity, " +
                "SUM(oi.quantity * oi.price) as total_sales " +
                "FROM order_items oi " +
                "JOIN item i ON oi.item_id = i.id " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE o.status = 'Complete' " +
                "GROUP BY i.id " +
                "ORDER BY total_quantity DESC " +
                "LIMIT ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, limit);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("name", rs.getString("name"));
                    item.put("category", rs.getString("category"));
                    item.put("quantity", rs.getInt("total_quantity"));
                    item.put("sales", rs.getInt("total_sales"));
                    topSellingItems.add(item);
                }
            }
        }

        return topSellingItems;
    }

    private Map<String, Integer> getSalesByDate(Connection conn, int days) throws SQLException {
        Map<String, Integer> salesByDate = new HashMap<>();

        String sql = "SELECT DATE(o.order_date) as order_day, " +
                "SUM(oi.quantity * oi.price) as daily_sales " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE o.status = 'Complete' " +
                "AND o.order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL ? DAY) " +
                "GROUP BY order_day " +
                "ORDER BY order_day";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, days);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String date = rs.getString("order_day");
                    int sales = rs.getInt("daily_sales");
                    salesByDate.put(date, sales);
                }
            }
        }

        return salesByDate;
    }

    private int getTotalSales(Connection conn) throws SQLException {
        int totalSales = 0;

        String sql = "SELECT SUM(oi.quantity * oi.price) as total_sales " +
                "FROM order_items oi " +
                "JOIN orders o ON oi.order_id = o.order_id " +
                "WHERE o.status = 'Complete'";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalSales = rs.getInt("total_sales");
            }
        }

        return totalSales;
    }

    private int getTotalOrders(Connection conn) throws SQLException {
        int totalOrders = 0;

        String sql = "SELECT COUNT(*) as total_orders FROM orders WHERE status = 'Complete'";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                totalOrders = rs.getInt("total_orders");
            }
        }

        return totalOrders;
    }
}