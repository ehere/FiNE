/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package listener;

import help.F;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

/**
 * Web application lifecycle listener.
 *
 * @author tanasab
 */
public class Init implements ServletContextListener {
    //private Connection conn;
    private DataSource datasource;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        F.setProjectPath(sce.getServletContext().getContextPath());
        try {
            F.setDatasource(getDbfine());
        } catch (NamingException ex) {
            Logger.getLogger(Init.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }

    private DataSource getDbfine() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/dbfine");
    }
}
