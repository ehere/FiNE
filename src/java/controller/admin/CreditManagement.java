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
import java.util.HashMap;
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
            index(request, response);
        } else if (method.equals("creditlog")) {
            creditlog(request, response);
        } else if (method.equals("dividendshare")) {
            dividendshare(request, response);
        } else if (method.equals("share")) {
            share(request, response);
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        try (Connection conn = F.getConnection()) {
            PreparedStatement purchase_query = conn.prepareStatement("SELECT project.user_id AS owner , SUM(purchase.price*(purchase.dividend/100)) AS total FROM purchase JOIN project ON (purchase.project_id = project.id) WHERE shared = 0 GROUP BY project.user_id");
            ResultSet purchase = purchase_query.executeQuery();
            PreparedStatement user_query = conn.prepareStatement("SELECT * FROM `user` WHERE `id` = ?;");
            ArrayList<User> userList = new ArrayList();
            HashMap<Integer,Double> share = new HashMap<>();
            while(purchase.next()){
                share.put(purchase.getInt("owner"), purchase.getDouble("total"));
                user_query.setInt(1, purchase.getInt("owner"));
                ResultSet user_result = user_query.executeQuery();
                user_result.next();
                User user = new User(user_result);
                userList.add(user);
                user_result.close();
            }
            request.setAttribute("userList", userList);
            request.setAttribute("share", share);
            user_query.close();
            purchase.close();
            purchase_query.close();
            conn.close();
            request.getRequestDispatcher("/jsp/admin/dividend.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreditManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void creditlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (Connection conn = F.getConnection()) {
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            PreparedStatement csmt = conn.prepareStatement("SELECT CEIL( COUNT(*) / 10 ) AS totalpage FROM `credit_log` WHERE detail LIKE 'C%';");
            ResultSet cr = csmt.executeQuery();
            cr.next();
            int totalpage = cr.getInt("totalpage");
            cr.close();
            csmt.close();

            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `credit_log` WHERE detail LIKE 'C%' ORDER BY created_at DESC LIMIT 10 OFFSET ?;");
            psmt.setInt(1, (page - 1) * 10);
            ResultSet result = psmt.executeQuery();
            ArrayList<model.Credit> list = new ArrayList();
            while (result.next()) {
                model.Credit credit = new model.Credit(result);
                list.add(credit);
            }

            request.setAttribute("list", list);
            request.setAttribute("totalpage", totalpage);
            request.setAttribute("currentpage", page);
            result.close();
            psmt.close();
            conn.close();
            request.getRequestDispatcher("/jsp/admin/creditlog.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProjectManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    protected void share(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (Connection conn = F.getConnection()) {
            PreparedStatement pstmt, updatePstmt, creditPstmt, userPstmt;
            pstmt = conn.prepareStatement("SELECT project.user_id AS user_id, SUM(purchase.price*(purchase.dividend/100)) AS to_share FROM `purchase` INNER JOIN project ON (project_id = project.id) WHERE purchase.shared = 0 AND project.user_id = ?  GROUP BY project.user_id;");
            updatePstmt = conn.prepareStatement("UPDATE `purchase` SET `shared` = '1' WHERE id IN (SELECT newpurchase.id FROM (SELECT * FROM purchase) AS newpurchase INNER JOIN project ON (newpurchase.project_id = project.id) WHERE newpurchase.shared = 0 AND project.user_id = ?);");
            pstmt.setInt(1, Integer.parseInt((String) request.getAttribute("id")));
            updatePstmt.setInt(1, Integer.parseInt((String) request.getAttribute("id")));
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

        response.sendRedirect(F.asset("/admin/dividend"));
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

        response.sendRedirect(F.asset("/admin/dividend"));
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
