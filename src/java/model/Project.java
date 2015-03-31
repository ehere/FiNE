/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import help.F;
import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;


/**
 *
 * @author tanasab
 */
public class Project implements Serializable{
    private int id;
    private String title;
    private String description;
    private int user_id;
    private double price;
    private int visible;
    private int rate;
    private String cover;
    private int first_scene_id;
    private String created_at;
    private String updated_at;
    
    public Project(ResultSet result) throws SQLException{
        
        id = result.getInt("id");
        title = result.getString("title");
        description = result.getString("description");
        price = result.getDouble("price");
        visible = result.getInt("visible");
        rate = result.getInt("rate");
        cover = result.getString("cover");
        first_scene_id = result.getInt("first_scene_id");
        created_at = result.getString("created_at");
        updated_at = result.getString("updated_at");

    }

    public int getFirst_scene_id() {
        return first_scene_id;
    }

    public void setFirst_scene_id(int first_scene_id) {
        this.first_scene_id = first_scene_id;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getVisible() {
        return visible;
    }

    public void setVisible(int visible) {
        this.visible = visible;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public String getCover() {
        return F.asset("img/cover/"+cover);
    }

    public void setCover(String cover) {
        this.cover = cover;
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

    public void setUpdated_at(String update_at) {
        this.updated_at = update_at;
    }
}
