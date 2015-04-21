/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import help.F;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class Purchased implements Serializable {

    private int id;
    private int user_id;
    private int project_id;
    private double price;
    private String created_at;
    private Project project;
    private String last_play;
    private double divident;
    private int shared;

    public Purchased(ResultSet result) throws SQLException {
        id = result.getInt("id");
        user_id = result.getInt("user_id");
        project_id = result.getInt("project_id");
        price = result.getDouble("price");
        divident = result.getDouble("divident");
        shared = result.getInt("shared");

        created_at = convertDate(result.getString("created_at"));
        
        project = null;
        last_play = null;
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM project WHERE id = ?");
            
            PreparedStatement lastplayPsmt = conn.prepareStatement("SELECT * FROM `save` JOIN activity ON (last_activity_id = activity.id) WHERE `user_id` = ? AND `last_activity_id` IN (SELECT id FROM activity WHERE scenario_id IN (SELECT id FROM scenario WHERE project_id = ? )) ORDER BY `save`.created_at DESC;");
            psmt.setInt(1, project_id);
            ResultSet projResult = psmt.executeQuery();
            if (projResult.next()) {
                project = new Project(projResult);
                lastplayPsmt.setInt(1, user_id);
                lastplayPsmt.setInt(2, project_id);
                ResultSet lastplayResult = lastplayPsmt.executeQuery();
                if(lastplayResult.next()){
                    last_play = convertDate(lastplayResult.getString("created_at"));
                    lastplayResult.close();
                }
            }
            projResult.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private String convertDate(String toConvert){
        try {
            SimpleDateFormat newDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
            Date MyDate = newDateFormat.parse(toConvert);
            newDateFormat.applyPattern("dd MMMMM yyyy HH:mm:ss");
            return newDateFormat.format(MyDate);
        } catch (ParseException ex) {
            Logger.getLogger(Purchased.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }
    
    public String getLast_play() {
        return last_play;
    }

    public void setLast_play(String last_play) {
        this.last_play = last_play;
    }

    public double getDivident() {
        return divident;
    }

    public void setDivident(double divident) {
        this.divident = divident;
    }

    public int getShared() {
        return shared;
    }

    public void setShared(int shared) {
        this.shared = shared;
    }


}
