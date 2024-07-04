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
<div class="mainContent"> <!-- 연계 수신 정보 등록 (KDI_LINK_SUB_INF)-->
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
							<th>연계 플래그 매핑</th>
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
						<tr class="subtitle1 gray500">
							<td><input type="hidden" value="#COL_NAME#">#COL_NAME#</td>	<!-- COLUMN_NAME -->
							<td><input type="hidden" value="#COL_TYPE#">#COL_TYPE#</td>	<!-- DATA_TYPE -->
							<td><input type="hidden" value="#COL_DEFAULT#">#COL_DEFAULT#</td> <!-- DATA_DEFAULT -->
							<td><input class="tdIsConnect" type="checkbox" name="connect_use_yn" id="use_yn_column_1" onclick="colUseCheck()"></td>
							<td><select class="tdLinkSelect">
									<option value="S">STATUS</option>
									<option value="O">OPCODE</option>
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