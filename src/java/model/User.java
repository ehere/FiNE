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
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class User implements Serializable {

    private int id;
    private String prefix;
    private String firstname;
    private String lastname;
    private String email;
    private String password;
    private String birthday;
    private int role;
    private String image;
    private String created_at;
    private String updated_at;
    private int age;

    public User(ResultSet result) throws SQLException {
        id = result.getInt("id");
        prefix = result.getString("prefix");
        firstname = result.getString("firstname");
        lastname = result.getString("lastname");
        email = result.getString("email");
        password = result.getString("password");
        birthday = F.convertDate(result.getString("birthday"), "dd MMMMM yyyy");
        role = result.getInt("role");
        image = result.getString("image");
        created_at = F.convertDate(result.getString("created_at"), "dd MMMMM yyyy");
        updated_at = F.convertDate(result.getString("updated_at"), "dd MMMMM yyyy");
        age = initAge();
    }

    public String getFullname() {
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

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getImage() {
        if(image == null){
            return F.asset("/img/service-icon/user.png");
        }
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

    public int getAge() {
        return age;
    }

    public ArrayList<Project> getPurchaseProject() {
        ArrayList<Project> list = new ArrayList();
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM project WHERE id IN (SELECT project_id FROM purchase WHERE user_id = ?);");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            while (result.next()) {
                Project project = new Project(result);
                list.add(project);
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Integer> getPurchaseProjectID() {
        ArrayList<Integer> list = new ArrayList();
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT project_id FROM purchase WHERE user_id = ?;");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            while (result.next()) {
                list.add(result.getInt("project_id"));
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Project> getOwnProject() {
        ArrayList<Project> list = new ArrayList();
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM project WHERE user_id = ?;");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            while (result.next()) {
                Project project = new Project(result);
                list.add(project);
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Integer> getOwnProjectID() {
        ArrayList<Integer> list = new ArrayList();
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT id FROM project WHERE user_id = ?;");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            while (result.next()) {
                list.add(result.getInt("id"));
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Project> getLatestOwnProject() {
        ArrayList<Project> list = new ArrayList();
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `project` WHERE `user_id` = ? ORDER BY `created_at` DESC LIMIT 0, 12;");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            while (result.next()) {
                Project project = new Project(result);
                list.add(project);
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Integer> getLatestOwnProjectID() {
        ArrayList<Integer> list = new ArrayList();
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT id FROM `project` WHERE `user_id` = ? ORDER BY `created_at` DESC LIMIT 0, 12;");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            while (result.next()) {
                list.add(result.getInt("id"));
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int initAge() {
        int age = 0;
        try (Connection conn = F.getConnection()) {
            PreparedStatement psmt = conn.prepareStatement("SELECT TIMESTAMPDIFF(YEAR, `birthday`, CURDATE()) AS AGE FROM `user` WHERE `id` = ?;");
            psmt.setInt(1, id);
            ResultSet result = psmt.executeQuery();
            if (result.next()) {
                age = result.getInt("AGE");
            }
            result.close();
            psmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Project.class.getName()).log(Level.SEVERE, null, ex);
        }
        return age;
    }

    public boolean isAdmin() {
        if (this.role >= 70) {
            return true;
        }
        return false;
    }
}
