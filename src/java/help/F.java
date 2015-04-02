/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package help;

import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.DataSource;
import sun.misc.BASE64Encoder;

/**
 *
 * @author tanasab
 */
public class F implements Serializable {

    private static String projectPath;
    private static Connection connection;
    private static DataSource datasource;
    private static long last_connect = 0;

    public static Connection getConnection() {
        try {
            /*
            if (last_connect == 0) {
                last_connect = System.currentTimeMillis();
            }
            else if (System.currentTimeMillis() - last_connect > 300000) {
                connection = datasource.getConnection();
            }
                    */
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
        if(url == null || url.trim().equals("")){
            return "";
        }
        else if (!url.contains("http://") && !url.contains("https://")) {
            return projectPath + "/" + url.replaceAll("^/+", "").replaceAll("/+$", "");
        } else {
            return url;
        }
    }

    public static String getProjectPath() {
        return projectPath;
    }

    public static void setProjectPath(String projectPath) {
        F.projectPath = projectPath;
    }

    public static String encodePwd(String pwd) {
        String sDigest = "";
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(pwd.getBytes("UTF-8")); // Change this to "UTF-16" if needed
            byte[] digest = md.digest();
            sDigest = byteToBase64(digest);

        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(F.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(F.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sDigest;
    }

    public static String byteToBase64(byte[] data) {
        BASE64Encoder endecoder = new BASE64Encoder();
        return endecoder.encode(data);
    }

}
