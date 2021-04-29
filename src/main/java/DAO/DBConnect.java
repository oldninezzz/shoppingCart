package DAO;

import JDBC.DBConInterface;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect implements DBConInterface {
    private Connection conn = null;
    private String driverClassName;
    private String url;
    private String username;
    private String password;
    public DBConnect(){
        driverClassName = "com.mysql.cj.jdbc.Driver";
        url = "jdbc:mysql://localhost:3306/user?serverTimezone=UTC";
        username = "root";
        password = "lsm010102";
    }
    @Override
    public Connection getConnection() throws Exception{
        Class.forName(driverClassName);
        this.conn = DriverManager.getConnection(url, username, password);
        return this.conn;
    }
    @Override
    public void close() throws Exception{
        this.conn.close();
    }
}
