<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
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
<script defer>
    $(document).ready(function () {
        //배너 타이틀 세팅
        $('.banner-title').text('연계 서비스')
        $('.banner-sub-title').text('연계 서비스를 제공합니다')
        $("#lnkTbl tr").click(function () {
            location.href = "${homeUrl}getLinkService?svc_nm=" + $(this).find("td:nth-child(2)").text();
        });

        //페이지 타이틀 세팅
        $('.main-title-text').text('연계 서비스 조회');
        $('.navi-arrow').text(' > 연계 서비스 > 연계 서비스 조회')

        const subTitleArray = ['연계서비스 조회', '연계서비스 등록'];
        subTitleArray.forEach(function (subtitle){
            let html = '<div class="current-title header6">' + subtitle + '</div>'
            $('.current-title-box').append(html);
        })
    });
</script>
