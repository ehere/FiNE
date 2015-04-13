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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Purchased;
import model.User;

/**
 *
 * @author iMEIDA
 */
@WebServlet(name = "Profile", urlPatterns = {"/common.profile"})
public class Profile extends HttpServlet {

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
        if(!F.isLoggedIn(request.getSession())){
            response.sendRedirect(F.asset("/login"));
            return;
        }
        String method = (String) request.getAttribute("do");
        if (method.equals("edit")) {
            //go edit
        } else if(method.equals("view")) {
            show(request, response);
        }
    }
    
    protected void show(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        Connection conn = F.getConnection();
        HttpSession session = request.getSession();
        String id = (String) request.getAttribute("id");
        System.out.println("ID : "+id);
        User user = (User) session.getAttribute("user");
        if(id == null){
            //send user to profile
            request.setAttribute("profile", user);
            request.setAttribute("canEdit", true);
        }
        else{
            //search for new user
            
            try {
                PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE id = ?;");
                pstmt.setString(1, id);
                ResultSet result = pstmt.executeQuery();
                result.next();
                User viewUser = new User(result);
                
                request.setAttribute("profile", viewUser);
                result.close();
                pstmt.close();
            } catch (SQLException ex) {
                Logger.getLogger(Profile.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("canEdit", false);
        }
        User profileUser = (User) request.getAttribute("profile");
        try {
            PreparedStatement lastplayPsmt = conn.prepareStatement("SELECT * FROM `save` JOIN activity ON (last_activity_id = activity.id) WHERE `user_id` = ? ORDER BY `save`.created_at DESC;");
            lastplayPsmt.setInt(1, profileUser.getId());
            ResultSet result = lastplayPsmt.executeQuery();
            if(result.next()){
                request.setAttribute("lastplayTime", F.convertDate(result.getString("created_at"), "dd MMMMM yyyy"));
            }
            else{
                request.setAttribute("lastplayTime", "ยังไม่เคยเล่น");
            }
            lastplayPsmt.close();
            result.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Profile.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        request.getRequestDispatcher("/jsp/common/profile-view.jsp").forward(request, response);
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
