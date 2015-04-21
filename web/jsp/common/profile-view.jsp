<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>ข้อมูลส่วนตัว</h1>
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
            <div class="container">
                <div class="row">
                    <div>


                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <span class="pull-right">
                                    <c:if test="${canEdit}">
                                        <a href="<%= F.asset("/credit")%>" data-original-title="View credit log" data-toggle="tooltip" type="button" class="btn btn-xs btn-blue"><i class="glyphicon glyphicon-bitcoin"></i> ดูความเคลื่อนไหวของเครดิต</a>
                                        <a href="<%= F.asset("/profile/edit")%>" data-original-title="Edit this user" data-toggle="tooltip" type="button" class="btn btn-xs btn-blue"><i class="glyphicon glyphicon-edit"></i> แก้ไขข้อมูลส่วนตัว</a>
                                    </c:if>
                                </span>
                                <h3 class="panel-title">ข้อมูลส่วนตัว</h3>

                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100" class="img-circle"> </div>

                                    <div class=" col-md-9 col-lg-9 "> 
                                        <table class="table table-user-information">
                                            <tbody>
                                                <tr>
                                                    <td>ชื่อ:</td>
                                                    <td>${profile.fullname}</td>
                                                </tr>
                                                <tr>
                                                    <td>อีเมล:</td>
                                                    <td>${profile.email}</td>
                                                </tr>
                                                <tr>
                                                    <td>วันเกิด:</td>
                                                    <td>${profile.birthday}</td>
                                                </tr>

                                                <tr>
                                                <tr>
                                                    <td>สมัครสมาชิกเมื่อ:</td>
                                                    <td>${profile.created_at}</td>
                                                </tr>
                                                <tr>
                                                    <td>เล่นครั้งสุดท้าย:</td>
                                                    <td>${lastplayTime}</td>
                                                </tr>
                                                <tr>
                                                    <td>Visual Novel ที่สร้าง:</td>
                                                    <td>${profile.ownProjectID.size()} เรื่อง</td>
                                                </tr>
                                                <tr>
                                                    <td>Visual Novel ที่เคยซื้อ:</td>
                                                    <td>${profile.purchaseProjectID.size()} เรื่อง</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer">
                            </div>

                        </div>
                    </div>

                    <div>


                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Visual Novels ที่สร้างโดยผู้ใช้คนนี้</h3>
                            </div>
                            <div class="panel-body">
                                <c:if test="${profile.latestOwnProjectID.size() == 0}">
                                    <h5 style="text-align: center;">ไม่มี Visual Novel ที่เป็นของผู้ใช้คนนี้</h5>
                                </c:if>
                                <c:forEach var="product" items="${profile.ownProject}">
                                    <div class="col-md-3 col-lg-3 " align="center">
                                        <a href="<%= F.asset("/product")%>/${product.id}/view" style='text-decoration: none;'>
                                            <img src="${product.cover}" style="height: 100px; width: 100px;" class="img-circle" alt="${product.title}">
                                            <p style="text-align: center;">${product.title}</p>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<jsp:include page="footer.jsp" />