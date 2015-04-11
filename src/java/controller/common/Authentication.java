/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.common;

import help.F;
import java.io.IOException;
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
import model.User;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Authentication", urlPatterns = {"/common.login"})
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String method = (String) request.getAttribute("do");
        if (method.equals("index")) {
            index(request, response);
        } else if (method.equals("authen")) {
            authen(request, response);
        }

    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            //redir to login pg.
            request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
        } else {
            //redir to index pg.
            response.sendRedirect(F.asset("/"));
        }
    }

    protected void authen(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action") != null) {
            if (request.getParameter("action").equals("login")) {
                login(request, response);
            } else if (request.getParameter("action").equals("logout")) {
                logout(request, response);
            }
        } else if (request.getAttribute("action") != null) {
            if (request.getAttribute("action").equals("login")) {
                login(request, response);
            }
        }
    }

    protected void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Connection conn = F.getConnection();
            response.setContentType("text/html;charset=UTF-8");
            HttpSession session = request.getSession();
            if (session.getAttribute("user") != null) {
                //logged in > go to index.
                response.sendRedirect(F.asset("/"));
            }
            //login hereeeeee!!!
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE email = ?;");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            pstmt.setString(1, email);
            ResultSet result = pstmt.executeQuery();
            boolean isSuccess = result.next();
            if (isSuccess && (loginValidator(password, result.getString("password")))) {
                //login success!
                User user = new User(result);
                session.setAttribute("user", user);
                session.setAttribute("cart", new model.Cart());
                response.sendRedirect(F.asset("/"));
            } else {
                //login fail!
                response.sendRedirect(F.asset("/login"));
            }
            result.close();
            pstmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Authentication.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect(F.asset("/"));
    }

    protected boolean loginValidator(String inputPwd, String userPwd) {
        return F.encodePwd(inputPwd).equals(userPwd);
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
