/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package help;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;

/**
 *
 * @author tanasab
 */
public class F implements Serializable {

    private static String projectPath;
    private static Connection connection;
    private static DataSource datasource;

    public static Connection getConnection() {
        try {
            if (connection != null && connection.isClosed()) {
                synchronized (F.class) {
                    connection = datasource.getConnection();
                }

            } else if (connection == null) {
                synchronized (F.class) {
                    connection = datasource.getConnection();
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(F.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }

    public DataSource getDatasource() {
        return datasource;
    }

    public static void setDatasource(DataSource datasource) {
        F.datasource = datasource;
    }

    public static void setConnection(Connection connection) {
        F.connection = connection;
    }

    public static String asset(String url) {
        if (!url.contains("http://") && !url.contains("https://")) {
            return projectPath + "/" + url.replaceAll("^/+", "").replaceAll("/+$", "");
        }else{
            return url;
        }
    }

    public static String getProjectPath() {
        return projectPath;
    }

    public static void setProjectPath(String projectPath) {
        F.projectPath = projectPath;
    }

}
