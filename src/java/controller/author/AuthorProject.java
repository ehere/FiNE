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
        if (method.equals("index")) {
            index(request, response);
        } else if (method.equals("show")) {
            show(request, response);
        } else if (method.equals("create")) {
            create(request, response);
        } else if (method.equals("update")) {
            update(request, response);
        } else if (method.equals("destroy")) {
            destroy(request, response);
        } else if (method.equals("allscene")) {
            allscene(request, response);
        } else if (method.equals("toggleVisble")) {
            toggleVisble(request, response);
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (!F.isLoggedIn(session)) {
            String[] message = {"Please login before enter author zone.", "danger"};
            session.setAttribute("message", message);
            response.sendRedirect(F.asset("/product"));
            return;
        }
        try (Connection conn = F.getConnection()) {
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            PreparedStatement csmt = conn.prepareStatement("SELECT CEIL( COUNT(*) / 8 ) AS totalpage FROM `project` WHERE user_id = ?;");
            csmt.setInt(1, user.getId());
            ResultSet cr = csmt.executeQuery();
            cr.next();
            int totalpage = cr.getInt("totalpage");
            cr.close();
            csmt.close();

            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `project` WHERE user_id = ?  LIMIT 8 OFFSET ?;");
            psmt.setInt(1, user.getId());
            psmt.setInt(2, (page - 1) * 8);
            ResultSet result = psmt.executeQuery();
            ArrayList<Project> list = new ArrayList();
            while (result.next()) {
                Project project = new Project(result);
                list.add(project);
            }
            request.setAttribute("list", list);
            request.setAttribute("totalpage", totalpage);
            request.setAttribute("currentpage", page);
            result.close();
            psmt.close();
            conn.close();
            request.getRequestDispatcher("/jsp/author/project-list.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Scene.class.getName()).log(Level.SEVERE, null, ex);
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

    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try (PrintWriter out = response.getWriter()) {
            if (!F.isLoggedIn(session)) {
                out.print("Please login before enter author zone");
                return;
            }
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            Double price = Double.parseDouble(request.getParameter("price"));
            int rate = Integer.parseInt(request.getParameter("rate"));
            String cover = request.getParameter("cover");
            try (Connection conn = F.getConnection()) {
                PreparedStatement create_query = conn.prepareStatement("INSERT INTO `project`(`title`, `description`, `user_id`, `price`, `rate`, `cover`, `created_at`) VALUES (?,?,?,?,?,?,NOW());", PreparedStatement.RETURN_GENERATED_KEYS);
                create_query.setString(1, title);
                create_query.setString(2, description);
                create_query.setInt(3, user.getId());
                create_query.setDouble(4, price);
                create_query.setInt(5, rate);
                create_query.setString(6, cover);
                int status = create_query.executeUpdate();
                if (status == 1) {
                    ResultSet rs = create_query.getGeneratedKeys();
                    if (rs != null && rs.next()) {
                        out.print("Create project success.|" + rs.getLong(1));
                    }
                } else {
                    out.print("Fail to create project!");
                }
                conn.close();
            } catch (SQLException ex) {
                out.print("Fail to create project!");
                Logger.getLogger(AuthorProject.class.getName()).log(Level.SEVERE, null, ex);
            }
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
                //check firstscene before set visible
                PreparedStatement project_query = conn.prepareStatement("SELECT * FROM project WHERE id =?;");
                project_query.setString(1, id);
                ResultSet project_rs = project_query.executeQuery();
                project_rs.next();
                Project project = new Project(project_rs);
                project_rs.close();
                project_query.close();

                if (validateScene(Integer.parseInt(id), project.getFirst_scene_id())) {
                    PreparedStatement toggleVisible = conn.prepareStatement("UPDATE `project` SET`visible`= ABS(`visible`-1),`updated_at`=NOW() WHERE `user_id` = ? AND `id` = ?;");
                    toggleVisible.setInt(1, user.getId());
                    toggleVisible.setString(2, id);
                    int status = toggleVisible.executeUpdate();
                    PreparedStatement visible_query = conn.prepareStatement("SELECT * FROM project WHERE `user_id` = ? AND `id` = ?;");
                    visible_query.setInt(1, user.getId());
                    visible_query.setString(2, id);
                    ResultSet result = visible_query.executeQuery();
                    result.next();
                    if (result.getInt("visible") == 1) {
                        out.print("visible");
                    } else {
                        out.print("hidden");
                    }
                    result.close();
                    visible_query.close();
                }else{
                    out.print("Please set project first scene in setting!");
                }

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

    protected void destroy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(Integer.parseInt(id)))) {
            String[] message = {"You doesn't have permission to remove this project !", "danger"};
            session.setAttribute("message", message);
            response.sendRedirect(F.asset("/author/project"));
            return;
        }
        try (PrintWriter out = response.getWriter()) {
            try (Connection conn = F.getConnection()) {
                PreparedStatement remove_query = conn.prepareStatement("DELETE  FROM `project` WHERE `user_id` = ? AND `id` = ?;");
                remove_query.setInt(1, user.getId());
                remove_query.setString(2, id);
                int status = remove_query.executeUpdate();
                if (status == 1) {
                    String[] message = {"Remove project success!", "success"};
                    session.setAttribute("message", message);
                } else {
                    String[] message = {"You doesn't have permission to remove this project !", "danger"};
                    session.setAttribute("message", message);
                }
                conn.close();
                response.sendRedirect(F.asset("/author/project"));
            } catch (SQLException ex) {
                String[] message = {"Fail to remove project!", "success"};
                session.setAttribute("message", message);
                response.sendRedirect(F.asset("/author/project"));
                Logger.getLogger(AuthorProject.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    protected boolean validateScene(Integer projectID, Integer sceneID) {
        if (projectID != null && sceneID != null) {
            try (Connection conn = F.getConnection()) {
                PreparedStatement psmt = conn.prepareStatement("SELECT `project_id` FROM `scenario` WHERE `id` = ? AND`project_id` = ?;");
                psmt.setInt(1, sceneID);
                psmt.setInt(2, projectID);
                ResultSet result = psmt.executeQuery();
                boolean status = false;
                if (result.next()) {
                    status = true;
                }
                result.close();
                psmt.close();
                conn.close();
                return status;
            } catch (SQLException ex) {
                Logger.getLogger(AuthorProject.class.getName()).log(Level.SEVERE, null, ex);
                return false;
            }
        }
        return false;
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
