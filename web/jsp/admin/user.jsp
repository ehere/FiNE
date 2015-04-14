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
            <table id="example" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>ชื่อ</th>
                        <th>อีเมล</th>
                        <th>วันเกิด</th>
                        <th>อายุ</th>
                        <th>เครดิต</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="usr" items="${userList}">
                        <tr>
                            <td>${usr.fullname}</td>
                            <td>${usr.email}</td>
                            <td>${usr.birthday}</td>
                            <td>${usr.age} ปี</td>
                            <td><i class="glyphicon glyphicon-bitcoin" style="font-size: 0.9em;"></i> ${usr.credit}</td>
                            <td><a href="<%= F.asset("/profile") %>/${usr.id}" target="_blank" class="btn btn-xs">View</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#example').DataTable();
    });
</script>
<jsp:include page="footer.jsp" />