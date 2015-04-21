<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Admin Panel</h1>
            </div>
        </div>
    </div>
</div>
<!-- Services -->
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-sm-4">
                <div class="service-wrapper">
                    <br><br>
                    <img src="<%= F.asset("img/service-icon/user.png")%>" alt="Service 1">
                    <br><br>
                    <h3>จัดการสมาชิก</h3>
                    <p>
                        ดูรายชื่อสมาชิกทั้งหมด <br>
                        จัดการเครดิตของสมาชิก <br><br>
                    </p>
                    <a href="<%= F.asset("/admin/user")%>" class="btn">User Management</a>
                    <br><br>
                </div>
            </div>
            <div class="col-md-4 col-sm-4">
                <div class="service-wrapper">
                    <br><br>
                    <img src="<%= F.asset("img/service-icon/ruler.png")%>" alt="Service 2">
                    <br><br>
                    <h3>จัดการ Visual Novel</h3>
                    <p> 
                        ดูรายชื่อ Visual Novel ทังหมด<br>
                        จัดการ สิทธ์การเผยแพร่ <br>
                        จัดการ ส่วนแบ่งของผู้แต่ง
                    </p>
                    <a href="<%= F.asset("/admin/product")%>" class="btn">Project Management</a>
                    <br><br>
                </div>
            </div>
            <div class="col-md-4 col-sm-4">
                <div class="service-wrapper">
                    <br><br>
                    <img src="<%= F.asset("img/service-icon/diamond.png")%>" alt="Service 2">
                    <br><br>
                    <h3>จ่ายผลตอบแทน</h3>
                    <p> 
                        จ่ายผลตอบแทนให้กับผู้สร้างสรรค์ผลงาน<br><br><br>
                    </p>
                    <a href="<%= F.asset("/admin/sharecredit")%>" class="btn">จ่ายผลตอบแทน</a>
                    <br><br>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Services -->
<br><br><br>
<jsp:include page="footer.jsp" />