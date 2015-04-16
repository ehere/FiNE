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
import model.Project;
import model.User;

@WebServlet(name = "productDetail", urlPatterns = {"/common.product"})
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

        String method = (String) request.getAttribute("do");
        if (method.equals("view")) {
            view(request, response);
        } else if (method.equals("index")) {
            if(request.getParameter("search") != null){
                search(request, response);
            }
            else{
                index(request, response);
            }
        }
    }

    protected void view(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            Connection conn = F.getConnection();
            String id = (String) request.getAttribute("id");
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM project WHERE id = ?;");
            psmt.setString(1, id);
            ResultSet result = psmt.executeQuery();
            if (!result.next()) {
                String[] message = {"ขออภัย ไม่พบนิยายดังกล่าว", "danger"};
                session.setAttribute("message", message);
                response.sendRedirect(F.asset("/product"));
                return;
            }
            Project product = new Project(result);

            PreparedStatement boughtPstmt = conn.prepareStatement("SELECT * FROM purchase WHERE user_id = ? AND project_id = ?");
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
            
            if(!product.isVisible() && !product.isIs_bought()){
                String[] message = {"ขออภัย ไม่พบนิยายดังกล่าว", "danger"};
                session.setAttribute("message", message);
                response.sendRedirect(F.asset("/product"));
                return;
            }
            request.setAttribute("product", product);
            result.close();
            psmt.close();
            conn.close();
            request.getRequestDispatcher("/jsp/common/product-detail.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conn = F.getConnection();
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            PreparedStatement csmt = conn.prepareStatement("SELECT CEIL( COUNT(*) / 8 ) AS totalpage FROM `project` WHERE visible = 1;");
            ResultSet cr = csmt.executeQuery();
            cr.next();
            int totalpage = cr.getInt("totalpage");
            cr.close();
            csmt.close();

            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `project` WHERE visible = 1  LIMIT 8 OFFSET ?;");
            psmt.setInt(1, (page - 1) * 8);
            ResultSet result = psmt.executeQuery();
            ArrayList<Project> list = new ArrayList();
            PreparedStatement boughtPstmt = conn.prepareStatement("SELECT * FROM purchase WHERE user_id = ? AND project_id = ?");
            while (result.next()) {
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

            request.setAttribute("list", list);
            request.setAttribute("totalpage", totalpage);
            request.setAttribute("currentpage", page);
            result.close();
            psmt.close();
            conn.close();
            request.getRequestDispatcher("/jsp/common/product-list.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Product.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    protected void search(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection conn = F.getConnection();
            String searchKey = request.getParameter("search");
            String searchSQL = "%"+searchKey+"%";
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            String sql = "SELECT CEIL( COUNT(*) / 8 ) AS totalpage FROM project LEFT OUTER JOIN user ON (project.user_id = user.id) WHERE visible = 1 AND (title LIKE ? or firstname LIKE ? or lastname LIKE ? or email LIKE ?);";
            PreparedStatement csmt = conn.prepareStatement(sql);
            csmt.setString(1, searchSQL);
            csmt.setString(2, searchSQL);
            csmt.setString(3, searchSQL);
            csmt.setString(4, searchSQL);
            ResultSet cr = csmt.executeQuery();
            cr.next();
            int totalpage = cr.getInt("totalpage");
            cr.close();
            csmt.close();

            sql = "SELECT * FROM project LEFT OUTER JOIN user ON (project.user_id = user.id) WHERE visible = 1 AND (title LIKE ? or firstname LIKE ? or lastname LIKE ? or email LIKE ?) LIMIT 8 OFFSET ?;";
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1, searchSQL);
            psmt.setString(2, searchSQL);
            psmt.setString(3, searchSQL);
            psmt.setString(4, searchSQL);
            psmt.setInt(5, (page - 1) * 8);
            ResultSet result = psmt.executeQuery();
            ArrayList<Project> list = new ArrayList();
            while (result.next()) {
                Project product = new Project(result);
                list.add(product);
            }
            
            if(totalpage == 0){
                request.setAttribute("searchMsg", "ไม่พบผลลัพธ์สำหรับการค้นหานี้");
            }
            request.setAttribute("searchKey", searchKey);
            request.setAttribute("list", list);
            request.setAttribute("totalpage", totalpage);
            request.setAttribute("currentpage", page);
            result.close();
            psmt.close();
            conn.close();
            request.getRequestDispatcher("/jsp/common/product-list.jsp").forward(request, response);
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
