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
import model.User;

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
        Connection conn = F.getConnection();
        String pathInfo;
        if (request.getPathInfo() != null) {
            pathInfo = request.getPathInfo().replaceAll("^/+", "").replaceAll("/+$", "");
        } else {
            pathInfo = "";
        }

        if (pathInfo.contains("view")) {
            try {
                String id = pathInfo.split("/")[0];
                PreparedStatement psmt = conn.prepareStatement("SELECT * FROM fine.project WHERE id = ?;");
                psmt.setString(1, id);
                ResultSet result = psmt.executeQuery();
                result.next();
                Project product = new Project(result);

                PreparedStatement boughtPstmt = conn.prepareStatement("SELECT * FROM fine.purchase WHERE user_id = ? AND project_id = ?");
                if (F.isLoggedIn(request.getSession())) {
                    try {
                        boughtPstmt.setInt(1, ((User) request.getSession().getAttribute("user")).getId());
                        boughtPstmt.setInt(2, product.getId());
                        ResultSet bRes = boughtPstmt.executeQuery();
                        boolean isnext = bRes.next();
                        if (isnext) {
                            product.setIs_bought(true);
                        }
                        bRes.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                boughtPstmt.close();

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
                PreparedStatement csmt = conn.prepareStatement("SELECT CEIL( COUNT(*) / 8 ) AS totalpage FROM `project` ;");
                ResultSet cr = csmt.executeQuery();
                cr.next();
                int totalpage = cr.getInt("totalpage");
                cr.close();
                csmt.close();

                PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `project`  LIMIT 8 OFFSET ?;");
                psmt.setInt(1, (page - 1) * 8);
                ResultSet result = psmt.executeQuery();
                ArrayList<Project> list = new ArrayList();
                System.out.println("--------");
                System.out.println("1");
                PreparedStatement boughtPstmt = conn.prepareStatement("SELECT * FROM fine.purchase WHERE user_id = ? AND project_id = ?");
                while (result.next()) {
                    //System.out.print("2 |"+result.getString(1)+"|");
                    Project product = new Project(result);
                    if (F.isLoggedIn(request.getSession())) {
                        try {
                            boughtPstmt.setInt(1, ((User) request.getSession().getAttribute("user")).getId());
                            boughtPstmt.setInt(2, product.getId());
                            ResultSet bRes = boughtPstmt.executeQuery();
                            boolean isnext = bRes.next();
                            if (isnext) {
                                product.setIs_bought(true);
                            }
                            bRes.close();
                        } catch (SQLException ex) {
                            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    list.add(product);
                }
                boughtPstmt.close();
                
                System.out.println("5");
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
        try {
            conn.close();
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
