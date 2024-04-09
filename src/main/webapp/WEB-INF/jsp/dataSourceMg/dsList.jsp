<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/ds.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
    <div class="mainContent">
        <table class="data-list">
            <colgroup>
                <col width="15%">
                <col width="40%">
                <col width="45%">
            </colgroup>
            <thead class="list-head">
                <tr class="subtitle1 gray500">
                    <th>No</th>
                    <th>데이터소스 제목</th>
                    <th>URL</th>
                </tr>
                <tr class="table-spacing"></tr>
            </thead>
            <tbody id="dsTbl" class="list-body">
                <c:forEach var="dsList" items="${selectDsListPage}">
                    <tr class="subtitle1 gray500">
                        <td>${dsList.num}</td>
                        <td>${dsList.ds_nm}</td>
                        <td>${dsList.ds_url}</td>
                    </tr>
                    <tr class="table-spacing"></tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="ds-list-button-box">
            <input class="button-second" type="button" id="regbtn" value="등록하기" onclick="location.href='${homeUrl}dsCreate'">
            <ul class="pagination-ul">
                <li class="header8 primary pagination-num ${pagination.pageNum == 1 ? "page-num-disabled" : ""}">
                    <a href="dsList?pageNum=${pagination.pageNum - 1}&amount=${pagination.amount}">＜</a>
                </li>

                <c:forEach var="num" begin="${pagination.startPage}" end="${pagination.endPage}">
                    <li class="${pagination.pageNum eq num ? 'page-num-current' : ''} pagination-num ">
                        <a href="dsList?pageNum=${num}&amount=${pagination.amount}">${num}</a>
                    </li>
                </c:forEach>

                <li class="header8 primary pagination-num ${pagination.pageNum == pagination.endPage ? "page-num-disabled" : ""}">
                    <a href="dsList?pageNum=${pagination.pageNum + 1}&amount=${pagination.amount}">＞</a>
                </li>
            </ul>
            <div class="body2 gray500">
                <span>total :</span> <span>${pagination.total}</span>
            </div>
        </div>
    </div>
    <script defer>
        $(document).ready(function () {
            //배너 타이틀 세팅
            $('.banner-title').text('데이터소스')
            $('.banner-sub-title').text('데이터 정보를 한눈에 볼 수 있습니다')
            //페이지 타이틀 세팅
            $('.main-title-text').text('데이터소스 조회');
            $('.navi-arrow').text(' > 데이터소스 > 데이터소스 조회')

            $("#dsTbl tr").click(function () {
                location.href = "${homeUrl}dsEdit?ds_nm=" + $(this).find("td:nth-child(2)").text();
            });

            //서브 메뉴 버튼, 기획 수정으로 제거 됨. 이후에 사용할 수도 있어서 일단 legacy
            // const subTitleArray = [
            //     {subTitle: '데이터소스 조회', url: 'dsList'},
            //     {subTitle: '데이터소스 등록', url: 'dsCreate'},
            // ];
            // subTitleArray.forEach(function (el) {
            //     let html = '<div class="current-title header6" id="' + el.url + '">' + el.subTitle + '</div>';
            //     $('.current-title-box').append(html);
            //     $("#dsList").css('color', '#336AEA');
            //     $("#dsList").css('border-bottom', '6px solid #336AEA');
            // })
        });
    </script>
</section>



