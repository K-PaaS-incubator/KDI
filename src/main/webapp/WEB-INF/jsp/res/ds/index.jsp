<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/ds/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />

<link rel="stylesheet" href="${cssUrl}ds.css">

<div class="mainContent">
	<form action="${pageUrl}" method="GET" id="searchForm">
		<div class="search-box">
			<div>
				<input id="searchKeyword" type="text" placeholder="검색어 입력" value=""> <img src="${imgUrl}icon-search.png" alt="">
			</div>
			<button id="searchBtn" class="button-second-gray">확인</button>
		</div>
	</form>
	<table class="data-list">
		<colgroup>
			<col width="15%">
			<col width="40%">
			<col width="45%">
		</colgroup>
		<thead class="list-head">
			<tr class="subtitle1 gray500">
				<th>No</th>
				<th>데이터소스명</th>
				<th>URL</th>
			</tr>
			<tr class="table-spacing"></tr>
		</thead>
		<tbody id="gridTableDataBody" class="list-body">
			<tr class="subtitle1 gray500">
				<td colspan="3">로딩중</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<div class="ds-list-button-box">
		<input class="button-second" type="button" id="regbtn" value="등록하기" onclick="location.href='${pageUrl}insert'">
		<div class="body2 pagination-ul pageCtlZone"></div>
		<!-- 일단 임시로 이 영역에 구현함 -->
		<div class="body2 gray500">
			<div class="body2">
				<span>전체 :</span> <span class="totalCnt">1</span>건
			</div>
			<div class="body2 gray500">
				<span class="currentPageNum">1</span> / <span class="totalPage">1</span> 페이지
			</div>
		</div>
	</div>
</div>
<table hidden="hidden">
	<tbody id="gridHtmlFormatId">
		<tr class="detailTr" onclick="fn_modify('#DS_NM#');">
			<td>#NO#</td>
			<td>#DS_NM#</td>
			<td>#DS_URL#</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridNoDataHtmlFormatId">
		<tr class="detailTr">
			<td colspan="3">등록된 데이터소스가 없습니다.</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridLoadingHtmlFormatId">
		<tr class="detailTr">
			<td colspan="3">로딩중...</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
</table>
<script defer>
	var grid = KdiListGrid('grid', '${pageUrl}list.json');
	var gridEnv = grid.env;
	gridEnv.setMapping({
		'#DS_NM#' : 'DS_NM',
		'#DS_URL#' : 'DS_URL',
	});
	// gridEnv.setPagePerRow(10);
	gridEnv.loading.enable();
	gridEnv.nodata.enable();
	gridEnv.seq.enable('#NO#');
	gridEnv.setTotalCntId('.totalCnt');
	gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');
	gridEnv.setPageCtlInfo('.pageCtlZone');
	// 파라미터 JSON포맷
	var paramData = {
		'dsNm' : '',
		'dsUrl' : ''
	};
	// 데이터 Load과정에서 에러 발생시 이벤트 정의 예제
	grid.event.setErrEvent(function(xhr) {
		console.log('statusCode:' + xhr.statusCode);
		console.log('responseJSON:' + xhr.responseJSON.state);
		console.log('responseJSON:' + xhr.responseJSON.errMsg);
	});

	var fn_modify = function(ds_nm) {
		location.href = '${pageUrl}modify?dsNm=' + encodeURIComponent(ds_nm);
	};

	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('데이터소스')
		$('.banner-sub-title').text('데이터소스 정보를 제공합니다.')
		//페이지 타이틀 세팅
		$('.main-title-text').text('데이터소스 조회');
		$('.navi-arrow').text(' > 데이터소스 > 데이터소스 조회')

		grid.ready();
		grid.search();
	});
</script>



