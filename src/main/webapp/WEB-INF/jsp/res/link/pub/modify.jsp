<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<c:url var="pageUrl" value="/res/link/pub/" />
<link rel="stylesheet" href="${cssUrl}link.css">
<script src="${jsUrl}kdi/kdi-main-data.js"></script>
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<script src="${jsUrl}kdi/kdi-link.js"></script>
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

tr.col-del {
	background-color: #fff0f0 !important;
}
</style>
<div class="mainContent">
	<!-- 연계 송신업무 서비스 수정(KDI_LINK_PUB_INF, KDI_LINK_PUB_TBL_INF )-->
	<form id="modify">
		<input type="hidden" id="SVC_ID" name="svcId" value="${svcId}"> <input type="hidden" id="DS_NM" name="dsNm">
		<div class="link-table-wrapper">
			<div class="link-table-box-top">
				<div class="link-table-box-top-left">
					<div class="link-inputs-row">
						<div class="common-input-box">
							<div class="header6 label-title pk-title">인터페이스ID</div>
							<input class="common-input subtitle1 gray400 pk id-pattern" type="text" id="SVC_LNK_ID" name="svcLnkId" readonly="readonly">
							<div class="header6 label-title">인터페이스명</div>
							<input class="common-input subtitle1 gray400" type="text" id="SVC_LNK_NM" name="svcLnkNm">
							<div class="header6 label-title">스키마명</div>
							<input class="common-input subtitle1 gray400 tableSearch" type="text" id="SCH_NM" name="schNm" readonly="readonly">
							<div class="header6 label-title">테이블명</div>
							<input class="common-input subtitle1 gray400 tableSearch" type="text" id="TBL_NM" name="tblNm" readonly="readonly">
						</div>
					</div>
					<div>
						<!-- 크론탭 문법을 input에 직접 입력하는 UI, UI 확정 후 제거 필요 -->
						<div class="common-input-box">
							<div class="header6 label-title">
								스케줄 <span class="guide-icon"> <img src="${imgUrl}icon-guide-mark.png" alt=""> ️<span id="schGuideText" class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="쿼리가 실행되는 주기를 설정할 수 있습니다.<br><br> 각 자리수의 의미는<br><br> *     *    *   *    *    *     *<br> 초  분  시  일  월 요일 년도(생락가능)<br><br>요일은 일요일부터 1로 표기 토요일은 7"
											escapeXml="false" /></span>
								</span>
							</div>
							<input class="common-input subtitle1 gray400" type="text" id="LNK_TIME" name="lnk_time" placeholder="0/10 * * * * ? (매 10초마다 쿼리수행)">
						</div>
					</div>
				</div>
				<div class="link-table-box-top-right">
					<div class="flag-box">
						<div class="flag-title body1 gray500 bg-gray200 border-gray300">연계 데이터 감지 방법</div>
						<div class="flag-radio-box subtitle1 gray400">
							<input type="hidden" id="FLAG_TYPE" name="flagTypeTmp">
							<div>
								<label><input type="radio" name="flagType" value="S">상태값 기준 감지</label>
							</div>
							<div>
								<label><input type="radio" name="flagType" value="W">조건문 임의 작성</label>
							</div>
							<div>
								<label><input type="radio" name="flagType" value="Q">임의 조회문 작성</label>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="link-table-wrapper">
			<div class="query-box detail-flag-type-where">
				<div class="header6 label-title">조건문 작성</div>
				<input class="common-input subtitle1 gray400" id="flagTypeInputWhere" type="text" name="" placeholder="조건문을 입력하세요">
			</div>
			<div class="query-box detail-flag-type-query">
				<div class="query-box">
					<div class="header6 label-title">임의 조회문 작성</div>
					<input class="common-input subtitle1 gray400" id="flagTypeInputQuery" type="text" name="" placeholder="쿼리를 입력하세요">
				</div>
			</div>
		</div>
		<div class="link-table-wrapper">
			<div class="link-table-box-bottom">
				<table class="link-table-list">
					<colgroup>
						<col width="21%">
						<col>
						<col width="9%">
						<col width="9%">
						<col width="7%">
						<col width="5%">
						<col width="6%">
						<col width="5%">
					</colgroup>
					<thead class="list-head">
						<tr class="subtitle1 gray500">
							<th>컬럼명</th>
							<th>컬럼명 매핑&nbsp;&nbsp;<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="컬럼명을 변경하여 송신할 경우 명시" escapeXml="false" /></span></span></th>
							<th>컬럼 타입</th>
							<th class="ta-c">연계 컬럼 정보&nbsp;&nbsp;<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="● 일반 컬럼<br>&nbsp;&nbsp;&nbsp;&nbsp;연계 업무관련 컬럼이 아닌것을 의미함<br><br>● 명령 코드값<br>&nbsp;&nbsp;&nbsp;&nbsp;설정된 컬럼의 값 'I','U','D'에 따라 업무 수행<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I : Insert 메시지 생성요청<br>&nbsp;&nbsp;&nbsp;&nbsp;U : Update 메시지 생성요청<br>&nbsp;&nbsp;&nbsp;&nbsp;D : Delete 메시지 생성요청<br><br>● 연계 상태값<br>&nbsp;&nbsp;&nbsp;&nbsp;설정된 컬럼의 값이 'N'인 데이터 감지"
											escapeXml="false" /></span></span></th>
							<th class="ta-c">연계 여부</th>
							<th>정렬순서</th>
							<th>정렬방식</th>
							<th>삭제&nbsp;&nbsp;<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="삭제 되었거나 임의추가한 컬럼만 삭제 가능함" escapeXml="false" /></span></span></th>
						</tr>
						<tr class="table-spacing"></tr>
					</thead>
					<tbody class="list-body" id="gridTableDataBody">
						<tr class="detailTr">
							<td colspan="7">연계할 스키마와 테이블을 선택하세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<input type="hidden" id="FLAG_QUERY" name="flagQueryTmp">
		<div class="query-box">
			<h4 class="query-title body1 gray500">조회쿼리</h4>
			<div id="queryResult" class="query-text subtitle1 gray400 bg-gray200 border-gray300"></div>
		</div>
		<div class="link-button-box">
			<input id="previousBtn" class="button-second" type="button" value="이전"> <input id="deleteBtn" class="button-second-gray" type="button" value="삭제"> <input
				id="modifyBtn" class="button-primary" type="button" value="저장">
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
				<td class="col-name">#COL_NAME#&nbsp;</td>
				<td><input type="text" class="w90ps" name="colNmMp" value="#COL_NM_MP#" maxlength="60"></td>
				<td class="ta-l">#COL_TYPE#</td>
				<td class="ta-l"><select class="tdLinkSelect ta-c select-#COL_LNK_TYPE#" name="colLnkType" style="width: 10em;">
						<option value="D">일반 컬럼</option>
						<option value="O">명령 코드값</option>
						<option value="S">연계 상태값</option>
				</select></td>
				<td class="ta-c"><input class="tdIsConnect check-#COL_LNK_YN#" type="checkbox" name="colLnkYn" value="Y"></td>
				<td class="ta-r"><input name="colOrderNum" type="number" style="width: 4em;" min="1" max="99" maxlength="2" value="#COL_ORDER_NUM#"></td>
				<td class="ta-l"><select class="tdLinkSelect ta-c select-#COL_ORDER_TYPE#" name="colOrderType"><option value="N">NONE</option>
						<option value="A">ASC</option>
						<option value="D">DESC</option></select></td>
				<td class="ta-l"><a class="hide" href="javascript:delOneChild('#COL_NAME#');">🗑️</a></td>
		</tbody>
	</table>
	<table>
		<tbody id="gridNoDataHtmlFormatId">
			<tr class="detailTr">
				<td colspan="7">컬럼이 존재하지 않습니다.</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<table>
		<tbody id="gridLoadingHtmlFormatId">
			<tr class="detailTr">
				<td colspan="7">로딩중...</td>
			</tr>
			<tr class="table-spacing"></tr>
		</tbody>
	</table>
	<div id="commentsFormatId">
		<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100">#COMMENTS#</span></span>
	</div>
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
		'#COL_LNK_TYPE#' : 'COL_LNK_TYPE',
		'#COL_LNK_YN#' : 'COL_LNK_YN',
		'#COL_ORDER_NUM#' : 'COL_ORDER_NUM',
		'#COL_ORDER_TYPE#' : 'COL_ORDER_TYPE',
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
	grid.event.setPostEvent(function(result) {
		$('.check-Y').prop('checked', true);
		$('.select-D').val('D').prop('selected', true);
		$('.select-O').val('O').prop('selected', true);
		$('.select-S').val('S').prop('selected', true);
		// 컬럼정보까지 불러와졌으면 쿼리생성관련 이벤트 적용

		// 연계 여부 변동시 이벤트 등록
		$('form input[name="colLnkYn"]').change(fn_make_lnk_qry);
		$('form select[name="colLnkType"]').change(fn_make_lnk_qry);
		$('form input[name="colNmMp"]').keyup(fn_make_lnk_qry);

		// 삭제된 컬럼은 삭제할 수 있도록 버튼 활성화
		$('input[name="colCurrentType"][value="DEL"]').parents('tr').find('a')
				.removeClass('hide');
		$('input[name="colCurrentType"][value="DEL"]').parents('tr').addClass(
				'col-del');
		// 임의추가된 컬럼은 삭제할 수 있도록 버튼 활성화
		$('input[name="colCurrentType"][value="USR"]').parents('tr').find('a')
				.removeClass('hide');
		fn_make_lnk_qry();

		// 컬럼 설명이 존재하는 경우 컬럼 설명 추가하기
		var _commentsFormatId = $('#commentsFormatId').html();
		var _commentsTmp = '';
		var _colName = '';
		for (var i = 0; i < result.data.length; i++) {
			// row 데이터 가져오기
			var rowData = result.data[i];
			_commentsTmp = rowData['COMMENTS'] || '';
			if ('' == _commentsTmp) {
				continue;
			}
			_colName = rowData['COLUMN_NAME'] || '';
			$('#' + _colName + ' .col-name').append(
					_commentsFormatId.replaceAll('#COMMENTS#', _commentsTmp));
		}

		// 컬럼설명 >>>
		$(".child_row .guide-icon").on({
			mouseenter : function() {
				$(this).addClass('show')
			},
			mouseleave : function() {
				$(this).removeClass('show')
			}
		});
		// 컬럼설명 <<<
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

	// 저장된 '연계 데이터 감지 방법' 체크
	const fn_load_flag_type = function() {
		$('input[name="flagType"]').removeAttr('checked');
		$('input[name="flagType"][value="' + $('#FLAG_TYPE').val() + '"]')
				.attr('checked', true);
	};

	// '연계 데이터 감지 방법'에 따른 조건문이라 쿼리문 출력 기능
	const flagTypeMapping = {
		Q : 'flag-type-query',
		W : 'flag-type-where'
	};
	const detail_display_select = fn_detail_display_event('flagType',
			flagTypeMapping);
	// '연계 데이터 감지 방법'에 따른 조건문이나 쿼리문 이전 값 불러오기
	const fn_post_event_set_flag_query = function() {
		const flagType = $('form input[name="flagType"]:checked').val() || 'S';
		if ('S' == flagType) {
			return;
		}
		const flagQuery = $('#FLAG_QUERY').val();
		if ('W' == flagType) {
			$('#flagTypeInputWhere').val(flagQuery);
		} else { // Q
			$('#flagTypeInputQuery').val(flagQuery);
		}
	};
	const fn_child_grid = function() {
		// 파라미터 JSON포맷
		let paramData = {
			'svcLnkId' : $('#SVC_LNK_ID').val(),
			'dsNm' : $('#DS_NM').val(),
			'schemaName' : $('#SCH_NM').val(),
			'tableName' : $('#TBL_NM').val()
		//{svcLnkId=TEST001, dsNm=PPS@0.151, schemaName=, tableName=}
		};

		grid.search(1, paramData);
	};
	// 페이지 기본 정보 불러온 다음 해야할 업무 순서 정보 
	const postEvent = [ fn_data_source_load, fn_load_flag_type,
			detail_display_select.select, fn_post_event_set_flag_query,
			fn_child_grid ];

	$(document).ready(function() {
		// 검색 준비가 된 시점으로 최소 document 준비된 시점에 호출되어야 한다.
		grid.ready();
		const pageLoader = fn_modify_page_load('연계서비스', '테이블 정보', postEvent);
		pageLoader.setPreviouParam($('input[name="svcId"]').serialize());
		pageLoader.setChildTable('.child_row');

		// 가이드 >>>
		$(".guide-icon").on({
			mouseenter : function() {
				$(this).addClass('show')
			},
			mouseleave : function() {
				$(this).removeClass('show')
			}
		});
		// 가이드 <<<

	});

	// 연계 데이터 감지 방법 변동시 이벤트 등록
	$('input[name="flagType"]').change(fn_make_lnk_qry);
	//연계플래그 input 입력 시 조회쿼리 TEXT로 적용되는 함수
	$('#flagTypeInputQuery, #flagTypeInputWhere').on('input', fn_make_lnk_qry);

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
