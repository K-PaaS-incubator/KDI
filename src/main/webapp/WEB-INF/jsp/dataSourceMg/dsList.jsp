<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${cssUrl}/ds.css">
    <meta charset="UTF-8">
    <title>데이터소스</title>
    <script>
        $(document).ready(function () {
            $('.banner-title').text('데이터 소스')
            $('.banner-sub-title').text('데이터 정보를 한눈에 볼 수 있습니다')
            $("#dsTbl tr").click(function () {
                location.href = "${homeUrl}dsEdit?ds_nm=" + $(this).find("td:nth-child(2)").text();
            });
        });
    </script>
</head>
<body>
<jsp:include page="../tiles/bannerLayout.jsp"></jsp:include>
<section class="contents">

    <div class="sideMenu">
        <div onclick="location.href='${homeUrl}dsList'">데이터소스 조회</div>
    </div>

    <div class="mainContent">
        <div id="pageTitle">데이터소스 관리</div>
        <table id="dsTbl">
            <thead>
                <tr>
                    <th>No</th>
                    <th>데이터소스 제목</th>
                    <th>URL</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dsList" items="${selectDsList}">
                    <tr>
                        <td>${dsList.no}</td>
                        <td>${dsList.ds_nm}</td>
                        <td>${dsList.ds_url}</td>
                    </tr>
                </c:forEach>

            </tbody>
        </table>

        <div><input type="button" id="regbtn" value="등록" onclick="location.href='${homeUrl}dsCreate'"></div>

    </div>
</section>
</body>
</html>

