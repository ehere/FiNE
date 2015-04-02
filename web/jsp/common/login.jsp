<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>เข้าสู่ระบบ</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-sm-5">
                <div class="basic-login">
                    <form role="form" method="POST" action="login.do?action=login">
                        <div class="form-group">
                            <label for="email"><i class="icon-user"></i> <b>อีเมล</b></label>
                            <input class="form-control" id="email" name="email" type="email" placeholder="">
                        </div>
                        <div class="form-group">
                            <label for="password"><i class="icon-lock"></i> <b>รหัสผ่าน</b></label>
                            <input class="form-control" id="password" name="password" type="password" placeholder="">
                        </div>
                        <div class="form-group">
                            <!-- <label class="checkbox">
                                <input type="checkbox"> Remember me
                            </label> 
                            <a href="page-password-reset.html" class="forgot-password">Forgot password?</a>
                            -->
                            <button type="submit" class="btn pull-right">Login</button>
                            <div class="clearfix"></div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-sm-7 social-login">
                <p>คุณสามารถรับชม Visual Novel ของเราได้ง่ายๆ ด้วย <strong>FiNE Account!</strong></p>
                <div class="clearfix"></div>
                <div class="not-member">
                    <p>คุณยังไม่มี FiNE Account? <a href="<%= F.asset("/register") %>">สมัครสมาชิกที่นี่</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />