package com.resturent.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.resturent.model.Employee;

public class LoginDAO {

    // Update these to match your MySQL setup
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/resturent1?useSSL=false&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = ""; // Put your MySQL password here

    private static final String SELECT_SQL = "SELECT * FROM employee WHERE email = ? AND password = ?";

    // Get a database connection
    protected Connection getConnection() {
        try {
            // For MySQL 8+ use com.mysql.cj.jdbc.Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Database connection error: " + e.getMessage());
            return null;
        }
    }

    // Validate user credentials and return Employee object if valid, else null
    public Employee validateUser(String email, String password) {
        Employee employee = null;
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn != null ? conn.prepareStatement(SELECT_SQL) : null) {

            if (stmt != null) {
                stmt.setString(1, email);
                stmt.setString(2, password);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        employee = new Employee();
                        employee.setEmail(rs.getString("email"));
                        employee.setPassword(rs.getString("password"));
                        employee.setRole(rs.getString("role"));
                        employee.setStatus(rs.getString("status"));
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("SQL error: " + e.getMessage());
        }
        return employee;
    }
}
