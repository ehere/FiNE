<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Your Name Here</h1>
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
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad" >


                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">Sheena Kristin A.Eschor</h3>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-3 col-lg-3 " align="center"> <img alt="User Pic" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=100" class="img-circle"> </div>

                                    <!--<div class="col-xs-10 col-sm-10 hidden-md hidden-lg"> <br>
                                      <dl>
                                        <dt>DEPARTMENT:</dt>
                                        <dd>Administrator</dd>
                                        <dt>HIRE DATE</dt>
                                        <dd>11/12/2013</dd>
                                        <dt>DATE OF BIRTH</dt>
                                           <dd>11/12/2013</dd>
                                        <dt>GENDER</dt>
                                        <dd>Male</dd>
                                      </dl>
                                    </div>-->
                                    <div class=" col-md-9 col-lg-9 "> 
                                        <table class="table table-user-information">
                                            <tbody>
                                                <tr>
                                                    <td>Department:</td>
                                                    <td>Programming</td>
                                                </tr>
                                                <tr>
                                                    <td>Hire date:</td>
                                                    <td>06/23/2013</td>
                                                </tr>
                                                <tr>
                                                    <td>Date of Birth</td>
                                                    <td>01/24/1988</td>
                                                </tr>

                                                <tr>
                                                <tr>
                                                    <td>Gender</td>
                                                    <td>Male</td>
                                                </tr>
                                                <tr>
                                                    <td>Home Address</td>
                                                    <td>Metro Manila,Philippines</td>
                                                </tr>
                                                <tr>
                                                    <td>Email</td>
                                                    <td><a href="mailto:info@support.com">info@support.com</a></td>
                                                </tr>
                                            <td>Phone Number</td>
                                            <td>123-4567-890(Landline)<br><br>555-4567-890(Mobile)
                                            </td>

                                            </tr>

                                            </tbody>
                                        </table>

                                        <a href="#" class="btn btn-primary">My Sales Performance</a>
                                        <a href="#" class="btn btn-primary">Team Sales Performance</a>
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
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />