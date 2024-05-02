<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
	<jsp:include page="../component/subTitle.jsp"></jsp:include>
	<div class="mainContent">
		<form>
			<div class="content-wrapper" style="margin-top: 20px">
				<div class="left-content">
					<div class="left-content-title header4 gray500" title="${getLinkService.ds_nm}">${getLinkService.ds_nm}</div>
					<div class="left-content-box">
						<div class="left-title header5 white100">스키마 선택</div>
						<ul class="left-content-list-box">
							<!-- //TODO 스키마명 많을 경우 스크롤로 볼 수 있게 개발 -->
							<c:forEach var="connectLinkDs" items="${connectLinkDs}">
								<li class="body2 gray400 selectSch" id="${connectLinkDs}"><input type="hidden" name="schemaName" value="${connectLinkDs}">${connectLinkDs}</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="right-content">
					<div class="right-content-top">
						<div class="header6 gray400" id="schemaTitle"></div>
						<div class="search-box">
							<div>
								<input type="text" placeholder="검색"> <img src="${imgUrl}icon-search.png" alt="">
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
						<tbody id="gridTableDataBody" class="list-body">
							<tr class="detailTr">
								<td colspan="4">스키마를 선택해 주세요</td>
							</tr>
							<tr class="table-spacing"></tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 일단 임시로 이 영역에 구현함 -->
			<div class="link-button-box">
				<div class="body2">
					<span>전체 :</span> <span class="totalCnt">1</span>건
				</div>
				<!-- 이 영역에 구현된 페이지 번호영역은 static/html/kdi/pagination-num.html에 구현함 -->
				<div class="body2 pagination-ul pageCtlZone"></div>
				<div class="body2 gray500">
					<span class="currentPageNum">1</span> / <span class="totalPage">1</span> 페이지
				</div>
			</div>
			<div class="link-button-box">
				<input class="button-second-gray" type="button" value="취소" onclick="history.back()"> <input class="button-second" type="button" value="연계테이블 상세 설정 >" id="regbtn"
					onclick="location.href='${homeUrl}linkTable'">
			</div>
		</form>
	</div>
	<table hidden="hidden">
		<tbody id="gridHtmlFormatId">
			<tr class="detailTr">
				<td>#NO#</td>
				<td>#TABLE_NAME#</td>
				<td>#LINK_YN#</td>
				<td>#COMMENT#</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
		<tbody id="gridNoDataHtmlFormatId">
			<tr class="detailTr">
				<td colspan="4">테이블이 존재하지 않습니다.</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
		<tbody id="gridLoadingHtmlFormatId">
			<tr class="detailTr">
				<td colspan="4">로딩중...</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>

	<script>
		// 	선언한 변수명, 주소
		var grid = KdiListGrid('grid',
				'${homeUrl}link/detailService/tableList.json');

		// 그리드 세부조작시 사용하는 환경설정
		var gridEnv = grid.env;
		// kdiListGrid 생성과정에서 url 정보를 입력안하거나 변경시 사용
		// gridEnv.setUrl('호출할URL주소');

		// 입력한 JSON 데이터는 {'치환할 태그명':'조회된값의Key명'} 구조로 입력
		// html포맷과 데이터를 매핑하는 작업으로 JSON포맷으로 입력
		gridEnv.setMapping({
			'#TABLE_NAME#' : 'TB_NM',
			'#LINK_YN#' : 'LINK_YN',
			'#COMMENT#' : 'TB_COMMENTS'
		});

		// 페이지당 출력건수 변경기능 (기본값:10)
		// gridEnv.setPagePerRow(10);

		// 검색결과를 출력할때 사용할 html포맷
		// gridEnv.setGridHtmlFormatId('#gridHtmlFormatId');

		// 검색결과를 Html포맷을 기준으로 작성할 위치 (기본값 : #gridTableDataBody)
		// gridEnv.setTableDataBodyId('#gridTableDataBody');

		// 로딩 기능을 사용할때 로딩과정에 보여줄 html포맷 (기본값:#gridLoadingHtmlFormatId)
		// 이 함수를 호출하면 자동으로 gridEnv.loading.enable();가 호출된다.
		// gridEnv.loading.setGridLoadingHtmlFormatId('#gridLoadingHtmlFormatId');

		// 로딩기능 이용시 호출한다. 다시 비활성화하가 위해서는 gridEnv.loading.enable();을 호출하면 된다.
		gridEnv.loading.enable();

		// 데이터가 없는경우 출력할 내용을 설정한다.
		//gridEnv.setGridNoDataHtmlFormatId('#gridNoDataHtmlFormatId');
		gridEnv.nodata.enable();

		// 순번 사용시 순번이 들어가는 곳의 명칭을 입력한다.
		gridEnv.seq.enable('#NO#');

		// 전체건수 정의 (미사용시 정의 불필요, 정의 후 다시 비활성화하고싶으면 공백입력)
		gridEnv.setTotalCntId('.totalCnt');

		// 페이지번호 설정
		// 파라미터 : 현재페이지ID, 전체페이지ID
		// 미사용시 정의 불필요, 정의 후 다시 비활성화하고싶으면 공백입력
		gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');

		// 페이지제어 설정
		// 페이지 번호 영역, 현재 페이지표기 class명, 비활성화표기 class명, 디자인html파일경로 및 추출영역
		// 페이지 번호 영역 호출 및 적용기능
		gridEnv.setPageCtlInfo('.pageCtlZone', '${homeUrl}');

		// 파라미터 JSON포맷
		var paramData = {
			'ds_nm' : '${getLinkService.ds_nm}',
			'sch_nm' : ''
		};

		// 데이터 Load과정에서 에러 발생시 이벤트 정의 예제
		var errEvent = function(xhr) {
			console.log('statusCode:' + xhr.statusCode);
			console.log('responseJSON:' + xhr.responseJSON.state);
			console.log('responseJSON:' + xhr.responseJSON.errMsg);
		}
		// 안쓰려면 호출안하면 됨
		grid.event.setErrEvent(errEvent);

		// 페이지당 출력건수를 변경하려면 아래 함수 호출
		//gridEnv.setPagePerRow(10);

		$(document).ready(function() {
			// 검색 준비가 된 시점으로 최소 documnet 준비된 시점에 호출되어야 한다.
			grid.ready();

			//배너 타이틀 세팅
			$('.banner-title').text('연계서비스');
			$('.banner-sub-title').text('연계서비스를 제공합니다');
			//페이지 타이틀 세팅
			$('.main-title-text').text('연계서비스 항목 설정');
			$('.navi-arrow').text(' > 연계서비스 > 연계서비스 등록 > 연계서비스 항목 설정');
			$('#schemaTitle').text("스키마를 선택해 주세요");

		});

		$('.selectSch')
				.click(
						function() {
							var schemaName = $(this).children(
									"input[name='schemaName']").val();

							$('#schemaTitle').text(schemaName);
							$(".left-content-list-box li").css(
									'background-color', '#ffffff');
							// 스키마명에 특수만자가 오는 경우 원화기호 붙여주도록 수정
							var schId = '#'
									+ schemaName.replaceAll(/([^\w\s])/g,
											'\\\$&');
							$(schId).css('background-color',
									'rgba(51, 106, 234, 0.10)');

							paramData['sch_nm'] = schemaName;
							grid.search(1, paramData);
						});
		// 검색할때 paramData에 검색값을 넘김
		// 따라서 이 화면에서 테이블명을 검색한다고 한다면 아래와 같이사용
		// paramData['tb_nm'] = '검색어'
		// 그 외 지원되는 검색조건 link_yn, tb_comments
		// 통합검색인 경우 paramData['all_search'] 조건인 경우 모든 컬럼에서 조회하는 조건임
	</script>

</section>