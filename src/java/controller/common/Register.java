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
import java.sql.Connection;
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

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/common.register"})
public class Register extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String method = (String) request.getAttribute("do");

        if (method.equals("index")) {
            index(request, response);
        }else if(method.equals("add")){
            add(request, response);
        }

    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            //redir to login pg.
            request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
        } else {
            //redir to index pg.
            response.sendRedirect(F.asset("/"));
        }
    }

    protected void add(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        //Begin registration here
        String sql = "INSERT INTO `user` (`prefix`, `firstname`, `lastname`, `email`, `password`, `birthday`, `role`, `created_at`) VALUES ( ?, ?, ?, ?, ?, ?, 0, CURRENT_TIMESTAMP());";
        try(Connection conn = F.getConnection()) {

            if (session.getAttribute("user") != null) {
                //logged in > go to index.
                response.sendRedirect(F.asset("/"));
            }
            if (!validator(request, response)) {
                try {
                    response.sendRedirect(F.asset("/register"));
                } catch (IOException ex) {
                    Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("prefix"));
            pstmt.setString(2, request.getParameter("firstname"));
            pstmt.setString(3, request.getParameter("lastname"));
            pstmt.setString(4, request.getParameter("email"));
            pstmt.setString(5, F.encodePwd(request.getParameter("password")));
            pstmt.setString(6, request.getParameter("birthday"));
            int isSuccess = pstmt.executeUpdate();
            if (isSuccess == 1) {
                //login
                request.setAttribute("action", "login");
                request.setAttribute("do", "authen");
                request.getRequestDispatcher("/common.login").forward(request, response);
            } else {
                //err occur
                response.sendRedirect(F.asset("/register"));
            }
            pstmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected boolean validator(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        if (!request.getParameter("password").equals(request.getParameter("c-password"))) {
            request.getSession().setAttribute("message", "กรุณาใส่รหัสผ่าน และยืนยันรหัสผ่านให้ตรงกัน!");
            return false;
        }
        String sql = "SELECT COUNT(id) FROM user WHERE email = ?;";
        ResultSet result = null;
        try(Connection conn = F.getConnection()) {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("email"));
            result = pstmt.executeQuery();
            result.next();
            if (result.getInt(1) != 0) {
                request.getSession().setAttribute("message", "อีเมลนี้ได้ถูกใช้ไปแล้ว!");
                return false;
            }
            result.close();
            pstmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
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
