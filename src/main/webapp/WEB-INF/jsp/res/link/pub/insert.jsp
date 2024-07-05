<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}link.css">
<script src="${jsUrl}kdi/kdi-main-data.js"></script>
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<style>
div[class*='detail-'] {
	display: none;
}
</style>
<div class="mainContent">
	<!-- 연계 송신 정보 등록 (KDI_LINK_PUB_INF)-->
	<form id="insert">
		<input type="hidden" id="SVC_ID" name="svcId" value="${svcId}"> <input type="hidden" id="DS_NM" name="dsNm">
		<div class="link-table-wrapper">
			<div class="link-table-box-top">
				<div class="link-table-box-top-left">
					<div class="link-inputs-row">
						<div class="common-input-box">
							<div class="header6 label-title">인터페이스ID</div>
							<input class="common-input subtitle1 gray400 pk id-pattern" type="text" id="SVC_LNK_ID" name="svcLnkId">
							<div class="header6 label-title">인터페이스명</div>
							<input class="common-input subtitle1 gray400" type="text" id="SVC_LNK_NM" name="svcLnkNm" placeholder="인터페이스명">
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
								스케줄 <span class="guide-icon"> <img src="${imgUrl}icon-guide-mark.png" alt=""> ️<span id="guideText" class="guide-box bg-gray400 subtitle2 white100"></span>
								</span>
							</div>
							<input class="common-input subtitle1 gray400" type="text" name="lnkTime" placeholder="0/10 * * * * ? (매 십초마다 실행)">
						</div>
						<!-- 							<div class="schedule-input-box">
								<div class="header6 label-title">
									스케줄 <span class="guide-icon"> <img src="${imgUrl}icon-guide-mark.png" alt=""> ️<span id="guideText" class="guide-box bg-gray400 subtitle2 white100"></span>
									</span>
								</div>
								<div class="schedule-inputs">
									<input class="schedule-input subtitle1 gray400" type="number" max="59" min="0" maxlength="2" name="lnk_time" placeholder="분" value="0"> <span
										class="subtitle1 gray500">분</span> <input class="schedule-input subtitle1 gray400" type="number" max="23" min="0" maxlength="2" name="lnk_time" placeholder="시간" value="0">
									<span class="subtitle1 gray500">시간</span> <input class="schedule-input subtitle1 gray400" type="number" max="31" min="0" maxlength="2" name="lnk_time" placeholder="일"
										value="0"> <span class="subtitle1 gray500">일</span> <input class="schedule-input subtitle1 gray400" type="number" max="12" min="0" maxlength="2" name="lnk_time"
										placeholder="월" value="0"> <span class="subtitle1 gray500">월</span> <input class="schedule-input subtitle1 gray400" type="number" max="6" min="0" maxlength="1"
										name="lnk_time" placeholder="요일" value="0"> <span class="subtitle1 gray500">요일</span>
								</div>
							</div> -->
					</div>
				</div>
				<div class="link-table-box-top-right">
					<div class="flag-box">
						<div class="flag-title body1 gray500 bg-gray200 border-gray300">연계 데이터 추출 방법</div>
						<div class="flag-radio-box subtitle1 gray400">
							<div>
								<label><input type="radio" name="flagType" value="S" checked="checked">상태값 기준 추출</label>
							</div>
							<div>
								<label><input type="radio" name="flagType" value="W">조회문 임의 작성</label>
							</div>
							<div>
								<label><input type="radio" name="flagType" value="Q">사용자 임의 작성</label>
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
						<col width="45%">
						<col width="15%">
						<col width="10%">
						<col width="10%">
						<col width="20%">
					</colgroup>
					<thead class="list-head">
						<tr class="subtitle1 gray500">
							<th>컬럼명</th>
							<th>컬럼타입</th>
							<th>DEFUALT</th>
							<th>연계여부</th>
							<th>연계 컬럼 유형</th>
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
		<div class="query-box">
			<h4 class="query-title body1 gray500">조회쿼리</h4>
			<div id="queryResult" class="query-text subtitle1 gray400 bg-gray200 border-gray300"></div>
		</div>
		<div class="link-button-box">
			<input id="previousBtn" class="button-second" type="button" value="이전"> <input id="regbtn" class="button-primary" type="button" value="저장">
		</div>
	</form>
