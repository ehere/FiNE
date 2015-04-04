<%@page import="model.Project"%>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>${product.title}</h1>
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
            <!-- Product Image & Available Colors -->
            <div class="col-sm-6">
                <div class="product-image-large">
                    <img src="${product.cover}" alt="Item Name">
                </div>
            </div>
            <!-- End Product Image & Available Colors -->
            <!-- Product Summary & Options -->
            <div class="col-sm-6 product-details">
                <h4>${product.title}</h4>
                <div class="price">
                    ${product.price} ฿
                </div>
                <table class="shop-item-selections">
                    <!-- Color Selector -->
                    <tr>
                        <td><b>Rate:</b></td>
                        <td>${product.rate}+</td>
                    </tr>

                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <a href='<%= F.asset("/cartmgnt") %>/${product.id}/add' class="btn btn"><i class="icon-shopping-cart icon-white"></i> Add to Cart</a>
                        </td>
                    </tr>
                </table>
            </div>
            <!-- End Product Summary & Options -->

            <!-- Full Description & Specification -->
            <div class="col-sm-12">
                <div class="tabbable">
                    <!-- Tabs -->
                    <ul class="nav nav-tabs product-details-nav">
                        <li class="active"><a href="#tab1" data-toggle="tab">Description</a></li>
                            <%--<li><a href="#tab2" data-toggle="tab">Specification</a></li>--%>
                    </ul>
                    <!-- Tab Content (Full Description) -->
                    <div class="tab-content product-detail-info">
                        <div class="tab-pane active" id="tab1">
                            ${product.description}
                        </div>

                        <%--
                        <!-- Tab Content (Specification) -->
                        <div class="tab-pane" id="tab2">
                            <table>
                                <tr>
                                    <td>Total sensor Pixels (megapixels)</td>
                                    <td>Approx. 16.7</td>
                                </tr>
                                <tr>
                                    <td>Effective Pixels (megapixels)</td>
                                    <td>Approx. 16.1</td>
                                </tr>
                                <tr>
                                    <td>Automatic White Balance</td>
                                    <td>YES</td>
                                </tr>
                                <tr>
                                    <td>White balance: preset selection</td>
                                    <td>Daylight, Shade, Cloudy, Incandescent, Fluorescent, Flash</td>
                                </tr>
                                <tr>
                                    <td>White balance: custom setting</td>
                                    <td>YES</td>
                                </tr>
                                <tr>
                                    <td>White balance: types of color temperature</td>
                                    <td>YES (G7 to M7,15-step) (A7 to B7,15-step)</td>
                                </tr>
                                <tr>
                                    <td>White balance bracketing</td>
                                    <td>NO</td>
                                </tr>
                                <tr>
                                    <td>ISO Sensitivity Setting</td>
                                    <td>ISO100 - 25600 equivalent</td>
                                </tr>
                            </table>
                        </div>
                        --%>
                    </div>
                </div>
            </div>
            <!-- End Full Description & Specification -->
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />