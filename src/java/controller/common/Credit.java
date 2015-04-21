/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.common;

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
import model.User;

/**
 *
 * @author iMEIDA
 */
@WebServlet(name = "Credit", urlPatterns = {"/common.credit"})
public class Credit extends HttpServlet {

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
        try (Connection conn = F.getConnection()) {
            HttpSession session = request.getSession();
            if(session.getAttribute("user") == null){
                response.sendRedirect(F.asset("/login"));
            }
            User user = (User) session.getAttribute("user");
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            PreparedStatement csmt = conn.prepareStatement("SELECT CEIL( COUNT(*) / 20 ) AS totalpage FROM `credit_log` WHERE owner_id = "+user.getId()+";");
            ResultSet cr = csmt.executeQuery();
            cr.next();
            int totalpage = cr.getInt("totalpage");
            cr.close();
            csmt.close();

            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `credit_log` WHERE owner_id = "+user.getId()+" ORDER BY created_at DESC LIMIT 20 OFFSET ?;");
            psmt.setInt(1, (page - 1) * 20);
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
            request.getRequestDispatcher("/jsp/common/credit-list.jsp").forward(request, response);
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
