/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filter;

import help.F;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author tanasab
 */
public class Route implements Filter {

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    private void routing(HttpServletRequest request, HttpServletResponse response, String url) throws IOException, ServletException {
        HttpSession session = request.getSession();
        //Register route here
        if (F.isUrlMatch("/", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/common.main").forward(request, response);
        }
        else if (F.isUrlMatch("/product", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/common.product").forward(request, response);
        } 
        else if (F.isUrlMatch("/product/{id}/view", url)) {
            request.setAttribute("do", "view");
            F.urlMapper("/product/{id}/view", url, request);
            request.getRequestDispatcher("/common.product").forward(request, response);
        }
        else if (F.isUrlMatch("/project/{id}/play", url)) {
            request.setAttribute("do", "play");
            F.urlMapper("/project/{id}/play", url, request);
            request.getRequestDispatcher("/common.project").forward(request, response);
        }
        else if (F.isUrlMatch("/register", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/common.register").forward(request, response);
        }
        else if (F.isUrlMatch("/register/add", url)) {
            request.setAttribute("do", "add");
            request.getRequestDispatcher("/common.register").forward(request, response);
        }
        else if (F.isUrlMatch("/login", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/common.login").forward(request, response);
        }
        else if (F.isUrlMatch("/login.do", url)) {
            request.setAttribute("do", "authen");
            request.getRequestDispatcher("/common.login").forward(request, response);
        }
        else if (F.isUrlMatch("/inventory", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/common.inventory").forward(request, response);
        }        
        else if (F.isUrlMatch("/save", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/common.save").forward(request, response);
        }
        else if (F.isUrlMatch("/scene/{id}", url)) {
            request.setAttribute("do", "index");
            F.urlMapper("/scene/{id}", url, request);
            request.getRequestDispatcher("/common.scene").forward(request, response);
        }
        else if (F.isUrlMatch("/scene/{id}/activity", url)) {
            request.setAttribute("do", "activity");
            F.urlMapper("/scene/{id}/activity", url, request);
            request.getRequestDispatcher("/common.scene").forward(request, response);
        }
        else if (F.isUrlMatch("/profile/edit", url)) {
            request.getRequestDispatcher("/jsp/common/profile-edit.jsp").forward(request, response);
        }
        else if (F.isUrlMatch("/profile/change", url)) {
            request.setAttribute("do", "edit");
            request.getRequestDispatcher("/common.profile").forward(request, response);
        }
        else if (F.isUrlMatch("/profile/{id}", url)) {
            request.setAttribute("do", "view");
            F.urlMapper("/profile/{id}", url, request);
            request.getRequestDispatcher("/common.profile").forward(request, response);
        }
        else if (F.isUrlMatch("/profile", url)) {
            request.setAttribute("do", "view");
            request.getRequestDispatcher("/common.profile").forward(request, response);
        }
        
        //Author section
        else if (F.isUrlMatch("/author/project", url)) {
            request.setAttribute("do", "index");
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/project/create", url)) {
            request.setAttribute("do", "create");
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/project/{id}", url)) {
            request.setAttribute("do", "show");
            F.urlMapper("/author/project/{id}", url, request);
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/project/{id}/update", url)) {
            request.setAttribute("do", "update");
            F.urlMapper("/author/project/{id}/update", url, request);
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/project/{id}/destroy", url)) {
            request.setAttribute("do", "destroy");
            F.urlMapper("/author/project/{id}/destroy", url, request);
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/project/{id}/allscene", url)) {
            request.setAttribute("do", "allscene");
            F.urlMapper("/author/project/{id}/allscene", url, request);
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/project/{id}/togglevisible", url)) {
            request.setAttribute("do", "toggleVisble");
            F.urlMapper("/author/project/{id}/togglevisible", url, request);
            request.getRequestDispatcher("/author.authorproject").forward(request, response);
        }
        else if (F.isUrlMatch("/author/scene/{id}/saveactivity", url)) {
            request.setAttribute("do", "saveActivity");
            F.urlMapper("/author/scene/{id}/saveactivity", url, request);
            request.getRequestDispatcher("/common.authorscene").forward(request, response);
        }
        else if (F.isUrlMatch("/author/scene/create", url)) {
            request.setAttribute("do", "create");
            request.getRequestDispatcher("/common.authorscene").forward(request, response);
        }
        else if (F.isUrlMatch("/author/scene/{id}/update", url)) {
            request.setAttribute("do", "update");
            F.urlMapper("/author/scene/{id}/update", url, request);
            request.getRequestDispatcher("/common.authorscene").forward(request, response);
        }
        else if (F.isUrlMatch("/author/scene/{id}/destroy", url)) {
            request.setAttribute("do", "destroy");
            F.urlMapper("/author/scene/{id}/destroy", url, request);
            request.getRequestDispatcher("/common.authorscene").forward(request, response);
        }
        
        //Admin section
        else if (F.isAdmin(session)){
            if (F.isUrlMatch("/admin/user/changecredit", url)) {
                request.setAttribute("do", "changecredit");
                request.getRequestDispatcher("/admin.user").forward(request, response);
            }
            else if (F.isUrlMatch("/admin/user", url)) {
                request.setAttribute("do", "index");
                request.getRequestDispatcher("/admin.user").forward(request, response);
            }
            else if (F.isUrlMatch("/admin/product/changepermission", url)) {
                request.setAttribute("do", "changepermission");
                request.getRequestDispatcher("/admin.project").forward(request, response);
            }
            else if (F.isUrlMatch("/admin/product", url)) {
                request.setAttribute("do", "index");
                request.getRequestDispatcher("/admin.project").forward(request, response);
            }
            else if (F.isUrlMatch("/admin", url)) {
                request.getRequestDispatcher("/jsp/admin/header.jsp").forward(request, response);
            }
        }
        
    }

    public Route() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("Route:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
	/*
         for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
         String name = (String)en.nextElement();
         String values[] = request.getParameterValues(name);
         int n = values.length;
         StringBuffer buf = new StringBuffer();
         buf.append(name);
         buf.append("=");
         for(int i=0; i < n; i++) {
         buf.append(values[i]);
         if (i < n-1)
         buf.append(",");
         }
         log(buf.toString());
         }
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("Route:DoAfterProcessing");
        }

	// Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
	/*
         for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
         String name = (String)en.nextElement();
         Object value = request.getAttribute(name);
         log("attribute: " + name + "=" + value.toString());

         }
         */
        // For example, a filter might append something to the response.
	/*
         PrintWriter respOut = new PrintWriter(response.getWriter());
         respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        if (debug) {
            log("Route:doFilter()");
        }

        doBeforeProcessing(request, response);

        Throwable problem = null;
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            String url = req.getRequestURI().replace(F.getProjectPath(), "");
            routing(req, res, url);
            try {
                chain.doFilter(request, response);
            } catch (Exception e) {
            }
            
        } catch (Throwable t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
            t.printStackTrace();
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("Route:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("Route()");
        }
        StringBuffer sb = new StringBuffer("Route(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
