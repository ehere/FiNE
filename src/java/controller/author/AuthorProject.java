/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.author;

import controller.common.Scene;
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
import org.json.simple.JSONObject;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "AuthorProject", urlPatterns = {"/author.authorproject"})
public class AuthorProject extends HttpServlet {

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
        if (method.equals("show")) {
            show(request, response);
        } else if (method.equals("update")) {
            update(request, response);
        } else if (method.equals("allscene")) {
            allscene(request, response);
        } else if (method.equals("toggleVisble")) {
            toggleVisble(request, response);
        }
    }

    protected void show(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(id)))) {
            String[] message = {"You doesn't have permission to edit this project !", "danger"};
            session.setAttribute("message", message);
            response.sendRedirect(F.asset("/product"));
            return;
        }
        try (Connection conn = F.getConnection()) {
            PreparedStatement project_query = conn.prepareStatement("SELECT * FROM project WHERE id =?;");
            project_query.setString(1, id);
            ResultSet project_rs = project_query.executeQuery();
            project_rs.next();
            Project project = new Project(project_rs);
            request.setAttribute("project", project);
            project_rs.close();
            project_query.close();

            conn.close();
            request.getRequestDispatcher("/jsp/author/project.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Scene.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void allscene(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(id)))) {
            String[] message = {"You doesn't have permission to edit this project !", "danger"};
            session.setAttribute("message", message);
            response.sendRedirect(F.asset("/product"));
            return;
        }
        try (PrintWriter out = response.getWriter(); Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM scenario WHERE project_id =?;");
            psmt.setString(1, id);
            ResultSet result = psmt.executeQuery();
            JSONObject allscene = new JSONObject();
            while (result.next()) {
                JSONObject scene = new JSONObject();
                scene.put("title", result.getString("title"));
                allscene.put(result.getString("id"), scene);
            }
            out.print(allscene.toJSONString());
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(AuthorProject.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    protected void toggleVisble(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(id)))) {
            String[] message = {"You doesn't have permission to edit this project !", "danger"};
            session.setAttribute("message", message);
            response.sendRedirect(F.asset("/product"));
            return;
        }
        try (PrintWriter out = response.getWriter()) {
            try (Connection conn = F.getConnection()) {
                PreparedStatement toggleVisible = conn.prepareStatement("UPDATE `project` SET`visible`= ABS(`visible`-1),`updated_at`=NOW() WHERE `user_id` = ? AND `id` = ?;");
                toggleVisible.setInt(1, user.getId());
                toggleVisible.setString(2, id);
                int status = toggleVisible.executeUpdate();
                PreparedStatement visible_query = conn.prepareStatement("SELECT * FROM project WHERE `user_id` = ? AND `id` = ?;");
                visible_query.setInt(1, user.getId());
                visible_query.setString(2, id);
                ResultSet result = visible_query.executeQuery();
                result.next();
                if (result.getInt("visible") == 1 ) {
                    out.print("visible");
                } else{
                    out.print("hidden");
                }
                result.close();
                visible_query.close();
                conn.close();
            } catch (SQLException ex) {
                out.print("Fail to toggle project visible!");
                Logger.getLogger(AuthorProject.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        System.out.println(id);
        if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(id)))) {
            String[] message = {"You doesn't have permission to edit this project !", "danger"};
            session.setAttribute("message", message);
            response.sendRedirect(F.asset("/product"));
            return;
        }
        try (PrintWriter out = response.getWriter()) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            Double price = Double.parseDouble(request.getParameter("price"));
            int rate = Integer.parseInt(request.getParameter("rate"));
            String cover = request.getParameter("cover");
            int firstscene = Integer.parseInt(request.getParameter("firstscene"));
            try (Connection conn = F.getConnection()) {
                PreparedStatement update_query = conn.prepareStatement("UPDATE `project` SET `title`= ? ,`description`= ?,`price`=?,`rate`=?,`cover`=?,`first_scene_id`=?,`updated_at`=NOW() WHERE `user_id` = ? AND `id` = ?;");
                update_query.setString(1, title);
                update_query.setString(2, description);
                update_query.setDouble(3, price);
                update_query.setInt(4, rate);
                update_query.setString(5, cover);
                update_query.setInt(6, firstscene);
                update_query.setInt(7, user.getId());
                update_query.setString(8, id);
                int status = update_query.executeUpdate();
                if (status == 1) {
                    out.print("Update project success.");
                } else {
                    out.print("Fail to update project!");
                }
                conn.close();
            } catch (SQLException ex) {
                out.print("Fail to update project!");
                Logger.getLogger(AuthorProject.class.getName()).log(Level.SEVERE, null, ex);
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
