<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
    <div class="mainContent">
        <form>
            <div class="search-box">
                <div>
                    <input type="text" placeholder="검색">
                    <img src="/img/icon-search.png" alt="">
                </div>
            </div>
            <div id="inContent">
                <div id="leftContent">
                    <!-- //TODO 선택한 ds_nm이 와야함 -->
                    <div class="leftTitle">${getLinkService.ds_nm}</div>
                    <div></div>
                    <ul>
                        <!-- //TODO 스키마명 많을 경우 스크롤로 볼 수 있게 개발 -->
                        <c:forEach var="connectLinkDs" items="${connectLinkDs}">
                            <li class="selectSch">
                                <input type="hidden" name="schemaName" value="${connectLinkDs}">${connectLinkDs}</li>
                        </c:forEach>
                    </ul>
                </div>

                <div id="rightContent">
                    <!--  //TODO 선택한 ds_nm과 선택한 스키마명이 와야함 -->
                    <div class="subTitle">${getLinkService.ds_nm}<div id="schemaTitle"></div>
                    </div>
                    <!--  //TODO 테이블명 검색기능 -->

                    <table id="detailTbl">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>테이블명</th>
                                <th>연계여부</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="detailTr">
                                <td>1</td>
                                <td>PUB_TEST_TABLE</td>
                                <td>N</td>
                                <td></td>
                            </tr>
                            <tr class="detailTr">
                                <td>2</td>
                                <td>PUB_TEST_TABLE2</td>
                                <td>N</td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>

                </div>
            </div>
            <input type="button" value="다음🔜" id="regbtn" onclick="location.href='${homeUrl}linkTable'">
        </form>
    </div>
    <table hidden="hidden">
        <tbody id="detailTblFormat">
            <tr class="detailTr">
                <td>#NO</td>
                <td>#TABLE_KR</td>
                <td>#LINK_YN</td>
                <td>#COMMENT</td>
            </tr>
        </tbody>
    </table>

    <script>
        $(document).ready(function () {
            //배너 타이틀 세팅
            $('.banner-title').text('연계서비스')
            $('.banner-sub-title').text('연계서비스를 제공합니다')
            //페이지 타이틀 세팅
            $('.main-title-text').text('연계서비스 항목 설정');
            $('.navi-arrow').text(' > 연계서비스 > 연계서비스 등록 > 연계서비스 항목 설정')
        });

        $('.selectSch').click(function () {
            var schemaName = $(this).children("input[name='schemaName']").val();
            $('#schemaTitle').text(schemaName);
            $("#@#####").load("asbvd/asdf34r?schemaName=" + schemaName);
            location.href = "asbvd/asdf34r?schemaName=" + schemaName;
        });


        //var aa = $("#detailTblFormat").html();
        //aa = aa.replace('#NO', 111).replace("#LINK_YN","X")
        //$("#detailTbl tbody").html(aa);

    </script>

</section>