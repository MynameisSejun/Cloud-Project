package util;

import java.sql.*;

public class DBConnection {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/runningApp?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "1234";
    
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(JDBC_URL + "&serverTimezone=Asia/Seoul", USER, PASSWORD);
        return conn;
    }
    
    public static void close(AutoCloseable... resources) {
        for(AutoCloseable resource : resources) {
            if(resource != null) {
                try {
                    resource.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}