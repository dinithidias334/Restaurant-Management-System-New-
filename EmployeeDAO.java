/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resturent.dao;


import com.resturent.model.Employee;
import com.resturent.util.DBconnection;
import java.sql.*;

public class EmployeeDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/resturent1";
    private static final String USER="root";
    private static final String PASSWORD="";

    // Modified SQL queries with backticks for reserved words
    private  String INSERT_SQL = "INSERT INTO employee (`Name`, `Email`, `role`, `Number`, `Password`, `Status`) VALUES (?, ?, ?, ?, ?, ?)";
    private String SELECT_SQL = "SELECT * FROM employee WHERE `Email` = ?";
    private String UPDATE_SQL = "UPDATE employee SET `Status` = ? WHERE `Email` = ?";

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER,PASSWORD);

    }

    public boolean insertEmployee(Employee employee) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

            ps.setString(1, employee.getName());
            ps.setString(2, employee.getEmail());
            ps.setString(3, employee.getrole());
            ps.setString(4, employee.getNumber());
            ps.setString(5, employee.getPassword());
            ps.setString(6, employee.getStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Insert Error: " + e.getMessage());
            return false;
        }
    }

    public Employee searchByEmail(String email) {
        Employee employee = null;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_SQL)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    employee = new Employee(
                            rs.getString("Name"),
                            rs.getString("Email"),
                            rs.getString("role"),
                            rs.getString("Number"),
                            rs.getString("Password"),
                            rs.getString("Status")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Search Error: " + e.getMessage());
        }
        return employee;
    }

    public boolean updateStatus(String email, String status) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {

            ps.setString(1, status);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Update Error: " + e.getMessage());
            return false;
        }
    }
}
