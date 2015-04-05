/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.common;

import help.F;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author iMEIDA
 */
@WebServlet(name = "CartManagement", urlPatterns = {"/cartmgnt/*"})
public class CartManagement extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        if (!F.isLoggedIn(request.getSession())) {
            response.sendRedirect(F.asset("/login"));
            return;
        }
        String pathInfo;
        /*try (PrintWriter out = response.getWriter()) {
         out.println(request.getPathInfo().replaceAll("^/+", "").replaceAll("/+$", ""));
         }*/
        if (request.getPathInfo() != null) {
            pathInfo = request.getPathInfo().replaceAll("^/+", "").replaceAll("/+$", "");
        } else {
            pathInfo = "";
        }
        if (pathInfo.contains("add")) {
            if(addCart(request, pathInfo)){
                //redir to project info pg.
                response.sendRedirect(F.asset("/product/"+pathInfo.split("/")[0]+"/view"));
            }
            else{
                //redir to index pg.
                response.sendRedirect(F.asset("/"));
            }
            

        }
        else if (pathInfo.contains("remove")) {
            removeCart(request, pathInfo);
            response.sendRedirect(F.asset("/cart"));
        }
    }

    protected boolean addCart(HttpServletRequest request, String pathInfo) throws UnsupportedEncodingException {
        Connection conn = F.getConnection();
        //int id = Integer.parseInt(pathInfo.split("/")[0]);
        String id = pathInfo.split("/")[0];
        HttpSession session = request.getSession();
        model.Cart cart;
        if (session.getAttribute("cart") == null) {
            cart = new model.Cart();
        } else {
            cart = (model.Cart) session.getAttribute("cart");
        }

        //Check if this item already exist in the cart
        if (cart.isExist(id)) {
            session.setAttribute("message_type", "warning");
            session.setAttribute("message", "คุณได้เคยเลือกสินค้านี้ใส่ตระกร้าไปแล้ว!");
            return true;
        }

        int userId = ((User) session.getAttribute("user")).getId();

        PreparedStatement psmt, buyPstmt;
        try {
            psmt = conn.prepareStatement("SELECT * FROM fine.project WHERE id = ? AND visible = 1;");
            buyPstmt = conn.prepareStatement("SELECT * FROM fine.purchase WHERE user_id = " + userId + " AND project_id = ?");
            psmt.setString(1, id);
            ResultSet result = psmt.executeQuery();
            if (result.next()) {
                //Check if user already buy it.
                buyPstmt.setString(1, id);
                ResultSet res2 = buyPstmt.executeQuery();
                if (!res2.next()) {
                    //OK! add it to cart.
                    cart.addItem(id);
                    session.setAttribute("cart", cart);
                    session.setAttribute("message_type", "success");
                    session.setAttribute("message", "เลือกสินค้าใส่ตระกร้าเรียบร้อยแล้ว!");
                } else {
                    session.setAttribute("message_type", "danger");
                    session.setAttribute("message", "คุณได้เคยซื้อนิยายเรื่องนี้ไปแล้ว!");
                }
                psmt.close();
                buyPstmt.close();
                result.close();
                res2.close();
                return true;
            } else {
                //session.setAttribute("message_type", "danger");
                //session.setAttribute("message", "ขออภัย! ไม่พบนิยายเรื่องนี้ในระบบ");
                psmt.close();
                result.close();
                return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        //session.setAttribute("message_type", "danger");
        //session.setAttribute("message", "มีบางอย่างผิดพลาด กรุณาติดต่อผู้ดูแลระบบ!");
        return false;
    }
    
    protected void removeCart(HttpServletRequest request, String pathInfo) throws UnsupportedEncodingException {
        String id = pathInfo.split("/")[0];
        HttpSession session = request.getSession();
        model.Cart cart;
        if (session.getAttribute("cart") == null) {
            cart = new model.Cart();
        } else {
            cart = (model.Cart) session.getAttribute("cart");
        }

        //Check if this item already exist in the cart
        if (cart.isExist(id)) {
            cart.removeItem(id);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
