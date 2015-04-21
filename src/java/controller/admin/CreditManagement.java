/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Project;
import model.Purchased;
import model.User;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "CreditManagement", urlPatterns = {"/admin.credit"})
public class CreditManagement extends HttpServlet {

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
            //index(request, response);
        } else if (method.equals("dividendshare")) {
            dividendshare(request, response);
        }
    }

    protected void dividendshare(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (Connection conn = F.getConnection()) {
            PreparedStatement pstmt, updatePstmt, creditPstmt, userPstmt;
            pstmt = conn.prepareStatement("SELECT project.user_id AS user_id, SUM(purchase.price*(purchase.dividend/100)) AS to_share FROM `purchase` INNER JOIN project ON (project_id = project.id) WHERE purchase.shared = 0 GROUP BY project.user_id;");
            updatePstmt = conn.prepareStatement("UPDATE `purchase` SET `shared` = '1';");
            userPstmt = conn.prepareStatement("SELECT * FROM user WHERE id = ?");
            creditPstmt = conn.prepareStatement("UPDATE `user` SET `credit` = ? WHERE `user`.`id` = ?;");
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                userPstmt.setInt(1, result.getInt("user_id"));
                ResultSet userRes = userPstmt.executeQuery();
                userRes.next();
                User toChangeUser = new User(userRes);
                Double newCredit = Double.parseDouble(toChangeUser.getCredit()) + result.getDouble("to_share");
                F.logCredit(toChangeUser.getId(), newCredit, "Credits from selling projects.", user.getId());
                creditPstmt.setDouble(1, newCredit);
                creditPstmt.setInt(2, toChangeUser.getId());
                creditPstmt.executeUpdate();
                userRes.close();
            }
            updatePstmt.executeUpdate();
            creditPstmt.close();
            updatePstmt.close();
            userPstmt.close();
            result.close();
            pstmt.close();
            conn.close();
            String[] message = {"จ่ายเครดิตให้กับผู้สร้างผลงานเรียบร้อยแล้ว!", "success"};
            session.setAttribute("message", message);
        } catch (SQLException ex) {
            Logger.getLogger(ProjectManagement.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.sendRedirect(F.asset("/admin"));
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
