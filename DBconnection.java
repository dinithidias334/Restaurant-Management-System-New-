package com.resturent.util;
                                //Data Base Connection Helper

import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;

public class DBconnection {

    private static final String URL = "jdbc:mysql://localhost:3306/resturent1";
    private static final String USER="root";
    private static final String PASSWORD="";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MySQL JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL,USER,PASSWORD);

    }

}
