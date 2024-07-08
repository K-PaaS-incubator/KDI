<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<c:url var="pageUrl" value="/res/link/sub/" />
<link rel="stylesheet" href="${cssUrl}link.css">
<script src="${jsUrl}kdi/kdi-main-data.js"></script>
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<style>
div[class*='detail-'] {
	display: none;
}

.guide-box {
	display: none;
	text-align: left;
}

.show .guide-box {
	display: block;
}

.hide {
	display: none;
}
</style>
<div class="mainContent">
	<!-- 연계 수신 정보 수정 (KDI_LINK_SUB_INF, KDI_LINK_SUB_TBL_INF)-->
	<form id="modify">
		<input type="hidden" id="SVC_ID" name="svcId" value="${svcId}"> <input type="hidden" id="DS_NM" name="dsNm">
		<div class="link-table-wrapper">
			<div class="link-table-box-top">
				<div class="link-table-box-top-left">
					<div class="link-inputs-row">
						<div class="common-input-box">
							<div class="header6 label-title">인터페이스ID</div>
							<input class="common-input subtitle1 gray400 pk id-pattern" type="text" id="SVC_LNK_ID" name="svcLnkId" readonly="readonly">
							<div class="header6 label-title">인터페이스명</div>
							<input class="common-input subtitle1 gray400" type="text" id="SVC_LNK_NM" name="svcLnkNm">
						</div>
						<div class="common-input-box">
							<div class="header6 label-title">스키마명</div>
							<input class="common-input subtitle1 gray400 tableSearch" type="text" id="SCH_NM" name="schNm" readonly="readonly">
							<div class="header6 label-title">테이블명</div>
							<input class="common-input subtitle1 gray400 tableSearch" type="text" id="TBL_NM" name="tblNm" readonly="readonly">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="link-table-wrapper">
			<div class="link-table-box-bottom">
				<table class="link-table-list">
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="15%">
						<col width="10%">
						<col width="20%">
						<col width="5%">
					</colgroup>
					<thead class="list-head">
						<tr class="subtitle1 gray500">
							<th>컬럼명</th>
							<th>컬럼명 매핑 <span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""> <span class="guide-box bg-gray400 subtitle2 white100"> <c:out
											value="컬럼명을 변경하여 송신할 경우 명시" escapeXml="false" />
								</span> </span>
							</th>
							<th>컬럼 타입</th>
							<th>연계 여부</th>
							<!-- th>연계 플래그 매핑</th -->
							<th>컬럼 설명 <span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""> <span class="guide-box bg-gray400 subtitle2 white100"> <c:out
											value="데이터베이스에 명시된 컬럼 Comment 출력" escapeXml="false" />
								</span> </span>
							</th>
							<th>삭제<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="삭제 되었거나 임의추가한 컬럼만 삭제 가능함" escapeXml="false" /></span></span></th>
						</tr>
						<tr class="table-spacing"></tr>
					</thead>
					<tbody class="list-body" id="gridTableDataBody">
						<tr class="detailTr">
							<td colspan="5">연계할 스키마와 테이블을 선택하세요.</td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>
		<div class="link-button-box">
			<input id="previousBtn" class="button-second" type="button" value="이전"> <input id="deleteBtn" class="button-second-gray" type="button" value="삭제"> <input id="modifyBtn" class="button-primary" type="button" value="저장">
		</div>
	</form>
</div>
<div style="display: none;">
	<table>
		<tbody id="gridHtmlFormatId">
			<tr id="#COL_NAME#" class="subtitle1 gray500 child_row">
				<td style="display: none;">
					<!-- input 항목을 한눈에 보기위해서 만들어진 숨겨진 td임 큰의미는 없음 -->
					<ul>
						<!-- 코드 정렬시 줄바꿈 방지 목적 ul li는 큰의미는 없음 -->
						<li><input type="hidden" name="colName" value="#COL_NAME#"></li>
						<li><input type="hidden" name="colType" value="#COL_TYPE#"></li>
						<li><input type="hidden" name="colCurrentType" value="#COL_CURRENT_TYPE#"></li>
					</ul>
				</td>
				<td>#COL_NAME#</td>
				<td><input type="text" class="w90ps" name="colNmMp" value="#COL_NM_MP#" maxlength="60"></td>
				<td class="ta-l">#COL_TYPE#</td>
				<td class="ta-c"><input class="tdIsConnect check-#COL_LNK_YN#" type="checkbox" name="colLnkYn" value="Y"></td>
				<td class="ta-l">#COMMENTS#</td>
				<td class="ta-l"><a class="hide" href="javascript:delOneChild('#COL_NAME#');">🗑️</a></td>
			</tr>
		</tbody>
	</table>
	<table>
		<tbody id="gridNoDataHtmlFormatId">
			<tr class="detailTr">
				<td colspan="5">컬럼이 존재하지 않습니다.</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<table>
		<tbody id="gridLoadingHtmlFormatId">
			<tr class="detailTr">
				<td colspan="5">로딩중...</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
