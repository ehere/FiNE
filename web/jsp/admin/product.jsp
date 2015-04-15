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
                                    <c:when test="${project.visible == 1}">
                                        <span class="label label-success"><i class="glyphicon glyphicon glyphicon-eye-open"></i> Public</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="label label-default"><i class="glyphicon glyphicon glyphicon-eye-close"></i> Private</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td id="title-${project.id}">${project.title}</td>
                            <td id="author-${project.id}">${project.creator.fullname}</td>
                            <td><i class="glyphicon glyphicon-bitcoin" style="font-size: 0.9em;"></i> <span id="price-${usr.id}">${project.price}</span></td>
                            <td id="created-${project.id}">${project.created_at}</td>
                            <td>
                                <a href="<%= F.asset("/product")%>/${project.id}/view" target="_blank" class="btn btn-xs">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- 
<input type="checkbox" name="publish" data-size="mini" data-handle-width="50" data-on-text="Public" data-off-text="Private" checked>
-->
<script>
    $(document).ready(function () {
        $('#productList').DataTable();
        $("[name='publish']").bootstrapSwitch();
        $.fn.bootstrapSwitch.defaults.size = 'small';
    });
</script>

<jsp:include page="footer.jsp" />