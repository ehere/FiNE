/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.author;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Array;
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
        }
    }

    protected void saveActivity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sceneID = (String) request.getAttribute("id");
        try (PrintWriter out = response.getWriter()) {
            String data = request.getParameter("data");
            String order = request.getParameter("order");
            JSONParser parser = new JSONParser();
            try {
                Object obj = parser.parse(data);
                JSONObject activity = (JSONObject) obj;
                obj = parser.parse(order);
                JSONArray activity_order = (JSONArray) obj;
                /*
                 for (Object i : activity_order.toArray()) {
                 if (activity.containsKey(i + "")) {
                 System.out.println(activity.get(i + ""));
                 }
                 }
                 */

                try (Connection conn = F.getConnection()) {
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
                                        update_choice.setInt(2, c+1);
                                        update_choice.setString(3, (String) activity_choice.get("text"));
                                        update_choice.setString(4, activity_choice.get("nextnode") + "");
                                        update_choice.executeUpdate();
                                        update_choice.close();
                                    }
                                } else if (type == 3 || type == 4) {
                                    PreparedStatement update_goto = conn.prepareStatement("UPDATE `activity_goto` SET `target_id` = ? WHERE `activity_id` = ?;");
                                    String nextnode = activity_data.get("nextnode") + "";
                                    update_goto.setString(1, nextnode);
                                    update_goto.setLong(2, activityID);
                                    update_goto.executeUpdate();
                                    update_goto.close();
                                } else if (type == 5 || type == 6) {
                                    PreparedStatement update_media = conn.prepareStatement("UPDATE `activity_media` SET `media`= ? WHERE `activity_id` = ?;");
                                    String url = (String) activity_data.get("url");
                                    if (!url.contains("http://") && !url.contains("https://")) {
                                        url = url.replaceFirst(F.asset("/img/bg"), "");
                                        url = url.replaceAll("^/+", "");
                                    }
                                    update_media.setString(1, url);
                                    update_media.setLong(2, activityID);
                                    update_media.executeUpdate();
                                    update_media.close();
                                }

                            }
                        } else {
                            //new activity
                        }
                    }
                    out.print("Save Success.");

                    conn.close();
                } catch (SQLException ex) {
                    out.print("Can't save this scene.");
                    Logger.getLogger(AuthorScene.class.getName()).log(Level.SEVERE, null, ex);
                }

            } catch (ParseException ex) {
                System.err.println(ex);
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