</div>
<script>
	//KdiListGrid 시작 >>>>>
	const grid = KdiListGrid('grid', '${pageUrl}tbl/list.json');
	const gridEnv = grid.env;
	gridEnv.setPagePerRow(100);
	gridEnv.setMapping({
		'#COL_NAME#' : 'COLUMN_NAME',
		'#COL_TYPE#' : 'DATA_TYPE',
		'#COMMENTS#' : 'COMMENTS',
		'#COL_NM_MP#' : 'COL_NM_MP',
		'#COL_LNK_YN#' : 'COL_LNK_YN',
		'#COL_CURRENT_TYPE#' : 'COL_CURRENT_TYPE'
	});
	// 데이터 Load과정에서 에러 발생시 이벤트 정의 예제 ( 안쓰려면 호출안하면 됨)
	var errEvent = function(xhr) {
		/* console.log('statusCode:' + xhr.statusCode);
		console.log('responseJSON:' + xhr.responseJSON.state);
		console.log('responseJSON:' + xhr.responseJSON.errMsg); */
		alert(xhr.responseJSON.errMsg);
	}
	grid.event.setErrEvent(errEvent);
	grid.event.setPostEvent(function() {
		$('.check-Y').prop('checked', true);
		// 컬럼정보까지 불러와졌으면 쿼리생성관련 이벤트 적용
		
		// 삭제된 컬럼은 삭제할 수 있도록 버튼 활성화
		$('input[name="colCurrentType"][value="DEL"]').parents('tr').find('a')
				.removeClass('hide');
		// 임의추가된 컬럼은 삭제할 수 있도록 버튼 활성화
		$('input[name="colCurrentType"][value="USR"]').parents('tr').find('a')
				.removeClass('hide');
	});
	
	gridEnv.loading.enable();
	gridEnv.nodata.enable();
	// KdiListGrid 끝 <<<<<

	const fn_data_source_load = function() {
		// 데이터 소스 정보 불러오기
		var svcId = $('#SVC_ID').val();
		const svcInfoData = KdiData().getSvcInfo(svcId);
		$('#DS_NM').val(svcInfoData.DS_NM);
	};

	var fn_tb_nm_click = function() {
		const ds_nm = $('#DS_NM').serialize();
		const parentId = encodeURIComponent('form');
		const param = ds_nm + '&parentId=' + parentId;
		const tablePopUri = contextPath + 'res/table?' + param;

		let popOption = 'toolbar=no,menubar=no,location=no,status=no';
		popOption += ',scrollbars=yes,resizeable=yes';
		popOption += ',width=900,height=800';
		window.open(tablePopUri, '_blank', popOption);
	}

	// 선택한 스키마,테이블 내 전 컬럼 로드
	var fn_load_columns = function() {

		// 파라미터 JSON포맷
		let paramData = {
			'svcLnkId' : $('#SVC_LNK_ID').val(),
			'dsNm' : $('#DS_NM').val(),
			'schemaName' : $('#SCH_NM').val(),
			'tableName' : $('#TBL_NM').val()
		};

		grid.search(1, paramData);
	}

	// 페이지 기본 정보 불러온 다음 해야할 업무 순서 정보 
	const postEvent = [ fn_data_source_load, fn_load_columns];

	$(document).ready(
			function() {
				// 검색 준비가 된 시점으로 최소 document 준비된 시점에 호출되어야 한다.
				grid.ready();
				const PageLoader = fn_modify_page_load('연계 수신서비스', '수신 테이블 정보',postEvent);
				PageLoader.setPreviouParam($('input[name="svcId"]').serialize());
				PageLoader.setChildTable('.child_row');

				// 스키마명 테이블명 검색 팝업 이벤트 등록
				$('form input.tableSearch').click(fn_tb_nm_click);

			});
	
	// 삭제기능 추가
	const delOneChild = function(colNm) {
		let svcLnkId = $('input[name="svcLnkId"]').val();
		let schNm = $('input[name="schNm"]').val();
		let tblNm = $('input[name="tblNm"]').val();
		let dsNm = $('input[name="dsNm"]').val();
		$.ajax({
			url : '${pageUrl}tbl/delete.json',
			type : 'POST',
			dataType : 'JSON',
			data : {
				colNm : colNm,
				svcLnkId : svcLnkId,
				schNm : schNm,
				tblNm : tblNm,
				dsNm : dsNm
			},
			success : function(result) {
				location.reload();
			},
			error : function(result) {
				if (result.status != '400') {
					alert(responseJSON.state + "\n" + responseJSON.msg);
				} else {
					alert("삭제실패\n" + result);
				}
			}
		});
	}
</script>