</div>
<div style="display: none;">
	<table>
		<tbody id="gridHtmlFormatId">
			<tr class="subtitle1 gray500 child_row">
				<td style="display: none;">
					<!-- input 항목을 한눈에 보기위해서 만들어진 숨겨진 td임 큰의미는 없음 -->
					<ul>
						<!-- 코드 정렬시 줄바꿈 방지 목적 ul li는 큰의미는 없음 -->
						<li><input type="hidden" name="colName" value="#COL_NAME#"></li>
						<li><input type="hidden" name="colType" value="#COL_TYPE#"></li>
						<li><input type="hidden" name="colDefault" value="#COL_DEFAULT#"></li>
						<li><input type="hidden" name="colNmMp" value="#COL_NM_MP#"></li>
					</ul>
				</td>
				<td>#COL_NAME#</td>
				<td>#COL_TYPE#</td>
				<td>#COL_DEFAULT#</td>
				<td><input class="tdIsConnect" type="checkbox" name="connectUseYn" onclick="colUseCheck()"></td>
				<td><select class="tdLinkSelect" name="colLnkType">
						<option value="D">데이터</option>
						<option value="S">연계상태(S,)</option>
						<option value="O">연계유형(I,U,D)</option>
				</select></td>
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
	const grid = KdiListGrid('grid', '/res/link/pub/tbl/columns.json');
	const gridEnv = grid.env;
	gridEnv.setMapping({
		'#COL_NAME#' : 'COLUMN_NAME',
		'#COL_TYPE#' : 'DATA_TYPE',
		'#COL_DEFAULT#' : 'DATA_DEFAULT'
	});
	// 데이터 Load과정에서 에러 발생시 이벤트 정의 예제 ( 안쓰려면 호출안하면 됨)
	var errEvent = function(xhr) {
		/* console.log('statusCode:' + xhr.statusCode);
		console.log('responseJSON:' + xhr.responseJSON.state);
		console.log('responseJSON:' + xhr.responseJSON.errMsg); */
		alert(xhr.responseJSON.errMsg);
	}
	grid.event.setErrEvent(errEvent);

	gridEnv.loading.enable();
	gridEnv.nodata.enable();
	// KdiListGrid 끝 <<<<<

	const fn_tb_nm_click = function() {
		const ds_nm = $('#DS_NM').serialize();
		const parentId = encodeURIComponent('form');
		const param = ds_nm + '&parentId=' + parentId;
		const tablePopUri = contextPath + 'pop/table?' + param;

		let popOption = 'toolbar=no,menubar=no,location=no,status=no';
		popOption += ',scrollbars=yes,resizeable=yes';
		popOption += ',width=900,height=800';
		window.open(tablePopUri, '_blank', popOption);
	};

	let crontab_guid_text = '쿼리가 실행되는 주기를 설정할 수 있습니다.\n\n';
	crontab_guid_text += ' 각 자리수의 의미는\n\n';
	crontab_guid_text += ' *     *    *   *    *    *     *\n';
	crontab_guid_text += ' 초  분  시  일  월 요일 년도(생락가능)\n\n';
	crontab_guid_text += '요일은 일요일부터 1로 표기 토요일은 7';

	const fn_crontab_guid_show = function() {
		$('.guide-box').css('display', 'block');
	};
	const fn_crontab_guid_hide = function() {
		$('.guide-box').css('display', 'none');
	};

	const flagTypeMapping = {
		Q : 'flag-type-query',
		W : 'flag-type-where'
	};

	$(document).ready(function() {
		const pageLoader = fn_insert_page_load('연계 송신서비스', '송신 테이블 정보');
		pageLoader.setPreviouParam($('input[name="svcId"]').serialize());
		pageLoader.setChildTable('.child_row');
		fn_detail_display_event('flagType', flagTypeMapping);

		// 데이터 소스 정보 불러오기
		var svcId = $('#SVC_ID').val();
		const svcInfoData = KdiData().getSvcInfo(svcId);
		$('#DS_NM').val(svcInfoData.DS_NM);

		// 스키마명 테이블명 검색 팝업 이벤트 등록
		$('form input.tableSearch').click(fn_tb_nm_click);

		// 크론탭 가이드 >>>
		$('.guide-box').text(crontab_guid_text);
		$(".guide-icon").on({
			mouseenter : fn_crontab_guid_show,
			mouseleave : fn_crontab_guid_hide
		});
		// 크론탭 가이드 <<<

		// 검색 준비가 된 시점으로 최소 document 준비된 시점에 호출되어야 한다.
		grid.ready();
	});

	function colUseCheck() {
		const use_yn = $("#use_yn").val;
		console.log("@@@@@@@@@@@@" + use_yn);
	}

	// 연계플래그 타입 선택에 따른 onChange Event
	$('input[name="flagType"]').change(
			function() {
				let currentType = $(this).val();
				//const queryType = '#flagTypeBoxQuery';
				//const whereType = '#flagTypeBoxWhere';

				/* $(queryType).css('display',
						currentType === 'Q' ? 'block' : 'none');
				$(whereType).css('display',
						currentType === 'W' ? 'block' : 'none'); */

				$('#flagTypeInputQuery, #flagTypeInputWhere').val('');
				$('#queryResult').text('');
console.log('###########'+currentType);
				if (currentType === 'Q') {
					$('.tdIsConnect, .tdLinkSelect').css('display', 'none');
				} else if (currentType === 'W') {
					$('.tdLinkSelect').css('display', 'none');
					$('.tdIsConnect').css('display', 'inline-block');
					$('#queryResult').text('SELECT * WHERE ');
				} else {
					$('.tdIsConnect, .tdLinkSelect').css('display',
							'inline-block');
				}
			});
	//연계플래그 input 입력 시 조회쿼리 TEXT로 적용되는 함수
	$('#flagTypeInputQuery').on('input', function() {
		$('#queryResult').text($(this).val());
	});
	$('#flagTypeInputWhere').on('input', function() {
		var selectColumn = '';

		$('input[name="connect_use_yn"]:checked').each(function() {
			var inputId = $(this).attr('id');
			var columnName = $('#' + inputId.substring(7)).text()

			selectColumn += columnName;
		});

		if (selectColumn === '') {
			selectColumn = '*';
		}
		const query = 'SELECT ' + selectColumn + ' WHERE ' + $(this).val();
		$('#queryResult').text(query);
	});

	// 선택한 스키마,테이블 내 전 컬럼 로드
	var fn_load_columns = function() {

		// 파라미터 JSON포맷
		let paramData = {
			'dsNm' : $('#DS_NM').val(),
			'schemaName' : $('#SCH_NM').val(),
			'tableName' : $('#TBL_NM').val()
		};

		grid.search(1, paramData);
	}
</script>
