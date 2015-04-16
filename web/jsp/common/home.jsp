<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />
<!-- Homepage Slider -->
<div class="homepage-slider">
    <div id="sequence">
        <ul class="sequence-canvas">
            <!-- Slide 1 -->
            <li class="bg3">
                <h2 class="title">FiNE Store</h2>
                <h3 class="subtitle">ค้นหา Visual Novel ที่น่าสนใจจากรายการที่สมาชิกช่วยกันสร้าง</h3>
                <img class="slide-img" src="<%= F.asset("img/homepage-slider/slide2.png")%>" alt="Slide 2" />
            </li>
            <li class="bg1">
                <h2 class="title">DIY</h2>
                <h3 class="subtitle">สร้าง Visual Novel เองได้ง่ายๆ และที่สำคัญ ฟรี!</h3>
                <img class="slide-img" src="<%= F.asset("img/homepage-slider/slide3.png")%>" alt="Slide 3" />
            </li>
            <li class="bg4">
                <h2 class="title">Responsive</h2>
                <h3 class="subtitle">It looks great on desktops, laptops, tablets and smartphones</h3>
                <img class="slide-img" src="<%= F.asset("img/homepage-slider/slide1.png")%>" alt="Slide 1" />
            </li>
        </ul>
        <div class="sequence-pagination-wrapper">
            <ul class="sequence-pagination">
                <li>1</li>
                <li>2</li>
                <li>3</li>
            </ul>
        </div>
    </div>
</div>
<!-- End Homepage Slider -->



<!-- Services -->
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-sm-6">
                <div class="service-wrapper">
                    <img src="<%= F.asset("img/service-icon/box.png")%>" alt="Service 1">
                    <h3>หาอะไรสนุกๆเล่น</h3>
                    <p>Fine มี Visua Novel น่าสนใจที่สมาชิกช่วยกันสร้างขึ้นมาด้วยใจรัก เลือกดูใน Fine Storeได้เลย</p>
                    <a href="<%= F.asset("/product")%>" class="btn">ไปยัง Fine Store</a>
                </div>
            </div>
            <div class="col-md-4 col-sm-6">
                <div class="service-wrapper">
                    <img src="<%= F.asset("img/service-icon/ruler.png")%>" alt="Service 2">
                    <h3>อยากทำ Visual Novel บ้าง?</h3>
                    <p> อยากทำ Visual Novel แต่ไม่มีเครื่องมือ<br>
                        ไม่ต้องห่วง Fine จะทำให้ความฝันของคุณเป็นจริง</p>
                    <a href="#" class="btn">สร้าง Visual Novel</a>
                </div>
            </div>
            <div class="col-md-4 col-sm-6">
                <div class="service-wrapper">
                    <img src="<%= F.asset("img/service-icon/diamond.png")%>" alt="Service 3">
                    <h3>สร้างรายได้</h3>
                    <p>Visual Novel ทุกเรื่องที่คุณสร้างสามารถสร้างรายได้ให้ได้ เพียงตั้งราคาเมื่อมีคนซื้อ คุณก็รับเงินได้เลย*</p>
                    <a href="#" class="btn">สร้าง Visual Novel</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Services -->


<!-- Call to Action Bar -->
<div class="section section-white">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="calltoaction-wrapper">
                    <h3>เราสำเร็จ เมื่อคุณสำเร็จ สร้าง Visual Novel ได้ฟรีไม่เสียค่าใช้จ่าย* </h3> <a href="<%= F.asset("/register")%>" class="btn btn-orange">สมัครสมาชิกกับเรา</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Call to Action Bar -->



<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <a href="<%= F.asset("/product")%>" class="btn btn-green pull-right">ดูเพิ่มเติมที่ FiNE Store <i class="glyphicon glyphicon-chevron-right"></i></a>
                <h2>Visual Novel แนะนำ</h2>
                <br>
                <br>
                <div class="products-slider">
                    <!-- Products Slider Item -->
                    <c:forEach var="product" items="${projectList}">
                    <div class="shop-item">
                        <%-- <div class="ribbon-wrapper">
                            <div class="price-ribbon ribbon-green"> New </div>
                        </div> --%>
                        <!-- Product Image -->
                        <div class="image">
                            <a href="<%= F.asset("/product")%>/${product.id}/view"><img src="${product.cover}" alt="${product.title}" style="width: 256px; height: 159px;"></a>
                        </div>
                        <!-- Product Title -->
                        <div class="title">
                            <h3><a href="<%= F.asset("/product")%>/${product.id}/view">${product.title}</a></h3>
                        </div>
                        <!-- Product Price -->
                        <div class="price">
                            <i class="glyphicon glyphicon-bitcoin" style="font-size: 0.8em;"></i>${product.price}
                        </div>
                        <!-- Buy Button -->
                        <div class="actions">
                            <a href="<%= F.asset("/product")%>/${product.id}/view" class="btn btn-small">View</a>
                        </div>
                    </div>
                    </c:forEach>
                    <!-- End Products Slider Item -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Press Coverage 
<div class="section">
<div class="container">
                <div class="row">
                        <div class="col-md-4 col-sm-6">
                                <div class="in-press press-wired">
                                        <a href="#">Morbi eleifend congue elit nec sagittis. Praesent aliquam lobortis tellus, nec consequat vitae</a>
                                </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                                <div class="in-press press-mashable">
                                        <a href="#">Morbi eleifend congue elit nec sagittis. Praesent aliquam lobortis tellus, nec consequat vitae</a>
                                </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                                <div class="in-press press-techcrunch">
                                        <a href="#">Morbi eleifend congue elit nec sagittis. Praesent aliquam lobortis tellus, nec consequat vitae</a>
                                </div>
                        </div>
                </div>
        </div>
</div>
<!-- Press Coverage -->


<!-- Our Clients -->
<div class="section">
    <div class="container">
        <h2>ผู้สนับสนุน</h2>
        <div class="clients-logo-wrapper text-center row">
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/canon.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/cisco.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/dell.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/ea.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/ebay.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/facebook.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/google.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/hp.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/microsoft.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/mysql.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/sony.png")%>" alt="Client Name"></a></div>
            <div class="col-lg-1 col-md-1 col-sm-3 col-xs-6"><a href="#"><img src="<%= F.asset("img/logos/yahoo.png")%>" alt="Client Name"></a></div>
        </div>
    </div>
</div>
<!-- End Our Clients -->

<jsp:include page="footer.jsp" />