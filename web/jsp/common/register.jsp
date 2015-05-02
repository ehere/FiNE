<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>ลงทะเบียน</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-sm-3"></div>
            <div class="col-sm-6">
                <% if(request.getSession().getAttribute("message") != null){ %>
                    <div class="alert alert-danger" role="alert">
                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                        <span class="sr-only">Error:</span>
                        ${message}
                    </div>
                    <c:remove var="message" scope="session" /> 
                <% } %>
                <div class="basic-login">
                    <form role="form" method="POST" action='<%= F.asset("/register/add")%>'>
                        <div class="form-group">
                            <label for="prefix"><b>คำนำหน้า</b></label>
                            <select class="form-control" id="prefix" name="prefix" required>
                                <option value="นาย">นาย</option>
                                <option value="นาง">นาง</option>
                                <option value="นางสาว">นางสาว</option>
                                <option value="others">อื่นๆ</option>
                            </select>
                            <input class="form-control hidden" id="prefix-other" name="prefix-other" type="text" placeholder="">
                        </div>
                        <div class="form-group">
                            <label for="firstname"><b>ชื่อ</b></label>
                            <input class="form-control" id="firstname" name='firstname' type="text" placeholder="" required>
                        </div>
                        <div class="form-group">
                            <label for="lastname"><b>นามสกุล</b></label>
                            <input class="form-control" id="lastname" name='lastname' type="text" placeholder="" required>
                        </div>
                        <div class="form-group">
                            <label for="email"><b>อีเมล</b> <small>นี่จะเป็นอีเมลในการใช้เข้าสู่ระบบของคุณ</small></label>
                            <input class="form-control" id="email" name='email' type="email" placeholder="" required>
                        </div>
                        <div class="form-group">
                            <label for="password"><b>รหัสผ่าน</b> <small>ความยาวมากกว่าหรือเท่ากับ 5 ตัวอักษร</small></label>
                            <input class="form-control" id="password" name='password' type="password" placeholder="" pattern=".{5,}" title="รหัสผ่านต้องมีความยาวมากกว่าหรือเท่ากับ 5 ตัวอักษร" required>
                        </div>
                        <div class="form-group">
                            <label for="c-password"><b>ยืนยันรหัสผ่าน</b></label>
                            <input class="form-control" id="c-password" name='c-password' type="password" placeholder=""  pattern=".{5,}" title="รหัสผ่านต้องมีความยาวมากกว่าหรือเท่ากับ 5 ตัวอักษร" required>
                        </div>
                        <div class="form-group">
                            <label for="birthday"><b>วันเกิด</b></label>
                            <input class="form-control" id="birthday" name='birthday' type="date" placeholder="" max="<%= F.convertDate(new java.util.Date(), "yyyy-MM-dd") %>" required>
                        </div>
                        <div class="form-group text-center">
                            <button type="submit" class="btn">สมัครสมาชิก</button>
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