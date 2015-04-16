<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Your Inventory</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <% if (request.getSession().getAttribute("message") != null) { %>
            <div class="alert alert-${message_type}" role="alert">
                <span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span>
                ${message}
            </div>
            <c:remove var="message" scope="session" /> 
            <c:remove var="message_type" scope="session" /> 
            <% }%>
            <c:forEach var="product" items="${list}">
                <div class="col-md-4 col-sm-6">
                    <div class="portfolio-item">
                        <div class="portfolio-image">
                            <a href="<%= F.asset("/product")%>/${product.project_id}/view"><img src="${product.project.cover}" style="height: 215px" alt="${product.project.title}"></a>
                        </div>
                        <div class="portfolio-info-fade">
                            <ul>
                                <li class="portfolio-project-name">${product.project.title}</li>
                                <li><strong>ซื้อเมื่อ: </strong>${product.created_at}</li>
                                <li><strong>เซฟครั้งสุดท้าย: </strong>
                                    <c:choose>
                                        <c:when test="${product.last_play == null}">
                                            คุณยังไม่เคยเล่นเกมนี้
                                        </c:when>
                                        <c:otherwise>
                                            ${product.last_play}
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="read-more"><a href='<%= F.asset("/project")%>/${product.project_id}/play' class="btn">Play</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>

        <div class="pagination-wrapper ">
            <ul class="pagination pagination-lg">
                <c:if test="${requestScope.currentpage > 1}">
                    <li><a href="<%= F.asset("/inventory?page=")%>${requestScope.currentpage-1}">Previous</a></li>
                </c:if>
                <c:forEach begin="1" end="${requestScope.totalpage}" step="1" var="i">
                    <c:choose>
                        <c:when test="${requestScope.currentpage == i}">
                        <li class="active"><a href="#">${i}</a></li>
                        </c:when>
                        <c:otherwise>
                        <li><a href="<%= F.asset("/inventory?page=")%>${i}<c:if test="${searchKey != null}">&search=${searchKey}</c:if>">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${requestScope.currentpage < requestScope.totalpage}">
                    <c:if test="${requestScope.totalpage != 0}">
                    <li><a href="<%= F.asset("/inventory?page=")%>${requestScope.currentpage+1}<c:if test="${searchKey != null}">&search=${searchKey}</c:if>">Next</a></li>
                    </c:if>
                </c:if>
            </ul>
    </div>
</div>

<jsp:include page="footer.jsp" />