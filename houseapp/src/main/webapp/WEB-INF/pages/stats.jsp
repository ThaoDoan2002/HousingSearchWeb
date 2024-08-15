<%-- 
    Document   : stats
    Created on : Jun 21, 2024, 10:53:23 AM
    Author     : doant
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<h1 class="text-center text-info mt-1">THÔNG KÊ BÁO CÁO</h1>

<div class="row">
    <div class="col-md-5 col-12">
        <form>
            <div class="form-floating mb-3 mt-3">
                <input type="text" value="${param.year}" class="form-control" id="year" placeholder="Năm" name="year">
                <label for="year">Năm</label>
            </div>
            <div class="form-floating mb-3 mt-3">
                <select class="form-select" id="period" name="period">
                    <option value="MONTH" selected>Theo tháng</option>
                    <c:choose>
                        <c:when test="${param.period=='QUARTER'}">
                            <option value="QUARTER" selected>Theo quý</option>
                        </c:when>
                        <c:otherwise>
                            <option value="QUARTER">Theo quý</option>
                        </c:otherwise>
                    </c:choose>
                </select>
                <label for="period" class="form-label">Chọn thời gian:</label>
            </div>
            <div class="form-floating mb-3 mt-3">
                <button class="btn btn-success">Lọc</button>
            </div>
        </form>
        <%@ page import="java.util.Date" %>
        <jsp:useBean id="now" class="java.util.Date" />
        <c:if test="${param.year != null}">
            <div class="alert alert-info">
                <h4>Năm: ${param.year}</h4>
                <h4>Thời gian: ${param.period}</h4>
            </div>
        </c:if>
        <table class="table table-striped">
            <tr>
                <c:choose >
                    <c:when test="${param.period =='MONTH'}">
                        <th>Thời gian (tháng)</th>
                        </c:when>
                        <c:otherwise>
                        <th>Thời gian (quý)</th>
                        </c:otherwise>
                    </c:choose >

                <th>Quyền truy cập</th>
                <th>Số lượng</th>
            </tr>
            <c:forEach items="${revenueByPeriod}" var="p">
                <tr>
                    <td>${p[0]}</td>
                    <td>${p[1]}</td>
                    <td>${p[2]}</td>
                </tr>
            </c:forEach>
        </table>


    </div>

    <div class="col-md-7 col-12">
        <canvas id="myChart"></canvas>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="<c:url value="js/stats.js" />"></script>
<script>
    const dataFromBackend = ${fn:escapeXml(revenueByPeriod)};

    // Debug: Log the data to ensure it is received correctly
    console.log("Revenue by Period:", dataFromBackend);
</script>