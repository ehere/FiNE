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
 * @author Administrator
 */
public class User implements Serializable{
    private int id;
    private String prefix;
    private String firstname;
    private String lastname;
    private String email;
    private String password;
    private String birthday;
    private String role;
    private String image;
    private String created_at;
    private String updated_at;

    public User(ResultSet result) throws SQLException{
        id = result.getInt("id");
        prefix = result.getString("prefix");
        firstname = result.getString("firstname");
        lastname = result.getString("lastname");
        email = result.getString("email");
        password = result.getString("password");
        birthday = result.getString("birthday");
        role = result.getString("role");
        image = result.getString("image");
        created_at = result.getString("created_at");
        updated_at = result.getString("updated_at");

    }
    
    public String getFullname(){
        return firstname + " " + lastname;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getCredit() {
        String credit = "0.00";
        
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT credit FROM user WHERE id = ?");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            if (result.next()) {
                credit = String.format("%.2f", result.getDouble("credit"));
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return credit;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }
    
    
    
    
}
