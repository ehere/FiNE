<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>FiNE Store</h1>
            </div>
        </div>
    </div>
</div>

<div class="eshop-section section">
    <div class="container">
        <div class="row">
            <c:forEach var="product" items="${list}">
                <div class="col-md-3 col-sm-6">
                    <div class="shop-item">
                        <div class="shop-item-image" style="text-align: center;">
                            <a href="<%= F.asset("/product") %>/${product.id}/view"><img src="${product.cover}" style="height: 150px" alt="${product.title}"></a>
                        </div>
                        <div class="title">
                            <h3><a href="<%= F.asset("/product") %>/${product.id}/view" style="font-size: 1.5em;">${product.title}</a></h3>
                        </div>
                        <div class="price" style="font-size: 1.3em;">
                            <i class="glyphicon glyphicon-bitcoin icon-white"></i>${product.price}
                        </div>
                        <div class="actions">
                            <c:choose>
                                <c:when test="${product.is_bought==true}">
                                    <a href='<%= F.asset("/project")%>/${product.id}/play' class="btn btn-grey"><i class="glyphicon glyphicon-play icon-white"></i> Play</a>
                                </c:when>

                                <c:otherwise>
                                    <a href='<%= F.asset("/cartmgnt") %>/${product.id}/add' class="btn btn-small"><i class="glyphicon glyphicon-shopping-cart icon-white"></i> Add</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="pagination-wrapper ">
            <ul class="pagination pagination-lg">
                <c:if test="${requestScope.currentpage != 1}">
                    <li><a href="<%= F.asset("/product") %>">Previous</a></li>
                </c:if>
                <c:forEach begin="1" end="${requestScope.totalpage}" step="1" var="i">
                    <c:choose>
                        <c:when test="${requestScope.currentpage == i}">
                        <li class="active"><a href="#">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="<%= F.asset("/product?page=") %>${i}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${requestScope.currentpage != requestScope.totalpage}">
                    <li><a href="<%= F.asset("/product?page="+request.getAttribute("totalpage")) %>">Next</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />