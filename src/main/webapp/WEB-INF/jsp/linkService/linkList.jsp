<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
    <%--    <form id="searchForm" name="searchForm" method="get">--%>
    <div class="mainContent">
        <form action="/link/linkList" method="GET" id="searchForm">
            <div class="search-box">
                <div>
                    <input id="searchKeyword" type="text" name="svc_nm" placeholder="검색어 입력" value="">
                    <img src="/img/icon-search.png" alt="">
                </div>
                <button id="searchBtn" type="submit" class="button-second-gray">확인</button>
            </div>
        </form>
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
                <c:forEach var="linkList" items="${selectLinkListPage}">
                    <tr class="subtitle1 gray500">
                        <td>${linkList.num}</td>
                        <td>${linkList.svc_nm}</td>
                        <td>${linkList.ds_nm}</td>
                    </tr>
                    <tr class="table-spacing"></tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="link-list-button-box">
            <input class="button-second" type="button" id="regbtn" value="등록" onclick="location.href='${homeUrl}linkService'">
            <ul class="pagination-ul">
                <li class="header8 primary pagination-num ${pagination.pageNum == 1 ? "page-num-disabled" : ""}" >
                    <a href="linkList?pageNum=${pagination.pageNum - 1}&amount=${pagination.amount}">＜</a>
                </li>

                <c:forEach var="num" begin="${pagination.startPage}" end="${pagination.endPage}">
                    <li class="${pagination.pageNum eq num ? 'page-num-current' : ''} pagination-num ">
                        <a href="linkList?pageNum=${num}&amount=${pagination.amount}">${num}</a>
                    </li>
                </c:forEach>

                <li class="header8 primary pagination-num ${pagination.pageNum == pagination.endPage ? "page-num-disabled" : ""}">
                    <a href="linkList?pageNum=${pagination.pageNum + 1}&amount=${pagination.amount}">＞</a>
                </li>
            </ul>
            <div class="body2 gray500">
                <span>total :</span> <span>${pagination.total}</span>
            </div>
        </div>
    </div>
    <%--    </form>--%>
</section>
<script defer>
    $(document).ready(function () {
        // 새로고침 시 데이터 초기화
        const entries = performance.getEntriesByType("navigation")[0];
        if (entries.type === "reload") {
            document.location.href = "/link/linkList";
        }
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

    function fn_sendPageNumber(no) {
        var frm = document.searchForm;
        frm.num.value = no;
        frm.action = "/link/linkList"
        frm.submit();

        event.preventDefault();
    }
</script>
