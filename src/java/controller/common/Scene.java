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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author tanasab
 */
@WebServlet(name = "Scene", urlPatterns = {"/scene/*"})
public class Scene extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        String pathInfo = request.getPathInfo().replaceAll("^/+", "").replaceAll("/+$", "");
        String id = pathInfo.split("/")[0];

        try (PrintWriter out = response.getWriter()) {
            PreparedStatement activity_query = F.getConnection().prepareStatement("SELECT * FROM fine.activity WHERE scenario_id = ? ORDER BY `activity`.`order` ASC;");
            activity_query.setString(1, id);
            ResultSet activities = activity_query.executeQuery();
            JSONObject activity = new JSONObject();
            JSONObject activity_data = new JSONObject();
            JSONArray activity_order = new JSONArray();
            while (activities.next()) {
                int type = activities.getInt("type");
                int activity_id = activities.getInt("id");
                activity_order.add(activity_id);
                if (type == 1) {
                    //dialog
                    PreparedStatement dialog_query = F.getConnection().prepareStatement("SELECT * FROM fine.activity_dialog WHERE activity_id = ?;");
                    dialog_query.setInt(1, activity_id);
                    ResultSet dialog = dialog_query.executeQuery();
                    dialog.next();
                    JSONObject act = new JSONObject();
                    act.put("type", type);
                    act.put("title", dialog.getString("title"));
                    act.put("text", dialog.getString("dialog").replace("^", "&#94;"));
                    if(dialog.getString("music") != null){
                        act.put("sound", F.asset("/sound/voice/" + dialog.getString("music")));
                    }else{
                        act.put("sound", "");
                    }
                    activity_data.put(activity_id + "", act);
                    dialog.close();
                    dialog_query.close();
                } else if (type == 2) {
                    // choice
                } else if (type == 3 || type == 4) {
                    //goto activity or scene
                    PreparedStatement goto_query = F.getConnection().prepareStatement("SELECT * FROM fine.activity_goto WHERE activity_id = ?;");
                    goto_query.setInt(1, activity_id);
                    ResultSet goto_act = goto_query.executeQuery();
                    goto_act.next();
                    JSONObject act = new JSONObject();
                    act.put("type", type);
                    act.put("nextnode", goto_act.getString("target_id"));
                    activity_data.put(activity_id + "", act);
                    goto_act.close();
                    goto_query.close();
                } else if (type == 5) {
                    //change background
                    PreparedStatement bg_query = F.getConnection().prepareStatement("SELECT * FROM fine.activity_media WHERE activity_id = ?;");
                    bg_query.setInt(1, activity_id);
                    ResultSet bg_act = bg_query.executeQuery();
                    bg_act.next();
                    JSONObject act = new JSONObject();
                    act.put("type", type);
                    act.put("url", F.asset("/img/bg/" + bg_act.getString("media")));
                    activity_data.put(activity_id + "", act);
                    bg_act.close();
                    bg_query.close();
                } else if (type == 6) {
                    // change music
                    PreparedStatement music_query = F.getConnection().prepareStatement("SELECT * FROM fine.activity_media WHERE activity_id = ?;");
                    music_query.setInt(1, activity_id);
                    ResultSet music_act = music_query.executeQuery();
                    music_act.next();
                    JSONObject act = new JSONObject();
                    act.put("type", type);
                    act.put("url", F.asset("/sound/bgm/" + music_act.getString("media")));
                    activity_data.put(activity_id + "", act);
                    music_act.close();
                    music_query.close();
                }
            }
            activities.close();
            activity_query.close();
            activity.put("data", activity_data.toJSONString());
            activity.put("order", activity_order.toJSONString());
            out.print(activity);
        } catch (SQLException ex) {
            Logger.getLogger(Scene.class.getName()).log(Level.SEVERE, null, ex);
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
