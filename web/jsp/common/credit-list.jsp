<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="help.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="header.jsp" />
<!-- Page Title -->
<div class="section section-breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Your Credit Log</h1>
            </div>
        </div>
    </div>
</div>

<div class="section">
    <div class="container">
        <div class="row">
            <!-- Open Vacancies List -->
            <div class="col-md-12">
                <table class="jobs-list">
                    <tr>
                        <th>Detail</th>
                        <th>Amount Changed</th>
                        <th>New Credit</th>
                        <th>Old Credit</th>
                        <th>Changed By</th>
                        <th>Timestamp</th>
                    </tr>
                    <c:forEach var="log" items="${requestScope.list}">
                        <tr>
                            <td>
                                ${log.detail}
                            </td>
                            <td style="text-align: right;">
                                <c:choose>
                                    <c:when test="${log.diff >= 0}"><p class="text-success">+</c:when>
                                    <c:otherwise><p class="text-danger"></c:otherwise>
                                    </c:choose><fmt:formatNumber type="number" maxFractionDigits="2" value="${log.diff}"/></p>
                                </td>
                                <td style="text-align: right;">
                                <fmt:formatNumber type="number" maxFractionDigits="2" value="${log.new_credit}"/>
                            </td>
                            <td style="text-align: right;">
                                <fmt:formatNumber type="number" maxFractionDigits="2" value="${log.old_credit}"/>
                            </td>
                            <td>
                                ${log.change_by.fullname}
                            </td>
                            <td>
                                <fmt:parseDate value="${log.created_at}" pattern="yyyy-MM-dd HH:mm:ss.S" var="createdate"/>
                                <fmt:formatDate value="${createdate}" pattern="dd MMMMM yyyy HH:mm:ss"/>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="pagination-wrapper ">
            <ul class="pagination pagination-lg">
                <c:if test="${requestScope.currentpage > 1}">
                    <li><a href="<%= F.asset("/credit?page=")%>${requestScope.currentpage-1}">Previous</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${requestScope.totalpage}" step="1" var="i">
                        <c:choose>
                            <c:when test="${requestScope.currentpage == i}">
                            <li class="active"><a href="#">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                            <li><a href="<%= F.asset("/credit?page=")%>${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${requestScope.currentpage < requestScope.totalpage}">
                        <c:if test="${requestScope.totalpage != 0}">
                        <li><a href="<%= F.asset("/credit?page=")%>${requestScope.currentpage+1}">Next</a></li>
                        </c:if>
                    </c:if>
            </ul>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />