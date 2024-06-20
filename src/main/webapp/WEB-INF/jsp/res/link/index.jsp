<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/link/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}link.css">

<div class="mainContent">
	<form action="${pageUrl}" method="GET" id="searchForm">
		<div class="search-box">
			<div>
				<input id="searchKeyword" type="text" name="svc_nm" placeholder="검색어 입력" value=""> <img src="${imgUrl}icon-search.png" alt="">
			</div>
			<button id="searchBtn" type="submit" class="button-second-gray">확인</button>
		</div>
	</form>
	<table class="data-list">
		<colgroup>
			<col width="10%">
			<col width="10%">
			<col>
			<col width="24%">
			<col width="20%">
			<col width="6%">
		</colgroup>
		<thead class="list-head">
			<tr class="subtitle1 gray500">
				<th>No</th>
				<th>유형</th>
				<th>연계서비스명</th>
				<th>데이터소스명</th>
				<th>토픽명</th>
				<th>🚮</th>
			</tr>
			<tr class="table-spacing"></tr>
		</thead>
		<tbody id="gridTableDataBody" class="list-body">
			<tr class="detailTr gray500">
				<td colspan="6">로딩중</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<div class="link-list-button-box">
		<input class="button-second" type="button" id="regbtn" value="등록" onclick="location.href='${pageUrl}insert'">
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
		<tr class="detailTr dataTr">
			<td>#NO#</td>
			<td><input type="hidden" name="svcType" value="#SVC_TYPE#">#SVC_TYPE_NAME#</td>
			<td><input type="hidden" name="svcNm" value="#SVC_NM#">#SVC_NM#</td>
			<td><input type="hidden" name="dsDm" value="#DS_NM#">#DS_NM#</td>
			<td><input type="hidden" name="tpDm" value="#TP_NM#">#TP_NM#</td>
			<td hidden="hidden"><input type="hidden" name="svcId" value="#SVC_ID#"></td>
			<td id="lnkDelBtn" onclick="fn_del('#SVC_ID#');">🗑️</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridNoDataHtmlFormatId">
		<tr class="detailTr">
			<td colspan="6">연계서비스가 존재하지 않습니다.</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridLoadingHtmlFormatId">
		<tr class="detailTr">
			<td colspan="6">로딩중...</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
</table>
<script defer>
	// 그리드 객체 생성
	var grid = KdiListGrid('grid', '${pageUrl}list.json');
	var gridEnv = grid.env;

	gridEnv.setMapping({
		'#SVC_ID#' : 'SVC_ID',
		'#DS_NM#' : 'DS_NM',
		'#TP_NM#' : 'TP_NM',
		'#SVC_NM#' : 'SVC_NM',
		'#SVC_TYPE#' : 'SVC_TYPE',
		'#SVC_TYPE_NAME#' : 'SVC_TYPE_NAME'
	});

	gridEnv.loading.enable();
	gridEnv.nodata.enable();
	gridEnv.seq.enable('#NO#');
	gridEnv.setTotalCntId('.totalCnt');
	gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');
	gridEnv.setPageCtlInfo('.pageCtlZone', '${homeUrl}');

	var paramData = {
		'dsNm' : '',
		'svcNm' : ''
	};

	grid.event.setErrEvent(function(xhr) {
		console.log('statusCode' + xhr.statusCode);
		console.log('responseJSON' + xhr.responseJSON.state);
		console.log('responseJSON' + xhr.responseJSON.errMsg);
	});

	grid.event.setPostEvent(function() {
		$('#gridTableDataBody tr.dataTr').click(
				function() {
					let svcTypeUrl = $(this).find('input[name="svcType"]')
							.val()
							|| 'P';
					const svcId = $(this).find('input[name="svcId"]')
							.serialize();
					console.log(svcTypeUrl);
					if ('P' == svcTypeUrl) {
						svcTypeUrl = 'pub';
					} else {
						svcTypeUrl = 'sub';
					}
					location.href = '${pageUrl}' + svcTypeUrl + '?' + svcId;
				});
	});

	var fn_del = function(svcId) {
		if (confirm('연계서비스를 삭제하시겠슴까?') == true) {
			$.ajax({
				url : '${pageUrl}delete.json',
				type : 'POST',
				data : {
					svcId : encodeURIComponent(svcId)
				},
				dataType : 'JSON',
				success : function(result) {
					alert('연계서비스를 삭제 하였습니다.');
					location.reload();
				},
				error : function(result) {
					console.log('statusCode:' + result.statusCode);
					console.log('responseJSON:' + result.responseJSON.state);
					console.log('responseJSON:' + result.responseJSON.msg);
					alert('연계서비스 삭제 실패');
				}
			});
		} else {
			return;
		}
	}

	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('연계서비스');
		$('.banner-sub-title').text('연계서비스를 제공합니다');
		//페이지 타이틀 세팅
		$('.main-title-text').text('연계서비스 조회');
		$('.navi-arrow').text(' > 연계서비스 > 연계서비스 조회');

		// 그리드 작업 실행
		grid.ready();
		grid.search();

	});
</script>
