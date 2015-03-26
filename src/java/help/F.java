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
    
    private static String projectPath;
    
    public static String asset(String url){

        return projectPath+"/"+url.replaceAll("^/+", "").replaceAll("/+$", "");
    }

    public static String getProjectPath() {
        return projectPath;
    }

    public static void setProjectPath(String projectPath) {
        F.projectPath = projectPath;
    }
    
}