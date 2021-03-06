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
import model.User;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "AuthorScene", urlPatterns = {"/common.authorscene"})
public class AuthorScene extends HttpServlet {

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
        if (method.equals("saveActivity")) {
            saveActivity(request, response);
        } else if (method.equals("create")) {
            create(request, response);
        } else if (method.equals("update")) {
            update(request, response);
        } else if (method.equals("destroy")) {
            destroy(request, response);
        }
    }

    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int projectID = Integer.parseInt(request.getParameter("project"));
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String title = (String) request.getParameter("title");
        String description = (String) request.getParameter("description");
        try (PrintWriter out = response.getWriter()) {
            if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(projectID))) {
                out.print("You doesn't have permission to create scene in this project !");
                return;
            }
            try (Connection conn = F.getConnection()) {
                PreparedStatement create_scene = conn.prepareStatement("INSERT INTO `scenario`(`project_id`, `title`, `description`, `created_at`) VALUES (?,?,?,NOW());");
                create_scene.setInt(1, projectID);
                create_scene.setString(2, title);
                create_scene.setString(3, description);
                int result = create_scene.executeUpdate();
                if (result == 1) {
                    out.print("Create Scene Success.");
                } else {
                    out.print("Something Wrong! Can't create new scene.");
                }
                create_scene.close();
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(AuthorScene.class.getName()).log(Level.SEVERE, null, ex);
                out.print("Something Wrong! Can't create new scene.");
            }
        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sceneID = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String title = (String) request.getParameter("title");
        String description = (String) request.getParameter("description");
        try (PrintWriter out = response.getWriter()) {
            try (Connection conn = F.getConnection()) {
                PreparedStatement update_scene = conn.prepareStatement("UPDATE `scenario` SET `title`=?,`description`= ? ,`updated_at`= NOW() WHERE `id` = ? AND `project_id` IN (SELECT `id` FROM project WHERE user_id = ?);");
                update_scene.setString(1, title);
                update_scene.setString(2, description);
                update_scene.setString(3, sceneID);
                update_scene.setInt(4, user.getId());
                int result = update_scene.executeUpdate();
                if (result == 1) {
                    out.print("Update Scene Success.");
                } else {
                    out.print("Something Wrong! Can't update scene.");
                }
                update_scene.close();
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(AuthorScene.class.getName()).log(Level.SEVERE, null, ex);
                out.print("Something Wrong! Can't update scene.");
            }
        }
    }

    protected void destroy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sceneID = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        try (PrintWriter out = response.getWriter()) {
            try (Connection conn = F.getConnection()) {
                PreparedStatement remove_scene = conn.prepareStatement("DELETE FROM `scenario` WHERE `id` = ? AND `project_id` IN (SELECT `id` FROM project WHERE user_id = ?);");
                remove_scene.setString(1, sceneID);
                remove_scene.setInt(2, user.getId());
                int result = remove_scene.executeUpdate();
                if (result == 1) {
                    out.print("Remove Scene Success.");
                } else {
                    out.print("Something Wrong! Can't remove scene.");
                }
                remove_scene.close();
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(AuthorScene.class.getName()).log(Level.SEVERE, null, ex);
                out.print("Something Wrong! Can't remove scene.");
            }
        }
    }

    protected void saveActivity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sceneID = (String) request.getAttribute("id");
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {
            String data = request.getParameter("data");
            String order = request.getParameter("order");
            JSONParser parser = new JSONParser();
            try {
                Object obj = parser.parse(data);
                JSONObject activity = (JSONObject) obj;
                obj = parser.parse(order);
                JSONArray activity_order = (JSONArray) obj;

                try (Connection conn = F.getConnection()) {
                    //check permission
                    PreparedStatement project_query = conn.prepareStatement("SELECT `project_id` FROM `scenario` WHERE `id` = ?;");
                    project_query.setString(1, sceneID);
                    ResultSet project_rs = project_query.executeQuery();
                    project_rs.next();
                    int projectID = project_rs.getInt("project_id");
                    project_rs.close();
                    project_query.close();
                    User user = (User) session.getAttribute("user");
                    if (!F.isLoggedIn(session) || !(user.getOwnProjectID().contains(projectID))) {
                        out.print("You doesn't have permission to edit this project !");
                        conn.close();
                        return;
                    }
                    //remove unwant activity
                    String sql = "DELETE FROM activity WHERE scenario_id = ? AND id NOT IN (";
                    for (int i = 0; i < activity_order.size() - 1; i++) {
                        sql = sql + "?,";
                    }
                    sql = sql + "?);";
                    PreparedStatement remove_psmt = conn.prepareStatement(sql);
                    remove_psmt.setString(1, sceneID);
                    for (int i = 0; i < activity_order.size(); i++) {
                        remove_psmt.setLong(i + 2, (long) activity_order.get(i));
                    }
                    remove_psmt.executeUpdate();
                    remove_psmt.close();
                    //finish remove
                    for (int i = 0; i < activity_order.size(); i++) {
                        Long activityID = (Long) activity_order.get(i);
                        if (activityID >= 0) {
                            //update activity
                            if (activity.containsKey(activityID + "")) {
                                JSONObject activity_data = (JSONObject) activity.get(activityID + "");
                                Long type = (Long) activity_data.get("type");
                                //update type and order
                                PreparedStatement update_act_type = conn.prepareStatement("UPDATE `activity` SET `type`= ? ,`order` = ? , `updated_at`= NOW() WHERE `id` = ?;");
                                update_act_type.setLong(1, type);
                                update_act_type.setLong(2, i + 1);
                                update_act_type.setLong(3, activityID);
                                update_act_type.executeUpdate();
                                update_act_type.close();
                                if (type == 1) {
                                    PreparedStatement update_dialog = conn.prepareStatement("UPDATE `activity_dialog` SET `title`=? ,`dialog`= ? ,`music`= ? WHERE `activity_id` = ?;");
                                    String title = (String) activity_data.get("title");
                                    String text = (String) activity_data.get("text");
                                    String sound = (String) activity_data.get("sound");
                                    if (!sound.contains("http://") && !sound.contains("https://")) {
                                        sound = sound.replaceFirst(F.asset("/sound/voice/"), "");
                                        sound = sound.replaceAll("^/+", "");
                                    }
                                    update_dialog.setString(1, title);
                                    update_dialog.setString(2, text);
                                    update_dialog.setString(3, sound);
                                    update_dialog.setLong(4, activityID);
                                    update_dialog.executeUpdate();
                                    update_dialog.close();
                                } else if (type == 2) {
                                    JSONArray activity_choices = (JSONArray) activity_data.get("choice");
                                    //remove unwanted choice
                                    PreparedStatement remove_choice = conn.prepareStatement("DELETE FROM `activity_choice` WHERE `activity_id` = ?;");
                                    remove_choice.setLong(1, activityID);
                                    remove_choice.executeUpdate();
                                    remove_choice.close();
                                    for (int c = 0; c < activity_choices.size(); c++) {
                                        JSONObject activity_choice = (JSONObject) activity_choices.get(c);
                                        PreparedStatement update_choice = conn.prepareStatement("INSERT INTO `activity_choice`(`activity_id`, `order`, `text`, `target_id`) VALUES (?,?,?,?);");
                                        update_choice.setLong(1, activityID);
                                        update_choice.setInt(2, c + 1);
                                        update_choice.setString(3, (String) activity_choice.get("text"));
                                        update_choice.setString(4, activity_choice.get("nextnode") + "");
                                        update_choice.executeUpdate();
                                        update_choice.close();
                                    }
                                } else if (type == 3) {
                                    PreparedStatement update_goto = conn.prepareStatement("UPDATE `activity_goto` SET `target_id` = ? WHERE `activity_id` = ?;");
                                    String nextnode = activity_data.get("nextnode") + "";
                                    update_goto.setString(1, nextnode);
                                    update_goto.setLong(2, activityID);
                                    update_goto.executeUpdate();
                                    update_goto.close();
                                } else if (type == 4) {
                                    PreparedStatement update_goto = conn.prepareStatement("UPDATE `activity_goto` SET `target_id` = ? WHERE `activity_id` = ?;");
                                    String nextnode = activity_data.get("nextnode") + "";
                                    if (!validateScene(projectID, Integer.parseInt(nextnode))) {
                                        update_goto.setNull(1, java.sql.Types.INTEGER);
                                        out.println("You don't have scene "+nextnode+". Change to 0");
                                        out.println("Please fix go to scene 0 in activity.");
                                    }else{
                                        update_goto.setString(1, nextnode);
                                    }
                                    update_goto.setLong(2, activityID);
                                    update_goto.executeUpdate();
                                    update_goto.close();
                                } else if (type == 5 || type == 6) {
                                    PreparedStatement update_media = conn.prepareStatement("UPDATE `activity_media` SET `media`= ? WHERE `activity_id` = ?;");
                                    String url = (String) activity_data.get("url");
                                    if (!url.contains("http://") && !url.contains("https://")) {
                                        String[] temp = url.split("/");
                                        url = temp[temp.length - 1];
                                    }
                                    update_media.setString(1, url);
                                    update_media.setLong(2, activityID);
                                    update_media.executeUpdate();
                                    update_media.close();
                                }

                            }
                        } else {
                            //new activity
                            if (activity.containsKey(activityID + "")) {
                                JSONObject activity_data = (JSONObject) activity.get(activityID + "");
                                Long type = (Long) activity_data.get("type");
                                //update type and order
                                Long newActivityID = new Long(0);
                                PreparedStatement new_act = conn.prepareStatement("INSERT INTO `activity`(`scenario_id`,`order`, `type`, `created_at`) VALUES (?,?,?,NOW());", PreparedStatement.RETURN_GENERATED_KEYS);
                                new_act.setString(1, sceneID);
                                new_act.setLong(2, i + 1);
                                new_act.setLong(3, type);
                                new_act.executeUpdate();
                                ResultSet rs = new_act.getGeneratedKeys();
                                if (rs != null && rs.next()) {
                                    newActivityID = rs.getLong(1);
                                }
                                rs.close();
                                new_act.close();
                                if (type == 1) {
                                    PreparedStatement new_dialog = conn.prepareStatement("INSERT INTO `activity_dialog`(`activity_id`, `title`, `dialog`, `music`) VALUES (?,?,?,?);");
                                    String title = (String) activity_data.get("title");
                                    String text = (String) activity_data.get("text");
                                    String sound = (String) activity_data.get("sound");
                                    if (!sound.contains("http://") && !sound.contains("https://")) {
                                        sound = sound.replaceFirst(F.asset("/sound/voice/"), "");
                                        sound = sound.replaceAll("^/+", "");
                                    }
                                    new_dialog.setLong(1, newActivityID);
                                    new_dialog.setString(2, title);
                                    new_dialog.setString(3, text);
                                    new_dialog.setString(4, sound);
                                    new_dialog.executeUpdate();
                                    new_dialog.close();
                                } else if (type == 2) {
                                    JSONArray activity_choices = (JSONArray) activity_data.get("choice");
                                    for (int c = 0; c < activity_choices.size(); c++) {
                                        JSONObject activity_choice = (JSONObject) activity_choices.get(c);
                                        PreparedStatement update_choice = conn.prepareStatement("INSERT INTO `activity_choice`(`activity_id`, `order`, `text`, `target_id`) VALUES (?,?,?,?);");
                                        update_choice.setLong(1, newActivityID);
                                        update_choice.setInt(2, c + 1);
                                        update_choice.setString(3, (String) activity_choice.get("text"));
                                        update_choice.setString(4, activity_choice.get("nextnode") + "");
                                        update_choice.executeUpdate();
                                        update_choice.close();
                                    }
                                } else if (type == 3) {
                                    PreparedStatement update_goto = conn.prepareStatement("INSERT INTO `activity_goto`(`activity_id`, `target_id`) VALUES (?,?);");
                                    String nextnode = activity_data.get("nextnode") + "";
                                    update_goto.setLong(1, newActivityID);
                                    update_goto.setString(2, nextnode);
                                    update_goto.executeUpdate();
                                    update_goto.close();
                                } else if (type == 4) {
                                    PreparedStatement update_goto = conn.prepareStatement("INSERT INTO `activity_goto`(`activity_id`, `target_id`) VALUES (?,?);");
                                    String nextnode = activity_data.get("nextnode") + "";
                                    update_goto.setLong(1, newActivityID);
                                    if (!validateScene(projectID, Integer.parseInt(nextnode))) {
                                        update_goto.setNull(2, java.sql.Types.INTEGER);
                                        out.println("You don't have scene "+nextnode+". Change to 0");
                                        out.println("Please fix go to scene 0 in activity.");
                                    }else{
                                        update_goto.setString(2, nextnode);
                                    }
                                    update_goto.executeUpdate();
                                    update_goto.close();
                                } else if (type == 5 || type == 6) {
                                    PreparedStatement update_media = conn.prepareStatement("INSERT INTO `activity_media`(`activity_id`, `media`) VALUES (?,?);");
                                    String url = (String) activity_data.get("url");
                                    if (!url.contains("http://") && !url.contains("https://")) {
                                        url = url.replaceFirst(F.asset("/img/bg"), "");
                                        url = url.replaceAll("^/+", "");
                                    }
                                    update_media.setLong(1, newActivityID);
                                    update_media.setString(2, url);
                                    update_media.executeUpdate();
                                    update_media.close();
                                }
                            }
                        }
                    }
                    out.print("Save Success.");

                    conn.close();
                } catch (SQLException ex) {
                    out.print("Something Wrong. we can't save this scene!");
                    Logger.getLogger(AuthorScene.class.getName()).log(Level.SEVERE, null, ex);
                }

            } catch (ParseException ex) {
                System.err.println(ex);
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
