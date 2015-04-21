<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>รายชื่อสมาชิก</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <table id="userList" class="display" cellspacing="0" width="100%">
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
                            <td id="name-${usr.id}">${usr.fullname}</td>
                            <td id="email-${usr.id}">${usr.email}</td>
                            <td id="birthday-${usr.id}">${usr.birthday}</td>
                            <td id="age-${usr.id}">${usr.age} ปี</td>
                            <td><i class="glyphicon glyphicon-bitcoin" style="font-size: 0.9em;"></i> <span id="credits-${usr.id}">${usr.credit}</span></td>
                            <td>
                                <a href="<%= F.asset("/profile")%>/${usr.id}" target="_blank" class="btn btn-xs">View</a>
                                <button type="button" class="btn btn-primary btn-xs" onclick="activateModal(${usr.id})">
                                    Change Credit
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>


<!-- Modal Zone -->
<div class="modal fade" id="changeCreditModal" tabindex="-1" role="dialog" aria-labelledby="changeCreditModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" method="POST" action="<%= F.asset("/admin/user/changecredit")%>">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="changeCreditModalLabel">Change Credit</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="userid" name="userid" />
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">ชื่อ</label>
                        <div class="col-sm-10 control-label" style="text-align: left;">
                            <p id="name"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">อีเมล</label>
                        <div class="col-sm-10 control-label" style="text-align: left;">
                            <p id="email"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="credit" class="col-sm-2 control-label">เครดิต</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <div class="input-group-addon"><i class="glyphicon glyphicon-bitcoin" style="font-size: 0.9em;"></i></div>
                                <input type="number" min="0" step="0.01" class="form-control" id="credits" name="credits">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="reset" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" id="save">Save changes</button>
                    </div>

                </div>
            </form>
        </div>
    </div>
</div>

<!-- End of modal -->
<script>
    $(document).ready(function () {
        $('#userList').DataTable();
    });
</script>

<script>
    function activateModal(usrID) {
        $("#userid").val(usrID);
        $("#name").html($("#name-" + usrID).html());
        $("#email").html($("#email-" + usrID).html());
        $("#credits").val($("#credits-" + usrID).html());
        $('#changeCreditModal').modal('show');
    }
</script>
<jsp:include page="footer.jsp" />