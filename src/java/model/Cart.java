/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author iMEIDA
 */
public class Cart implements Serializable{
    ArrayList<String> items = new ArrayList();

    public ArrayList getItems() {
        return items;
    }
    
    public void addItem(String item){
        items.add(item);
    }
    
    public boolean isExist(String item){
        if(items.contains(item)){
            return true;
        }
        return false;
    }
    
    public int getItemsSize(){
        return items.size();
    }
    
    public void removeItem(String item){
        items.remove(item);
    }
}
