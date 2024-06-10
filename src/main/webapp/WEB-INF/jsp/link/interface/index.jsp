<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<c:url var="linkUrl" value="/link/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}link.css">

<jsp:include page="../../component/subBanner.jsp"></jsp:include>
<section class="contents">
	<jsp:include page="../../component/subTitle.jsp"></jsp:include>
	<%--    <form id="searchForm" name="searchForm" method="get">--%>
	<div class="mainContent">
		<form action="${linkUrl}linkList" method="GET" id="searchForm">
			<div class="link-table-box-top">
				<div class="search-box button-second-gray" id="optionPop">⚙️ 서비스제목 및 데이터소스 변경</div>
			</div>
			<div class="search-box">
				<div>
					<input id="searchKeyword" type="text" name="svc_lnk_id" placeholder="검색어 입력" value=""> <img src="${imgUrl}icon-search.png" alt="">
				</div>
				<button id="searchBtn" type="submit" class="button-second-gray">확인</button>
			</div>
		</form>
		<table id="lnkTbl" class="data-list">
			<colgroup>
				<col width="16%">
				<col width="21%">
				<col width="21%">
				<col width="21%">
				<col width="21%">
			</colgroup>
			<thead class="list-head">
				<tr class="subtitle1 gray500">
					<th>No</th>
					<th>연계 인터페이스 ID</th>
					<th>연계 인터페이스 제목</th>
					<th>스키마명</th>
					<th>테이블명</th>
				</tr>
				<tr class="table-spacing"></tr>
			</thead>
			<tbody id="gridTableDataBody" class="list-body">
				<tr class="subtitle1 gray500">
					<td colspan="5">로딩중...</td>
				</tr>
				<tr class="table-spacing"></tr>
			</tbody>
		</table>
		<div class="link-list-button-box">
			<input class="button-second" type="button" id="regbtn" value="등록" onclick="fn_reg();">
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
</section>

<table hidden="hidden">
	<tbody id="gridHtmlFormatId">
		<tr class="detailTr" onclick="fn_modify('#SVC_LNK_ID#')">
			<td>#NO#</td>
			<td>#SVC_LNK_ID#</td>
			<td>#SVC_LNK_NM#</td>
			<td>#SCH_NM#</td>
			<td>#TBL_NM#</td>
		</tr>
		<tr class="table-spacing"></tr>
	</tbody>
	<tbody id="gridNoDataHtmlFormatId">
		<tr class="detailTr">
			<td colspan="5">등록된 인터페이스가 없습니다.</td>
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
	//그리드 객체 생성
	var grid = KdiListGrid('grid', '${linkUrl}interface/list.json');
	var gridEnv = grid.env;
	gridEnv.setMapping({
		'#SVC_LNK_ID#' : 'SVC_LNK_ID',
		'#SVC_LNK_NM#' : 'SVC_LNK_NM',
		'#SCH_NM#' : 'SCH_NM',
		'#TBL_NM#' : 'TBL_NM',
	})

	gridEnv.loading.enable();
	gridEnv.nodata.enable();
	gridEnv.seq.enable('#NO#');
	gridEnv.setTotalCntId('.totalCnt');
	gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');
	gridEnv.setPageCtlInfo('.pageCtlZone', '${homeUrl}');

	var paramData = {
		'svc_id' : '${svc_id}',
		'svc_nm' : '${svc_nm}',
		'ds_nm' : '${ds_nm}'
	};

	grid.event.setErrEvent(function(xhr) {
		console.log('statusCode' + xhr.statusCode);
		console.log('responseJSON' + xhr.responseJSON.state);
		console.log('responseJSON' + xhr.responseJSON.errMsg);
	});

	var fn_reg = function() {
		let interfaceUri = '${linkUrl}interface/data/reg?';
		location.href = '${linkUrl}interface/data/reg'
				+ new URL(location.href).search;
	};

	var fn_modify = function(svc_lnk_id) {
		let tmpUrl = new URL(location.href);
		tmpUrl.searchParams.set('svc_lnk_id',svc_lnk_id);

		let interfaceUri = '${linkUrl}interface/data/modify';
		interfaceUri += tmpUrl.search;
		location.href = interfaceUri;
	};
	
	var fn_iF_option_click = function() {
		const ds_nm = new URL(location.href).searchParams.get('ds_nm');
		const svc_nm = new URL(location.href).searchParams.get('svc_nm');
		const svc_id = new URL(location.href).searchParams.get('svc_id');
		const svc_type = new URL(location.href).searchParams.get('svc_type');
		const parent_id = encodeURIComponent('#searchForm');
		const param = 'svc_type=' + svc_type + '&ds_nm=' + ds_nm + '&svc_nm=' + svc_nm + '&svc_id=' + svc_id;
		const interfacePopUri = '${homeUrl}pop/table/interfacePop?' + param;
		const testUri = 'http://localhost:8080/pop/table/interfacePop'

		let popOption = 'toolbar=no,menubar=no,location=no,status=no';
		popOption += ',scrollbars=yes,resizeable=yes';
		popOption += ',width=510,height=400';
		popOption += ',top=300,left=700';
		
		window.open(interfacePopUri, '_blank', popOption);
	} 

	$().ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('연계서비스');
		$('.banner-sub-title').text('연계서비스를 제공합니다');
		//페이지 타이틀 세팅
		$('.main-title-text').text('연계 인터페이스 조회');
		$('.navi-arrow').text(' > 연계서비스 > 연계서비스 조회 > 연계 인터페이스 조회');

		// 그리드 작업 실행
		grid.ready();
		grid.search(1, paramData);
		
		$('#optionPop').click(fn_iF_option_click);
	});
</script>
