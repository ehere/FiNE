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
import java.util.ArrayList;
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
@WebServlet(name = "Inventory", urlPatterns = {"/common.inventory"})
public class Inventory extends HttpServlet {

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
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        if (!F.isLoggedIn(request.getSession())) {
            response.sendRedirect(F.asset("/login"));
            return;
        }
        try(Connection conn = F.getConnection()) {
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            PreparedStatement csmt = conn.prepareStatement("SELECT CEIL( COUNT(*) / 9 ) AS totalpage FROM `purchase` WHERE `user_id` = ?;");
            csmt.setInt(1, user.getId());
            ResultSet cr = csmt.executeQuery();
            cr.next();
            int totalpage = cr.getInt("totalpage");
            cr.close();
            csmt.close();

            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `purchase` WHERE `user_id` = ? LIMIT 9 OFFSET ?;");
            psmt.setInt(1, user.getId());
            psmt.setInt(2, (page - 1) * 9);
            ResultSet result = psmt.executeQuery();
            ArrayList<model.Purchased> list = new ArrayList();
            while (result.next()) {
                model.Purchased purchased = new model.Purchased(result);
                list.add(purchased);
            }

            request.setAttribute("list", list);
            request.setAttribute("totalpage", totalpage);
            request.setAttribute("currentpage", page);
            result.close();
            psmt.close();
            conn.close();
            request.getRequestDispatcher("/jsp/common/item-list.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        }
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
