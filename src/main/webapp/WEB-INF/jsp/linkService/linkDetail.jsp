<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="homeUrl" value="/"/>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
    <div class="mainContent">
        <form>
            <div class="content-wrapper" style="margin-top: 20px">
                <div class="left-content">
                    <div class="left-content-title header4 gray500">${getLinkService.ds_nm}</div>
                    <div class="left-content-box">
                        <div class="left-title header5 white100">스키마 선택</div>
                        <ul class="left-content-list-box">
                            <!-- //TODO 스키마명 많을 경우 스크롤로 볼 수 있게 개발 -->
                            <c:forEach var="connectLinkDs" items="${connectLinkDs}">
                                <li class="body2 gray400 selectSch" id="${connectLinkDs}">
                                    <input type="hidden" name="schemaName" value="${connectLinkDs}">${connectLinkDs}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="right-content">
                    <div class="right-content-top">
                        <div class="header6 gray400" id="schemaTitle"></div>
                        <div class="search-box">
                            <div>
                                <input type="text" placeholder="검색">
                                <img src="/img/icon-search.png" alt="">
                            </div>
                            <button id="searchBtn" class="button-second">확인</button>
                        </div>
                    </div>
                    <table id="detailTbl" class="schema-list">
                        <colgroup>
                            <col width="10%">
                            <col width="50%">
                            <col width="15%">
                            <col width="25%">
                        </colgroup>
                        <thead class="list-head">
                            <tr>
                                <th>No</th>
                                <th>테이블명</th>
                                <th>연계여부</th>
                                <th>Comment</th>
                            </tr>
                            <tr class="table-spacing"></tr>
                        </thead>
                        <tbody id="tableData" class="list-body">
                            <!-- <tr class="detailTr">
                                <td>1</td>
                                <td>PUB_TEST_TABLE</td>
                                <td>N</td>
                                <td></td>
                            </tr>
                            <tr class="table-spacing"></tr> -->
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="link-button-box">
                <input class="button-second-gray" type="button" value="취소" onclick="history.back()">
                <input class="button-second" type="button" value="연계테이블 상세 설정 >" id="regbtn" onclick="location.href='${homeUrl}linkTable'">
            </div>

        </form>
    </div>
    <table hidden="hidden">
        <tbody id="detailTblFormat">
            <tr class="detailTr">
                <td>#NO#</td>
                <td>#TABLE_NAME#</td>
                <td>#LINK_YN#</td>
                <td>#COMMENT#</td>
            </tr>
            <tr class="table-spacing"></tr>
        </tbody>
    </table>

    <script>
    	var tableDataHtml = $("#detailTblFormat").html();
    	var loadTableData = function(ds_nm, sch_nm, page){
    		page = page ? page : 1;
    		$.ajax({
                url: '${homeUrl}link/detailService/tableList.json',
                type: 'GET',
                dataType: 'JSON',
                data: {
                	'pageNum':page,
                	'pagePerRow':10,
                	'ds_nm': ds_nm,
                    'sch_nm' : sch_nm
              	}, 
		        contentType : "application/json",
                success: function (result) {
                   var tmp = "";
                   var rowHtml = "";
                   var selData = "";
                   for(var i=0; i < result.data.length; i++){
                	   // row 데이터 가져오기
                	   selData = result.data[i];
                	   // rowHtml내용은 tableDataHtml포멧에서 가져옴
                	   rowHtml = tableDataHtml;
                	   // 컬럼 단위로 값을 변경하는 행위
                	   rowHtml=rowHtml.replaceAll('#NO#', (i+1));
                	   rowHtml=rowHtml.replaceAll('#TABLE_NAME#', selData.TB_NM ? selData.TB_NM : '');
                	   rowHtml=rowHtml.replaceAll('#LINK_YN#', selData.LINK_YN ? selData.LINK_YN : '');
                	   rowHtml=rowHtml.replaceAll('#COMMENT#', selData.TB_COMMENTS ? selData.TB_COMMENTS:'');
                	 
                	   // 완성된 rowHtml을 tmp에 담는 행위
                	   tmp += rowHtml;
                   }
                   $("#tableData").html(tmp);
                },
                error: function (result) {
                    console.log('statusCode:' + result.statusCode);
                    console.log('responseJSON:' + result.responseJSON.state);
                    console.log('responseJSON:' + result.responseJSON.errMsg);
                }
            });
    	};
        $(document).ready(function () {
            //배너 타이틀 세팅
            $('.banner-title').text('연계서비스')
            $('.banner-sub-title').text('연계서비스를 제공합니다')
            //페이지 타이틀 세팅
            $('.main-title-text').text('연계서비스 항목 설정');
            $('.navi-arrow').text(' > 연계서비스 > 연계서비스 등록 > 연계서비스 항목 설정')
            $('#schemaTitle').text("스키마를 선택해 주세요");
        });

        $('.selectSch').click(function () {
            var schemaName = $(this).children("input[name='schemaName']").val();

            $('#schemaTitle').text(schemaName);
            $(".left-content-list-box li").css('background-color', '#ffffff');
            $('#' + schemaName).css('background-color', 'rgba(51, 106, 234, 0.10)');

            loadTableData('${getLinkService.ds_nm}', schemaName);
            //$("#@#####").load("asbvd/asdf34r?schemaName=" + schemaName);
            //location.href = "asbvd/asdf34r?schemaName=" + schemaName;
        });

        //var aa = $("#detailTblFormat").html();
        //aa = aa.replace('#NO', 111).replace("#LINK_YN","X")
        //$("#detailTbl tbody").html(aa);

    </script>

</section>