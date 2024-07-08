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
	<!-- 연계 수신 정보 등록 (KDI_LINK_SUB_INF)-->
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
						<col width="25%">
					</colgroup>
					<thead class="list-head">
						<tr class="subtitle1 gray500">
							<th>컬럼명</th>
							<th>컬럼명 매핑
								<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt="">
									<span class="guide-box bg-gray400 subtitle2 white100">
										<c:out value="컬럼명을 변경하여 송신할 경우 명시" escapeXml="false" />
									</span>
								</span>
							</th>
							<th>컬럼 타입</th>
							<th>연계 여부</th>
							<!-- th>연계 플래그 매핑</th -->
							<th>컬럼 설명
								<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt="">
									<span class="guide-box bg-gray400 subtitle2 white100">
										<c:out value="데이터베이스에 명시된 컬럼 Comment 출력" escapeXml="false" />
									</span>
								</span>
							</th>
						</tr>
						<tr class="table-spacing"></tr>
					</thead>
					<tbody class="list-body" id="gridTableDataBody">
						<tr class="detailTr">
							<td colspan="5">연계할 스키마와 테이블을 선택하세요.</td>
						</tr>
					</tbody>
				</table>
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
									</ul>
								</td>
								<td>#COL_NAME#</td>
								<td><input type="text" class="w90ps" name="colNmMp" value="" maxlength="60"></td>
								<td class="ta-l">#COL_TYPE#</td>
								<!-- td class="ta-l"><select class="tdLinkSelect ta-c" name="colLnkType">
										<option value="S">STATUS</option>
										<option value="O">OPCODE</option>
								</select></td -->
								<td class="ta-c"><input class="tdIsConnect" type="checkbox" name="colLnkYn" checked="checked" value="Y"></td>
								<td class="ta-l">#COMMENTS#</td>
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
			</div>
		</div>
		<!-- 
		<div class="query-box">
			<h4 class="query-title body1 gray500">조회쿼리</h4>
			<div id="queryResult" class="query-text subtitle1 gray400 bg-gray200 border-gray300"></div>
		</div>
		 -->
		<div class="link-button-box">
			<input id="previousBtn" class="button-second" type="button" value="이전"> <input id="regbtn" class="button-primary" type="button" value="저장">
		</div>
	</form>
</div>

<script>
	//KdiListGrid 시작 >>>>>
	const grid = KdiListGrid('grid', '/res/link/sub/tbl/columns.json');
	const gridEnv = grid.env;
	gridEnv.setMapping({
		'#COL_NAME#' : 'COLUMN_NAME',
		'#COL_TYPE#' : 'DATA_TYPE',
		'#COMMENTS#' : 'COMMENTS'
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

	var fn_tb_nm_click = function() {
		const ds_nm = $('#DS_NM').serialize();
		const parentId = encodeURIComponent('form');
		const param = ds_nm + '&parentId=' + parentId;
		const tablePopUri = contextPath + 'pop/table?' + param;

		let popOption = 'toolbar=no,menubar=no,location=no,status=no';
		popOption += ',scrollbars=yes,resizeable=yes';
		popOption += ',width=900,height=800';
		window.open(tablePopUri, '_blank', popOption);
	}

	$(document).ready(function() {
		const insertPageLoader = fn_insert_page_load('연계 수신서비스', '수신 테이블 정보');
		insertPageLoader.setPreviouParam($('input[name="svcId"]').serialize());
		insertPageLoader.setChildTable('.child_row');

		// 데이터 소스 정보 불러오기
		var svcId = $('#SVC_ID').val();
		const svcInfoData = KdiData().getSvcInfo(svcId);
		$('#DS_NM').val(svcInfoData.DS_NM);

		// 스키마명 테이블명 검색 팝업 이벤트 등록
		$('form input.tableSearch').click(fn_tb_nm_click);

		// 검색 준비가 된 시점으로 최소 document 준비된 시점에 호출되어야 한다.
		grid.ready();

		//연계플래그 input 입력 시 조회쿼리 TEXT로 적용되는 함수
		/**
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
		 **/
	});

	function colUseCheck() {
		const use_yn = $("#use_yn").val;
	}

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

	// 연계플래그 타입 선택에 따른 onChange Event
	/**	
	$('input[name="flag_type"]').on(
	 'change',
	 function() {
	 let currentType = $(this).val();
	 const queryType = '#flagTypeBoxQuery';
	 const whereType = '#flagTypeBoxWhere';

	 $(queryType).css('display',
	 currentType === 'QUERY' ? 'block' : 'none');
	 $(whereType).css('display',
	 currentType === 'WHERE' ? 'block' : 'none');

	 $('#flagTypeInputQuery, #flagTypeInputWhere').val('');
	 $('#queryResult').text('')

	 if (currentType === 'QUERY') {
	 $('.tdIsConnect, .tdLinkSelect').css('display', 'none');
	 } else if (currentType === 'WHERE') {
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
	$('#flagTypeInputWhere').on(
			'input',
			function() {
				var selectColumn = '';

				$('input[name="connect_use_yn"]:checked').each(function() {
					var inputId = $(this).attr('id');
					var columnName = $('#' + inputId.substring(7)).text()

					selectColumn += columnName;
				});

				if (selectColumn === '') {
					selectColumn = '*';
				}
				$('#queryResult').text(
						'SELECT ' + selectColumn + ' WHERE ' + $(this).val());
			}); */
</script>
