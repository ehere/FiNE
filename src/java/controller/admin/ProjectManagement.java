/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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

/**
 *
 * @author iMEIDA
 */
@WebServlet(name = "ProjectManagement", urlPatterns = {"/admin.project"})
public class ProjectManagement extends HttpServlet {

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
        } else if (method.equals("changepermission")) {
            changePermission(request, response);
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        try (Connection conn = F.getConnection()) {
            PreparedStatement pstmt;
            ArrayList<Project> projectList = new ArrayList();
            pstmt = conn.prepareStatement("SELECT * FROM project ORDER BY visible;");
            ResultSet result = pstmt.executeQuery();
            while (result.next()) {
                Project project = new Project(result);
                projectList.add(project);
            }
            result.close();
            pstmt.close();
            conn.close();
            request.setAttribute("projectList", projectList);
        } catch (SQLException ex) {
            Logger.getLogger(ProjectManagement.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher("/jsp/admin/product.jsp").forward(request, response);

    }

    protected void changePermission(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        try (Connection conn = F.getConnection()) {
            PreparedStatement pstmt;
            HttpSession session = request.getSession();
            pstmt = conn.prepareStatement("UPDATE `project` SET `visible` = ?, `dividend` = ?, `updated_at` = NOW() WHERE `id` = ?;");
            pstmt.setString(1, request.getParameter("publish"));
            pstmt.setString(2, request.getParameter("dividend"));
            pstmt.setString(3, request.getParameter("projectid"));
            int result = pstmt.executeUpdate();
            if (result > 0) {
                //success
                String[] message = {"อัพเดทเรียบร้อยแล้ว!", "success"};
                session.setAttribute("message", message);
            } else {
                //failed
                String[] message = {"มีข้อผิดพลาดเกิดขึ้น กรุณาลองอีกครั้ง!", "danger"};
                session.setAttribute("message", message);
            }
            pstmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProjectManagement.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.sendRedirect(F.asset("/admin/product"));
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
