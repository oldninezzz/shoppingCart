package JDBC;

import java.sql.Connection;

public interface DBConInterface {
    public Connection getConnection() throws Exception;

    public void close() throws Exception;
}
