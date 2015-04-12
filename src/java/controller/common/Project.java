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

@WebServlet(name = "Project", urlPatterns = {"/common.project"})
public class Project extends HttpServlet {

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
        
        if (method.equals("play")) {
            play(request, response);
        }

    }

    protected void play(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(Connection conn = F.getConnection();) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            String id = (String) request.getAttribute("id");
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM project WHERE id = ?;");
            psmt.setString(1, id);
            ResultSet result = psmt.executeQuery();
            result.next();
            model.Project product = new model.Project(result);
            if( F.isLoggedIn(session) && 
                (user.getPurchaseProjectID().contains(product.getId()) || user.getOwnProjectID().contains(product.getId()))
              ){
                request.setAttribute("product", product);
                request.getRequestDispatcher("/jsp/common/product-play.jsp").forward(request, response);
            }else{
                response.sendRedirect(F.asset("/product/"+product.getId()+"/view"));
            }
               
            result.close();
            psmt.close();
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
