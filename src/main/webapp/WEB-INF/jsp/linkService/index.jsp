<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="linkUrl" value="/link/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
	<jsp:include page="../component/subTitle.jsp"></jsp:include>
	<div class="mainContent">
		<form action="${linkUrl}" method="GET" id="searchForm">
			<div class="search-box">
				<div>
					<input id="searchKeyword" type="text" name="svc_nm" placeholder="검색어 입력" value=""> <img src="${imgUrl}icon-search.png" alt="">
				</div>
				<button id="searchBtn" type="submit" class="button-second-gray">확인</button>
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
					<th>연계서비스 제목</th>
					<th>데이터소스 제목</th>
				</tr>
				<tr class="table-spacing"></tr>
			</thead>
			<tbody id="gridTableDataBody" class="list-body">
				<c:forEach var="linkList" items="${selectLinkListPage}">
					<tr class="subtitle1 gray500">
						<td colspan="3">로딩중</td>
					</tr>
					<tr class="table-spacing"></tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="link-list-button-box">
			<input class="button-second" type="button" id="regbtn" value="등록" onclick="location.href='${linkUrl}linkService'">
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
			<tr class="detailTr" onclick="linkEdit('#SVC_NM#')">
				<td>#NO#</td>
				<td>#SVC_NM#</td>
				<td>#DS_NM#</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
		<tbody id="gridNoDataHtmlFormatId">
			<tr class="detailTr">
				<td colspan="3">데이터소스가 존재하지 않습니다.</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
		<tbody id="gridLoadingHtmlFormatId">
			<tr  class="detailTr">
				<td colspan="3">로딩중...</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<script defer>
		// 그리드 객체 생성
		var grid = KdiListGrid('grid', '${linkUrl}list.json');
		var gridEnv = grid.env;

		gridEnv.setMapping({
			'#DS_NM#' : 'DS_NM',
			'#SVC_NM#' : 'SVC_NM',
		})

		gridEnv.loading.enable();
		gridEnv.nodata.enable();
		gridEnv.seq.enable('#NO#');
		gridEnv.setTotalCntId('.totalCnt');
		gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');
		gridEnv.setPageCtlInfo('.pageCtlZone', '${homeUrl}');

		var paramData = {
			'ds_nm' : '',
			'svc_nm' : ''
		}

		grid.event.setErrEvent(function (xhr) {
			console.log('statusCode' + xhr.statusCode);
			console.log('responseJSON' + xhr.responseJSON.state);
			console.log('responseJSON' + xhr.responseJSON.errMsg);
		})

		var linkEdit = function(svc_nm) {
			location.href = '${linkUrl}linkInterfaceList?svc_nm=' + svc_nm
		};
		// 그리드 작업 실행
		grid.ready();
		grid.search();

		$(document).ready(function() {
			// 새로고침 시 데이터 초기화
			const entries = performance.getEntriesByType("navigation")[0];
			if (entries.type === "reload") {
				document.location.href = "/link";
			}
			//배너 타이틀 세팅
			$('.banner-title').text('연계서비스')
			$('.banner-sub-title').text('연계서비스를 제공합니다')
			//페이지 타이틀 세팅
			$('.main-title-text').text('연계서비스 조회');
			$('.navi-arrow').text(' > 연계서비스 > 연계서비스 조회')
		});
	</script>
</section>
