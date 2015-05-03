/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.author;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
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
import model.Project;
import model.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "SceneRelation", urlPatterns = {"/author.scenerelation"})
public class SceneRelation extends HttpServlet {

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
        if (method.equals("sceneRelation")) {
            sceneRelation(request, response);
        } else if (method.equals("viewRelation")) {
            viewRelation(request, response);
        }
    }

    protected void viewRelation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String projectID = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (PrintWriter out = response.getWriter()) {
            if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(projectID)))) {
                String[] message = {"You doesn't have permission to view this project relationship!", "danger"};
                session.setAttribute("message", message);
                response.sendRedirect(F.asset("/product"));
                return;
            }
            try (Connection conn = F.getConnection()) {
                PreparedStatement project_query = conn.prepareStatement("SELECT * FROM project WHERE id =?;");
                project_query.setString(1, projectID);
                ResultSet project_rs = project_query.executeQuery();
                project_rs.next();
                Project project = new Project(project_rs);
                request.setAttribute("project", project);
                project_rs.close();
                project_query.close();
                conn.close();
                request.getRequestDispatcher("/jsp/author/relationship.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(SceneRelation.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected void sceneRelation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String projectID = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (PrintWriter out = response.getWriter()) {
            if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(projectID)))) {
                out.print("You doesn't have permission to view this project relationship!");
                return;
            }
            try (Connection conn = F.getConnection()) {
                PreparedStatement project_query = conn.prepareStatement("SELECT * FROM project WHERE id =?;");
                project_query.setString(1, projectID);
                ResultSet project_rs = project_query.executeQuery();
                project_rs.next();
                Project project = new Project(project_rs);
                request.setAttribute("project", project);
                project_rs.close();
                project_query.close();

                PreparedStatement scene_query = conn.prepareStatement("SELECT *  FROM `scenario` WHERE `project_id` = ?;");
                scene_query.setString(1, projectID);
                ResultSet scenes = scene_query.executeQuery();
                JSONArray list = new JSONArray();
                PreparedStatement activity_query = conn.prepareStatement("SELECT * FROM `activity` JOIN activity_goto ON activity.id = activity_goto.activity_id  WHERE `scenario_id` = ? AND `type` = 4;");
                while (scenes.next()) {
                    activity_query.setInt(1, scenes.getInt("id"));
                    ResultSet activities = activity_query.executeQuery();
                    
                    int count = 0;
                    while (activities.next()) {
                        JSONObject data = new JSONObject();
                        count = count + 1;
                        data.put("node", scenes.getInt("id"));
                        data.put("title", scenes.getString("title"));
                        data.put("nextnode", activities.getString("target_id"));
                        if (scenes.getInt("id") == project.getFirst_scene_id()) {
                            data.put("first", true);
                        }
                        list.add(data);
                    }
                    if (count == 0) {
                        JSONObject data = new JSONObject();
                        data.put("node", scenes.getInt("id"));
                        data.put("title", scenes.getString("title"));
                        data.put("nextnode", false);
                        if (scenes.getInt("id") == project.getFirst_scene_id()) {
                            data.put("first", true);
                        }
                        list.add(data);
                    }
                    activities.close();
                    
                }
                out.print(list.toJSONString());
                activity_query.close();
                scenes.close();
                scene_query.close();
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(SceneRelation.class.getName()).log(Level.SEVERE, null, ex);
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
