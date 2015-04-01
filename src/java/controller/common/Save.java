/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.common;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.json.simple.JSONObject;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "Save", urlPatterns = {"/save"})
public class Save extends HttpServlet {

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
        HttpSession session = request.getSession(true);

        User user = (User) session.getAttribute("user");
        JSONObject respond = new JSONObject();
        respond.put("status", false);
        try (PrintWriter out = response.getWriter()) {
            if (request.getParameter("action").equals("view")) {
                PreparedStatement allsave_query = F.getConnection().prepareStatement("SELECT * FROM `save` WHERE `user_id` = ? AND `last_activity_id` IN (SELECT id FROM activity WHERE scenario_id IN (SELECT id FROM scenario WHERE project_id = ? ));");
                allsave_query.setInt(1, user.getId());
                allsave_query.setString(2, request.getParameter("project"));
                ResultSet allsave = allsave_query.executeQuery();
                JSONObject data = new JSONObject();
                int count = 0;
                while (allsave.next()) {
                    JSONObject save = new JSONObject();
                    save.put("last_activity_id", allsave.getInt("last_activity_id"));
                    save.put("name", allsave.getString("name"));
                    save.put("memo", allsave.getString("memo"));
                    save.put("created_at", allsave.getString("created_at"));
                    save.put("bg", allsave.getString("bg"));
                    save.put("music", allsave.getString("music"));
                    data.put(allsave.getString("id"), save);
                    count += 1;
                }
                if(count > 0){
                    respond.put("status", true);
                    respond.put("data", data);
                }
            }
            else if(request.getParameter("action").equals("newsave")) {
                PreparedStatement newsave_query = F.getConnection().prepareStatement("INSERT INTO `save`(`user_id`, `name`, `memo`, `last_activity_id`, `bg`, `music`) VALUES (?,?,?,?,?,?);");
                newsave_query.setInt(1, user.getId());
                newsave_query.setString(2, request.getParameter("name"));
                newsave_query.setString(3, request.getParameter("memo"));
                newsave_query.setString(4, request.getParameter("activity"));
                newsave_query.setString(5, request.getParameter("bg"));
                newsave_query.setString(6, request.getParameter("music"));
                int status = newsave_query.executeUpdate();
                if(status == 1){
                    respond.put("status", true);
                }
            }
            else if(request.getParameter("action").equals("replace")) {
                PreparedStatement newsave_query = F.getConnection().prepareStatement("UPDATE `save` SET `name`= ? ,`memo`= ?,`last_activity_id`= ? ,`bg`= ? ,`music`= ? WHERE `id` = ?;");
                newsave_query.setString(2, request.getParameter("name"));
                newsave_query.setString(3, request.getParameter("memo"));
                newsave_query.setString(4, request.getParameter("activity"));
                newsave_query.setString(5, request.getParameter("bg"));
                newsave_query.setString(6, request.getParameter("music"));
                int status = newsave_query.executeUpdate();
                if(status == 1){
                    respond.put("status", true);
                }
            }
            out.print(respond);
        } catch (SQLException ex) {
            Logger.getLogger(Save.class.getName()).log(Level.SEVERE, null, ex);
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