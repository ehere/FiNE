<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>แก้ไขข้อมูลส่วนตัว</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-sm-3"></div>
            <div class="col-sm-6">
                <% if (request.getSession().getAttribute("message") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <span class="sr-only">Error:</span>
                    ${message}
                </div>
                <c:remove var="message" scope="session" /> 
                <% }%>
                <div class="basic-login">
                    <form role="form" method="POST" action='<%= F.asset("/profile/change")%>'>
                        <div class="form-group">
                            <label for="prefix"><b>คำนำหน้า</b></label>
                            <select class="form-control" id="prefix" name="prefix" required>
                                <c:choose>
                                    <c:when test="${sessionScope.user.prefix == 'นาย'}">
                                        <option value="นาย" selected>นาย</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="นาย">นาย</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${sessionScope.user.prefix == 'นาง'}">
                                        <option value="นาง" selected>นาง</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="นาง">นาง</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${sessionScope.user.prefix == 'นางสาว'}">
                                        <option value="นางสาว" selected>นางสาว</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="นางสาว">นางสาว</option>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${sessionScope.user.prefix == 'others'}">
                                        <option value="others" selected>อื่นๆ</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="others">อื่นๆ</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                            <input class="form-control hidden" id="prefix-other" name="prefix-other" type="text" placeholder="">
                        </div>
                        <div class="form-group">
                            <label for="firstname"><b>ชื่อ</b></label>
                            <input class="form-control" id="firstname" name='firstname' type="text" placeholder="" value="${sessionScope.user.firstname}" required>
                        </div>
                        <div class="form-group">
                            <label for="lastname"><b>นามสกุล</b></label>
                            <input class="form-control" id="lastname" name='lastname' type="text" placeholder="" value="${sessionScope.user.lastname}" required>
                        </div>
                        <div class="form-group">
                            <label for="password"><b>รหัสผ่าน</b> <small>ถ้าหากไม่ต้องการเปลี่ยนรหัสผ่าน ให้เว้นว่างไว้</small></label>
                            <input class="form-control" id="password" name='password' type="password" placeholder="" >
                        </div>
                        <div class="form-group">
                            <label for="c-password"><b>ยืนยันรหัสผ่าน</b> <small>ถ้าหากไม่ต้องการเปลี่ยนรหัสผ่าน ให้เว้นว่างไว้</small></label>
                            <input class="form-control" id="c-password" name='c-password' type="password" placeholder="" >
                        </div>
                        <div class="form-group text-center">
                            <button type="submit" class="btn">แก้ไข</button>
                            <div class="clearfix"></div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-sm-3"></div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />