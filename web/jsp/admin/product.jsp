<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>รายการ Visual Novel</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <table id="productList" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>การเผยแพร่</th>
                        <th>ชื่อ</th>
                        <th>ผู้แต่ง</th>
                        <th>ราคา</th>
                        <th>วันที่สร้าง</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="project" items="${projectList}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${project.getVisible() > 1}">
                                        <span class="label label-danger"><i class="glyphicon glyphicon glyphicon-ban-circle"></i> Banned</span>
                                    </c:when>
                                    <c:when test="${project.isVisible()}">
                                        <span class="label label-success"><i class="glyphicon glyphicon glyphicon-eye-open"></i> Public</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-default"><i class="glyphicon glyphicon glyphicon-eye-close"></i> Private</span>
                                    </c:otherwise>
                                </c:choose>
                                <input type="hidden" id="visible-${project.id}" value="${project.getVisible()}" />
                            </td>
                            <td id="title-${project.id}"><a href="<%= F.asset("/product")%>/${project.id}/view" target="_blank">${project.title}</a></td>
                            <td id="author-${project.id}"><a href="<%= F.asset("/profile")%>/${project.creator.id}" target="_blank">${project.creator.fullname}</a></td>
                            <td><i class="glyphicon glyphicon-bitcoin" style="font-size: 0.9em;"></i> <span id="price-${project.id}">${project.price}</span></td>
                            <td id="created-${project.id}">${project.created_at}</td>
                            <td>
                                <button type="button" class="btn btn-primary btn-xs" onclick="activateModal(${project.id})">
                                    Change Permission
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
<div class="modal fade" id="changePermissionModal" tabindex="-1" role="dialog" aria-labelledby="changePermissionModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" method="POST" action="<%= F.asset("/admin/product/changepermission")%>">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="changePermissionModalLabel">เปลี่ยนแปลงสิทธิ์การเข้าชม</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="projectid" name="projectid" />
                    <div class="form-group">
                        <label for="title" class="col-sm-3 control-label">เรื่อง</label>
                        <div class="col-sm-9 control-label" style="text-align: left;">
                            <p id="title"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="author" class="col-sm-3 control-label">โดย</label>
                        <div class="col-sm-9 control-label" style="text-align: left;">
                            <p id="author"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publish" class="col-sm-3 control-label">สิทธิ์การเข้าชม</label>
                        <div class="col-sm-9">
                            <div class="input-group">
                                <input type="radio" id="publish-1" name="publish" value="1" /> Public<br />
                                <input type="radio" id="publish-0" name="publish" value="0" /> Private<br />
                                <input type="radio" id="publish-70" name="publish" value="70" /> Ban
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

<!-- 
<input type="checkbox" name="publish" data-size="mini" data-handle-width="50" data-on-text="Public" data-off-text="Private" checked>
-->
<script>
    $(document).ready(function() {
        $('#productList').DataTable();
    });
</script>

<script>
    function activateModal(projectid) {
        $("#projectid").val(projectid);
        $("#title").html($("#title-" + projectid).html());
        $("#author").html($("#author-" + projectid).html());
        if ($("#visible-" + projectid).val() == "1") {
            $("#publish-1").prop("checked", true);
        } else if ($("#visible-" + projectid).val() == "70") {
            $("#publish-70").prop("checked", true);
        }
        else {
            $("#publish-0").prop("checked", true);
        }
        //$("#credits").val($("#credits-" + projectid).html());
        $('#changePermissionModal').modal('show');
    }
</script>

<jsp:include page="footer.jsp" />