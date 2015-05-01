<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <a href="<%= F.asset("/admin/sharecredit")%>" class="btn btn-orange pull-right"><i class="glyphicon glyphicon-bitcoin"></i> จ่ายค่าตอบแทนทั้งหมด</a>
                <h1>ค่าตอบแทนที่ยังไม่ได้ชำระ</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <div id="loading_table">
                <div align="center" style="margin-top: 10px;">
                    <img src="<%= F.asset("img/loading.gif")%>"/>
                </div>
            </div>
            <table id="userList" class="display hidden" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>ชื่อ</th>
                        <th>อีเมล</th>
                        <th>เครดิตที่ต้องจ่าย</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="usr" items="${userList}">
                        <tr>
                            <td id="name-${usr.id}"><a href="<%= F.asset("/profile")%>/${usr.id}" target="_blank">${usr.fullname}</a></td>
                            <td id="email-${usr.id}">${usr.email}</td>
                            <td><i class="glyphicon glyphicon-bitcoin" style="font-size: 0.9em;"></i> <span id="credits-${usr.id}">${share.get(usr.id)}</span></td>
                            <td>
                                <a href="<%= F.asset("/admin/sharecredit")%>/${usr.id}" class="btn btn-xs">จ่ายค่าตอบแทน</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#userList').DataTable({
            "drawCallback": function (settings) {
                $('#loading_table').addClass("hidden");
                $('#userList').removeClass("hidden");
            }
        });
    });
</script>
<jsp:include page="footer.jsp" />