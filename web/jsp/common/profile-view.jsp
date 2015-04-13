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
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 toppad" >


                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Profile</h3>
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
                                <a data-original-title="Broadcast Message" data-toggle="tooltip" type="button" class="btn btn-sm btn-primary"><i class="glyphicon glyphicon-envelope"></i></a>
                                <span class="pull-right">
                                    <a href="edit.html" data-original-title="Edit this user" data-toggle="tooltip" type="button" class="btn btn-sm btn-warning"><i class="glyphicon glyphicon-edit"></i></a>
                                    <a data-original-title="Remove this user" data-toggle="tooltip" type="button" class="btn btn-sm btn-danger"><i class="glyphicon glyphicon-remove"></i></a>
                                </span>
                            </div>

                        </div>
                    </div>
                    
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 toppad" >


                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Visual Novel by this user</h3>
                            </div>
                            <div class="panel-body">
                                <c:forEach var="product" items="${profile.ownProject}">
                                    <div class="col-md-3 col-lg-3 " align="center">
                                        <img alt="User Pic" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100" class="img-circle">
                                        <p style="text-align: center;">${product.title}</p>
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