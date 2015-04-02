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
import model.Project;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "productDetail", urlPatterns = {"/product/*"})
public class Product extends HttpServlet {

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
        String pathInfo;
        if (request.getPathInfo() != null) {
            pathInfo = request.getPathInfo().replaceAll("^/+", "").replaceAll("/+$", "");
        } else {
            pathInfo = "";
        }

        if (pathInfo.contains("play")) {
            try {
                String id = pathInfo.split("/")[0];
                PreparedStatement psmt = F.getConnection().prepareStatement("SELECT * FROM fine.project WHERE id = ?;");
                psmt.setString(1, id);
                ResultSet result = psmt.executeQuery();
                result.next();
                Project product = new Project(result);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/jsp/common/product-play.jsp").forward(request, response);
                result.close();
                psmt.close();
            } catch (SQLException ex) {
                Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (pathInfo.contains("view")) {
            try {
                String id = pathInfo.split("/")[0];
                PreparedStatement psmt = F.getConnection().prepareStatement("SELECT * FROM fine.project WHERE id = ?;");
                psmt.setString(1, id);
                ResultSet result = psmt.executeQuery();
                result.next();
                Project product = new Project(result);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/jsp/common/product-detail.jsp").forward(request, response);
                result.close();
                psmt.close();
            } catch (SQLException ex) {
                Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                int page = 1;
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                PreparedStatement csmt = F.getConnection().prepareStatement("SELECT CEIL( COUNT(*) / 8 ) AS totalpage FROM `project` ;");
                ResultSet cr = csmt.executeQuery();
                cr.next();
                int totalpage = cr.getInt("totalpage");
                cr.close();
                csmt.close();
                
                PreparedStatement psmt = F.getConnection().prepareStatement("SELECT * FROM `project`  LIMIT 8 OFFSET ?;");
                psmt.setInt(1, (page - 1) * 8);
                ResultSet result = psmt.executeQuery();
                ArrayList<Project> list = new ArrayList();
                while (result.next()) {
                    Project product = new Project(result);
                    list.add(product);
                }
                request.setAttribute("list", list);
                request.setAttribute("totalpage", totalpage);
                request.setAttribute("currentpage", page);
                result.close();
                psmt.close();
                request.getRequestDispatcher("/jsp/common/product-list.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
            }
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
