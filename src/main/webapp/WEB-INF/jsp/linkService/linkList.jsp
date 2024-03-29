<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
    <div class="mainContent">
        <table id="lnkTbl" class="data-list">
            <colgroup>
                <col width="15%">
                <col width="40%">
                <col width="45%">
            </colgroup>
            <thead class="list-head">
                <tr class="subtitle1 gray500">
                    <th>No</th>
                    <th>연계서비스 제목</th>
                    <th>데이터소스 제목</th>
                </tr>
                <tr class="table-spacing"></tr>
            </thead>
            <tbody class="list-body">
                <c:forEach var="linkList" items="${selectLinkList}">
                    <tr class="subtitle1 gray500">
                        <td>${linkList.no}</td>
                        <td>${linkList.svc_nm}</td>
                        <td>${linkList.ds_nm}</td>
                    </tr>
                    <tr class="table-spacing"></tr>
                </c:forEach>
            </tbody>
        </table>
        <div>
            <input class="button-second" type="button" id="regbtn" value="등록" onclick="location.href='${homeUrl}linkService'">
            <div>
                <a class="header8 primary" href=""> < </a>
                <a class="header8 primary" href=""> 1 </a>
                <a class="header8 primary" href=""> 2 </a>
                <a class="header8 primary" href=""> 3 </a>
                <a class="header8 primary" href="">  > </a>
            </div>
        </div>

    </div>
</section>
<script defer>
    $(document).ready(function () {
        //배너 타이틀 세팅
        $('.banner-title').text('연계서비스')
        $('.banner-sub-title').text('연계서비스를 제공합니다')
        //페이지 타이틀 세팅
        $('.main-title-text').text('연계서비스 조회');
        $('.navi-arrow').text(' > 연계서비스 > 연계서비스 조회')

        $("#lnkTbl tr").click(function () {
            location.href = "${homeUrl}getLinkService?svc_nm=" + $(this).find("td:nth-child(2)").text();
        });
    });
</script>
