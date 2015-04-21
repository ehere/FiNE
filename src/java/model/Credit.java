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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author iMEIDA
 */
public class Credit implements Serializable {

    private int id;
    private User owner;
    private double old_credit;
    private double new_credit;
    private double diff;
    private String detail;
    private User change_by;
    private String created_at;
    

    public Credit(ResultSet result) throws SQLException {

        id = result.getInt("id");
        old_credit = result.getDouble("old_credit");
        new_credit = result.getDouble("new_credit");
        diff = new_credit - old_credit;
        detail = result.getString("detail");
        created_at = result.getString("created_at");
        
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM user WHERE id = ?");
            psmt.setInt(1, result.getInt("owner_id"));
            ResultSet ownerResult = psmt.executeQuery();
            if (ownerResult.next()) {
                owner = new User(ownerResult);
            }
            ownerResult.close();
            psmt.setInt(1, result.getInt("change_by"));
            ResultSet changerResult = psmt.executeQuery();
            if (changerResult.next()) {
                change_by = new User(changerResult);
            }
            changerResult.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public double getOld_credit() {
        return old_credit;
    }

    public void setOld_credit(double old_credit) {
        this.old_credit = old_credit;
    }

    public double getNew_credit() {
        return new_credit;
    }

    public void setNew_credit(double new_credit) {
        this.new_credit = new_credit;
    }

    public double getDiff() {
        return diff;
    }

    public void setDiff(double diff) {
        this.diff = diff;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetails(String detail) {
        this.detail = detail;
    }

    public User getChange_by() {
        return change_by;
    }

    public void setChange_by(User change_by) {
        this.change_by = change_by;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
    
    
}