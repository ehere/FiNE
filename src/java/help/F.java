/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package help;

import java.io.Serializable;

/**
 *
 * @author tanasab
 */
public class F implements Serializable{
    public static String asset(String url){
        String path = F.class.getResource("").getPath();
        path = path.replace("build/web/WEB-INF/classes/help/", "").replaceAll("^/+", "").replaceAll("/+$", "");
        path = path.substring(path.lastIndexOf('/') + 1);
        return "/"+path+"/"+url.replaceAll("^/+", "").replaceAll("/+$", "");
    }
    
}