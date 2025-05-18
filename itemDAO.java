package com.resturent.dao;

import com.resturent.model.items;
import com.resturent.util.DBconnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class itemDAO {

    public static void additem(String name, double price, String image, String category) throws SQLException {
        String sql = "INSERT INTO item (name, price, image, category) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, image);
            stmt.setString(4, category);
            stmt.executeUpdate();
        }
    }

    public static void updateitem(int id, String name, double price, String image, String category) throws SQLException {
        String sql = "UPDATE item SET name=?, price=?, image=?, category=? WHERE id=?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, image);
            stmt.setString(4, category);
            stmt.setInt(5, id);
            stmt.executeUpdate();
        }
    }

    public static void updateItemWithoutImage(int id, String name, double price, String category) throws SQLException {
        String sql = "UPDATE item SET name=?, price=?, category=? WHERE id=?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setDouble(2, price);
            stmt.setString(3, category);
            stmt.setInt(4, id);
            stmt.executeUpdate();
        }
    }

    public static void deleteitem(int id) throws SQLException {
        String sql = "DELETE FROM item WHERE id = ?";
        try (Connection conn = DBconnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public static List<items> getItems() throws SQLException {
        List<items> itemsList = new ArrayList<>();
        String sql = "SELECT * FROM item ORDER BY id";

        try (Connection conn = DBconnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                items item = new items();
                item.setId(rs.getInt("id"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                item.setImage(rs.getString("image"));
                item.setCategory(rs.getString("category"));
                itemsList.add(item);
            }
        }
        return itemsList;
    }
}
