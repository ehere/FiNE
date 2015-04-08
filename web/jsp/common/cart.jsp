<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Shopping Cart</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <% if (request.getSession().getAttribute("message") != null) { %>
            <div class="alert alert-${message_type}" role="alert">
                <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                ${message}
            </div>
            <c:remove var="message" scope="session" /> 
            <c:remove var="message_type" scope="session" /> 
            <% }%>
            <div class="col-md-12">
                <!-- Action Buttons -->
                <div class="pull-right">
                    <a href="#" class="btn btn-grey"><i class="glyphicon glyphicon-refresh"></i> UPDATE</a>
                    <a href='<%= F.asset("/cartmgnt/buy") %>' class="btn"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> CHECK OUT</a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <!-- Shopping Cart Items -->
                <table class="shopping-cart">
                    <!-- Shopping Cart Item -->
                    <c:forEach var="item" items="${cart}">
                        <tr>
                            <!-- Shopping Cart Item Image -->
                            <td class="image"><a href="<%= F.asset("/product") %>/${item.id}/view"><img src="${item.cover}" alt="${item.title}"></a></td>
                            <!-- Shopping Cart Item Description & Features -->
                            <td>
                                <div class="cart-item-title"><a href="<%= F.asset("/product") %>/${item.id}/view">${item.title}</a></div>
                                <div class="feature">Rate: <b>${item.rate}</b></div>
                            </td>
                            <!-- Shopping Cart Item Price -->
                            <td class="price">${item.price}</td>
                            <!-- Shopping Cart Item Actions -->
                            <td class="actions">
                                <a href='<%= F.asset("/cartmgnt") %>/${item.id}/remove' class="btn btn-xs btn-grey"><i class="glyphicon glyphicon-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <!-- End Shopping Cart Items -->
            </div>
        </div>
        <div class="row">
            <!-- Promotion Code -->
            <div class="col-md-4  col-md-offset-0 col-sm-6 col-sm-offset-6">
                
            </div>
            <!-- Shipment Options -->
            <div class="col-md-4 col-md-offset-0 col-sm-6 col-sm-offset-6">
                
            </div>

            <!-- Shopping Cart Totals -->
            <div class="col-md-4 col-md-offset-0 col-sm-6 col-sm-offset-6">
                <table class="cart-totals">
                    <tr class="cart-grand-total">
                        <td><b>Total</b></td>
                        <td><b><%= String.format("%.2f", request.getAttribute("total")) %></b></td>
                    </tr>
                </table>
                <!-- Action Buttons -->
                <div class="pull-right">
                    <a href="#" class="btn btn-grey"><i class="glyphicon glyphicon-refresh"></i> UPDATE</a>
                    <a href='<%= F.asset("/cartmgnt/buy") %>' class="btn"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> CHECK OUT</a>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />