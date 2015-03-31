/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.common;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import sun.misc.BASE64Encoder;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Authentication", urlPatterns = {"/login.do"})
public class Authentication extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action").equals("login")) {
            login(request, response);
        }
        else if(request.getParameter("action").equals("logout")) {
            logout(request, response);
        }
    }

    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            //login hereeeeee!!!
            PreparedStatement pstmt = F.getConnection().prepareStatement("SELECT * FROM fine.user WHERE email = ?;");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            pstmt.setString(1, email);
            ResultSet result = pstmt.executeQuery();
            System.out.println(password);
            boolean isSuccess = result.next();
            if (isSuccess && (loginValidator(password, result.getString("password")))) {
                //login success!
                HttpSession session = request.getSession();
                User user = new User(result);
                session.setAttribute("user", user);
                response.sendRedirect(F.asset("/"));
            } else {
                //login fail!
                response.sendRedirect(F.asset("/login"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Authentication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect(F.asset("/"));
    }

    public boolean loginValidator(String inputPwd, String userPwd) {
        try {
            if (byteToBase64(encodePwd(inputPwd)).equals(userPwd)) {
                return true;
            }
        } catch (UnsupportedEncodingException | NoSuchAlgorithmException ex) {
            Logger.getLogger(Authentication.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public byte[] encodePwd(String pwd) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(pwd.getBytes("UTF-8")); // Change this to "UTF-16" if needed
        byte[] digest = md.digest();
        return digest;
        /*String sDigest = byteToBase64(digest);
         return sDigest;*/
    }

    public String byteToBase64(byte[] data) {
        BASE64Encoder endecoder = new BASE64Encoder();
        return endecoder.encode(data);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
