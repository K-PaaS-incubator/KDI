<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/tpi/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />

<link rel="stylesheet" href="${cssUrl}ds.css">

<div class="mainContent">
	<form action="${pageUrl}" method="GET" id="searchForm">
		<div class="search-box">
			<div>
				<input id="searchKeyword" type="text" placeholder="검색어 입력" value="">
				<img src="${imgUrl}icon-search.png" alt="">
			</div>
			<button id="searchBtn" class="button-second-gray">확인</button>
		</div>
	</form>
	<table class="data-list">
		<colgroup>
			<col width="7%">
			<col width="25%">
			<col width="25%">
			<col width="10%">
			<col>
		</colgroup>
		<thead class="list-head">
			<tr class="subtitle1 gray500">
				<th>No</th>
				<th>전송경로 ID</th>
				<th>전송경로명</th>
				<th>전송경로 유형</th>
				<th>전송경로</th>
			</tr>
			<tr class="table-spacing"></tr>
		</thead>
		<tbody id="gridTableDataBody" class="list-body">
			<tr class="subtitle1 gray500">
				<td colspan="5">로딩중</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<div class="ds-list-button-box">
		<input class="button-second" type="button" id="regbtn" value="등록하기"
			onclick="location.href='${pageUrl}insert'">
		<div class="body2 pagination-ul pageCtlZone"></div>
		<!-- 일단 임시로 이 영역에 구현함 -->
		<div class="body2 gray500">
			<div class="body2">
				<span>전체 :</span> <span class="totalCnt">1</span>건
			</div>
			<div class="body2 gray500">
				<span class="currentPageNum">1</span> / <span class="totalPage">1</span>
				페이지
			</div>
		</div>
	</div>
</div>
<table hidden="hidden">
	<tbody id="gridHtmlFormatId">
		<tr class="detailTr" onclick="fn_modify('#TRNS_PATH_ID#');">
			<td>#NO#</td>
			<td>#TRNS_PATH_ID#</td>
			<td>#TRNS_PATH_NM#</td>
			<td>#TRNS_PATH_TYPE_NM#</td>
			<td>#TRNS_PATH#</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridNoDataHtmlFormatId">
		<tr class="detailTr">
			<td colspan="5">등록된 인터페이스명이 없습니다.</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridLoadingHtmlFormatId">
		<tr class="detailTr">
			<td colspan="5">로딩중...</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
</table>
<script defer>
	var grid = KdiListGrid('grid', '${pageUrl}list.json');
	var gridEnv = grid.env;
	gridEnv.setMapping({
		'#TRNS_PATH_ID#' : 'TRNS_PATH_ID',
		'#TRNS_PATH_NM#' : 'TRNS_PATH_NM',
		'#TRNS_PATH_TYPE_NM#' : 'TRNS_PATH_TYPE_NM',
		'#TRNS_PATH#' : 'TRNS_PATH'
	});
	// gridEnv.setPagePerRow(10);
	gridEnv.loading.enable();
	gridEnv.nodata.enable();
	gridEnv.seq.enable('#NO#');
	gridEnv.setTotalCntId('.totalCnt');
	gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');
	gridEnv.setPageCtlInfo('.pageCtlZone', '${homeUrl}');
	// 파라미터 JSON포맷
	var paramData = {
		'trnsPathId' : '',
		'trnsPathNm' : '',
		'trnsPathType' : '',
		'trnsPath' : ''
	};
	// 데이터 Load과정에서 에러 발생시 이벤트 정의 예제
	grid.event.setErrEvent(function(xhr) {
		console.log('statusCode:' + xhr.statusCode);
		console.log('responseJSON:' + xhr.responseJSON.state);
		console.log('responseJSON:' + xhr.responseJSON.errMsg);
	});

	var fn_modify = function(ifId) {
		location.href = '${pageUrl}modify?trnsPathId=' + encodeURIComponent(ifId);
	};

	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('전송경로 정보');
		$('.banner-sub-title').text('전송경로 정보를 한눈에 볼 수 있습니다');
		//페이지 타이틀 세팅
		$('.main-title-text').text('전송경로 정보 조회');
		$('.navi-arrow').text(' > 자원관리 > 전송경로 정보')

		grid.ready();
		grid.search();
	});
</script>



