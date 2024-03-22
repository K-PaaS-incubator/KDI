<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>

<html lang="ko">
<head>
    <link rel="stylesheet" href="${cssUrl}/ds.css">
    <meta charset="UTF-8">
    <title>연계 서비스</title>
    <script>
        $(document).ready(function () {
            $('.banner-title').text('연계 서비스')
            $('.banner-sub-title').text('연계 서비스를 제공합니다')
            $("#lnkTbl tr").click(function () {
                location.href = "${homeUrl}getLinkService?svc_nm=" + $(this).find("td:nth-child(2)").text();
            });
        });
    </script>
</head>
<body>
<jsp:include page="../tiles/bannerLayout.jsp"></jsp:include>
<section class="contents">

    <div class="sideMenu">
        <div onclick="location.href='${homeUrl}linkList'">데이터소스 조회</div>
    </div>

    <div class="mainContent">
        <div id="pageTitle">연계 서비스 관리</div>

        <table id="lnkTbl">
            <thead>
                <tr>
                    <th>No</th>
                    <th>연계서비스 제목</th>
                    <th>데이터소스 제목</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="linkList" items="${selectLinkList}">
                    <tr>
                        <td>${linkList.no}</td>
                        <td>${linkList.svc_nm}</td>
                        <td>${linkList.ds_nm}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div>
            <input type="button" id="regbtn" value="등록" onclick="location.href='${homeUrl}linkService'">
        </div>

    </div>
</section>
</body>
</html>
