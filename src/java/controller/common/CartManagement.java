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
import java.util.ArrayList;
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
            if (addCart(request, response, pathInfo)) {
                //redir to project info pg.
                response.sendRedirect(F.asset("/product/" + pathInfo.split("/")[0] + "/view"));
            } else {
                //redir to index pg.
                response.sendRedirect(F.asset("/"));
            }

        } else if (pathInfo.contains("remove")) {
            removeCart(request, pathInfo);
            response.sendRedirect(F.asset("/cart"));
        } else if (pathInfo.contains("buy")) {
            if (buy(request, response)) {
                response.sendRedirect(F.asset("/inventory"));
            } else {
                response.sendRedirect(F.asset("/cart"));
            }
        }
    }

    protected boolean addCart(HttpServletRequest request, HttpServletResponse response, String pathInfo) throws UnsupportedEncodingException {
        boolean toReturn = false;
        try (Connection conn = F.getConnection()) {
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
                String[] message = {"คุณได้เคยเลือกสินค้านี้ใส่ตะกร้าไปแล้ว!", "warning"};
                session.setAttribute("message", message);
                conn.close();
                return true;
            }

            model.User user = (User) session.getAttribute("user");
            int userId = user.getId();

            PreparedStatement psmt, buyPstmt;

            psmt = conn.prepareStatement("SELECT * FROM project WHERE id = ? AND visible = 1;");
            psmt.setString(1, id);
            ResultSet result = psmt.executeQuery();
            if (result.next()) {
                //Check if user already buy it.
                model.Project project = new model.Project(result);
                if (project.getRate() > user.getAge()) {
                    result.close();
                    psmt.close();
                    conn.close();
                    String[] message = {"คุณไม่สามารถซื้อนิยายเรื่องนี้ได้ เนื่องจากคุณมีอายุไม่ถึงเกณฑ์ที่กำหนด", "danger"};
                    session.setAttribute("message", message);
                    return false;
                }
                buyPstmt = conn.prepareStatement("SELECT * FROM purchase WHERE user_id = " + userId + " AND project_id = ?");
                buyPstmt.setString(1, id);
                ResultSet res2 = buyPstmt.executeQuery();
                if (!res2.next()) {
                    //OK! add it to cart.
                    cart.addItem(id);
                    session.setAttribute("cart", cart);
                    String[] message = {"เลือกสินค้าใส่ตะกร้าเรียบร้อยแล้ว!", "success"};
                    session.setAttribute("message", message);
                } else {
                    String[] message = {"คุณได้เคยซื้อนิยายเรื่องนี้ไปแล้ว!", "danger"};
                    session.setAttribute("message", message);
                }
                buyPstmt.close();
                res2.close();
                //return true;
                toReturn = true;
            }
            psmt.close();
            result.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(CartManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        //session.setAttribute("message_type", "danger");
        //session.setAttribute("message", "มีบางอย่างผิดพลาด กรุณาติดต่อผู้ดูแลระบบ!");

        return toReturn;
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

    protected boolean buy(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        model.Cart cart = (model.Cart) session.getAttribute("cart");
        if (cart.getItems().size() < 1) {
            String[] message = {"คุณไม่มีสินค้าใดๆ ในตะกร้า!", "warning"};
            session.setAttribute("message", message);
            return true;
        }
        try (Connection conn = F.getConnection()) {
            PreparedStatement pstmt = null, purPstmt = null, creditPstmt = null, cutCreditPstmt = null;
            int userId = ((User) request.getSession().getAttribute("user")).getId();
            pstmt = conn.prepareStatement("SELECT * FROM project WHERE id = ?;");

            //get all items
            ArrayList<model.Project> projectList = new ArrayList();

            double price = 0;
            for (Object i : cart.getItems()) {
                String id = (String) i;
                pstmt.setString(1, id);
                ResultSet res = pstmt.executeQuery();
                if (res.next()) {
                    model.Project p = new model.Project(res);
                    price += res.getDouble("price");
                    projectList.add(p);
                } else {
                    res.close();
                    pstmt.close();
                    conn.close();
                    String[] message = {"นิยายบางเรื่องได้ยกเลิกการขายแล้ว!", "danger"};
                    session.setAttribute("message", message);
                    return false;
                }
                res.close();
            }
            pstmt.close();
            creditPstmt = conn.prepareStatement("SELECT * FROM user WHERE id = ?;");
            creditPstmt.setInt(1, userId);
            ResultSet res = creditPstmt.executeQuery();
            if (res.next()) {
                User user = new User(res);
                if (Double.parseDouble(user.getCredit()) < price) {
                    //return false / purchase fail
                    creditPstmt.close();
                    res.close();
                    String[] message = {"คุณมีเครดิตไม่พอที่จะซื้อ!", "danger"};
                    session.setAttribute("message", message);
                    conn.close();
                    return false;
                }
                res.close();
                double newCredit = Double.parseDouble(user.getCredit()) - price;
                cutCreditPstmt = conn.prepareStatement("UPDATE `user` SET `credit` = ? WHERE `user`.`id` = ?;");
                cutCreditPstmt.setDouble(1, newCredit);
                cutCreditPstmt.setInt(2, userId);
                cutCreditPstmt.executeUpdate();
                res = creditPstmt.executeQuery();
                res.next();
                res.close();
                purPstmt = conn.prepareStatement("INSERT INTO `purchase`(`user_id`, `project_id`, `price`, `created_at`) VALUES (?, ?, ?, CURRENT_TIMESTAMP());");
                for (model.Project i : projectList) {
                    purPstmt.setInt(1, userId);
                    purPstmt.setInt(2, i.getId());
                    purPstmt.setString(3, i.getPrice());
                    purPstmt.executeUpdate();
                }
                //close it all
                cutCreditPstmt.close();
                creditPstmt.close();
                conn.close();
                purPstmt.close();
                session.setAttribute("cart", new model.Cart());
                String[] message = {"การสั่งซื้อสำเร็จเรียบร้อย!", "success"};
                session.setAttribute("message", message);
                return true;
            }
            creditPstmt.close();
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(CartManagement.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
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
