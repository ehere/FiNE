<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />
<!-- Homepage Slider -->
<div class="homepage-slider">
    <div id="sequence" style="margin-bottom: 0px">
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
        </ul>
        <div class="sequence-pagination-wrapper">
            <ul class="sequence-pagination">
                <li>1</li>
                <li>2</li>
            </ul>
        </div>
    </div>
</div>
<!-- End Homepage Slider -->
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
                    <a href="<%= F.asset("/author/project")%>" class="btn">สร้าง Visual Novel</a>
                </div>
            </div>
            <div class="col-md-4 col-sm-6">
                <div class="service-wrapper">
                    <img src="<%= F.asset("img/service-icon/diamond.png")%>" alt="Service 3">
                    <h3>สร้างรายได้</h3>
                    <p>Visual Novel ทุกเรื่องที่คุณสร้างสามารถสร้างรายได้ให้ได้ เพียงตั้งราคาเมื่อมีคนซื้อ คุณก็รับเงินได้เลย*</p>
                    <a href="<%= F.asset("/author/project")%>" class="btn">สร้าง Visual Novel</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Services -->

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
                            <div class="image">
                                <a href="<%= F.asset("/product")%>/${product.id}/view"><img src="${product.cover}" style="height: 180px;margin-left: auto;margin-right: auto;" alt="${product.title}"></a>
                            </div>
                            <div class="title">
                                <h3><a href="<%= F.asset("/product")%>/${product.id}/view" style="font-size: 1.5em;">${product.title}</a></h3>
                            </div>
                            <div class="price" style="font-size: 1.3em;">
                                <i class="glyphicon glyphicon-bitcoin icon-white"></i>${product.price}
                            </div>
                            <!-- Buy Button -->
                            <div class="actions">
                                <c:choose>
                                    <c:when test="${user.age >= product.rate}">
                                        <c:choose>
                                            <c:when test="${product.is_bought==true}">
                                                <a href='<%= F.asset("/project")%>/${product.id}/play' class="btn btn-grey"><i class="glyphicon glyphicon-play icon-white"></i> Play</a>
                                            </c:when>

                                            <c:otherwise>
                                                <a href='<%= F.asset("/cartmgnt")%>/${product.id}/add' class="btn btn-small"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> Add</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <a href='#' class="btn btn-grey disabled"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> Add</a>
                                    </c:otherwise>
                                </c:choose>
                                or 
                                <a href="<%= F.asset("/product")%>/${product.id}/view" >View</a>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- End Products Slider Item -->
                </div>
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-md-12">
                <a href="<%= F.asset("/product")%>" class="btn btn-green pull-right">ดูเพิ่มเติมที่ FiNE Store <i class="glyphicon glyphicon-chevron-right"></i></a>
                <h2>Visual Novel สุ่มเลือก</h2>
                <br>
                <br>
                <div class="products-slider">
                    <!-- Products Slider Item -->
                    <c:forEach var="product" items="${randomList}">
                        <div class="shop-item">
                            <%-- <div class="ribbon-wrapper">
                                <div class="price-ribbon ribbon-green"> New </div>
                            </div> --%>
                            <div class="image">
                                <a href="<%= F.asset("/product")%>/${product.id}/view"><img src="${product.cover}" style="height: 180px;margin-left: auto;margin-right: auto;" alt="${product.title}"></a>
                            </div>
                            <div class="title">
                                <h3><a href="<%= F.asset("/product")%>/${product.id}/view" style="font-size: 1.5em;">${product.title}</a></h3>
                            </div>
                            <div class="price" style="font-size: 1.3em;">
                                <i class="glyphicon glyphicon-bitcoin icon-white"></i>${product.price}
                            </div>
                            <!-- Buy Button -->
                            <div class="actions">
                                <c:choose>
                                    <c:when test="${user.age >= product.rate}">
                                        <c:choose>
                                            <c:when test="${product.is_bought==true}">
                                                <a href='<%= F.asset("/project")%>/${product.id}/play' class="btn btn-grey"><i class="glyphicon glyphicon-play icon-white"></i> Play</a>
                                            </c:when>

                                            <c:otherwise>
                                                <a href='<%= F.asset("/cartmgnt")%>/${product.id}/add' class="btn btn-small"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> Add</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <a href='#' class="btn btn-grey disabled"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> Add</a>
                                    </c:otherwise>
                                </c:choose>
                                or 
                                <a href="<%= F.asset("/product")%>/${product.id}/view" >View</a>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- End Products Slider Item -->
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />