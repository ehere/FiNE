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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import model.Purchased;
import sun.misc.BASE64Encoder;

/**
 *
 * @author tanasab
 */
public class F implements Serializable {

    private static String projectPath;
    private static DataSource datasource;

    public static Connection getConnection() {
        try {
            return datasource.getConnection();
        } catch (SQLException ex) {
            Logger.getLogger(F.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public DataSource getDatasource() {
        return datasource;
    }

    public static void setDatasource(DataSource datasource) {
        F.datasource = datasource;
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
    
    public static boolean isLoggedIn(HttpSession session){
        return session.getAttribute("user") != null;
    }

    public static boolean isUrlMatch(String pattern, String url){
        if(url.contains("?")){
            int pos = url.indexOf("?");
            url = url.substring(0, pos);
        }
        String[] sPattern = pattern.split("/+");
        String[] sUrl = url.split("/+");
        if(sPattern.length != sUrl.length){
            return false;
        }
        for(int i = 0; i < sPattern.length; i++){
            if(!sPattern[i].contains("{")){
                if(!sPattern[i].equals(sUrl[i])){
                    return false;
                }
            }
        }
        return true;
    }
    
    public static String urlMapper(String pattern, String url, HttpServletRequest request){
        String[] sPattern = pattern.split("/+");
        String[] sUrl = url.split("/+");
        for(int i = 0; i < sPattern.length; i++){
            if(sPattern[i].contains("{")){
                String key = sPattern[i].substring(1, sPattern[i].length()-1);
                request.setAttribute(key, sUrl[i]);
            }
        }
        return "";
    }
    
    public static String convertDate(String toConvert, String newFormat){
        if(toConvert == null){
            return null;
        }
        try {
            SimpleDateFormat newDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            Date MyDate = newDateFormat.parse(toConvert);
            newDateFormat.applyPattern(newFormat);
            return newDateFormat.format(MyDate);
        } catch (ParseException ex) {
            Logger.getLogger(Purchased.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
