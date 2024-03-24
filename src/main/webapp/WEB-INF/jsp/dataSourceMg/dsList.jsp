<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
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
    <script defer>
        $(document).ready(function () {
            //배너 타이틀 세팅
            $('.banner-title').text('데이터 소스')
            $('.banner-sub-title').text('데이터 정보를 한눈에 볼 수 있습니다')
            $("#dsTbl tr").click(function () {
                location.href = "${homeUrl}dsEdit?ds_nm=" + $(this).find("td:nth-child(2)").text();
            });
            //페이지 타이틀 세팅
            $('.main-title-text').text('데이터소스 관리');
            $('.navi-arrow').text(' > 데이터소스 > 데이터소스 관리 > 데이터소스 조회')

            const subTitleArray = ['데이터소스 조회', '데이터소스 등록', '데이터소스 수정'];
            subTitleArray.forEach(function (subtitle){
                let html = '<div class="current-title header6">' + subtitle + '</div>'
                $('.current-title-box').append(html);
            })
        });
    </script>
</section>



