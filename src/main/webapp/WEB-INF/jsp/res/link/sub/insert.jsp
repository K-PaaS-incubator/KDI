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
							<div class="header6 label-title">스키마명</div>
							<input class="common-input subtitle1 gray400 tableSearch" type="text" id="SCH_NM" name="schNm" readonly="readonly">
							<div class="header6 label-title">테이블명</div>
							<input class="common-input subtitle1 gray400 tableSearch" type="text" id="TBL_NM" name="tblNm" readonly="readonly">
						</div>
					</div>
				</div>
				<div class="link-table-box-top-right">
					<div class="flag-box">
						<div class="flag-title body1 gray500 bg-gray200 border-gray300">연계플래그 타입</div>
						<div class="flag-radio-box subtitle1 gray400">
							<div>
								<label><input type="radio" name="flagType" value="S" checked="checked">STATUS</label>
							</div>
							<div>
								<label><input type="radio" name="flagType" value="Q">QUERY</label>
							</div>
							<div>
								<label><input type="radio" name="flagType" value="W">WHERE</label>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="common-input-box detail-flag-type-where" id="flagTypeBoxWhere">
				<div class="header6 label-title">WHERE</div>
				<input class="common-input subtitle1 gray400" id="flagTypeInputWhere" type="text" name="" placeholder="조건문을 입력하세요">
			</div>
			<div class="common-input-box detail-flag-type-query" id="flagTypeBoxQuery">
				<div class="header6 label-title">조회쿼리</div>
				<input class="common-input subtitle1 gray400" id="flagTypeInputQuery" type="text" name="" placeholder="쿼리를 입력하세요">
			</div>
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
					<tbody class="list-body">
						<tr class="subtitle1 gray500">
							<td id="column_1">COLUMN1</td>
							<td>VARCHAR2(100)</td>
							<td>timestamp();</td>
							<td><input class="tdIsConnect" type="checkbox" name="connect_use_yn" id="use_yn_column_1" onclick="colUseCheck()"></td>
							<td><select class="tdLinkSelect">
									<option value="1">STATUS</option>
									<option value="2">QUERY</option>
									<option value="3">WHERE</option>
							</select></td>
						</tr>
						<tr class="table-spacing"></tr>
						<tr class="subtitle1 gray500">
							<td class="column_2">COLUMN2</td>
							<td>VARCHAR2(100)</td>
							<td>timestamp();</td>
							<td><input class="tdIsConnect" type="checkbox" name="connect_use_yn" id="use_yn_column_2" onclick="colUseCheck()"></td>
							<td><select class="tdLinkSelect">
									<option value="1">STATUS</option>
									<option value="2">QUERY</option>
									<option value="3">WHERE</option>
							</select></td>
						</tr>
						<tr class="table-spacing"></tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="query-box">
			<h4 class="query-title body1 gray500">조회쿼리</h4>
			<div id="queryResult" class="query-text subtitle1 gray400 bg-gray200 border-gray300"></div>
		</div>
		<div class="link-button-box">
			<input id="previousBtn" class="button-second" type="button" value="이전"> <input id="saveBtn" class="button-primary" type="button" value="저장">
		</div>
	</form>
</div>

<script>
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
	
	const flagTypeMapping = {
		Q : 'flag-type-query',
		W : 'flag-type-where'
	};
	$(document).ready(function() {
		const insertPageLoader = fn_insert_page_load('연계서비스', '테이블 정보');
		insertPageLoader.setPreviouParam($('input[name="svcId"]').serialize());
		fn_detail_display_event('flagType', flagTypeMapping);

		// 데이터 소스 정보 불러오기
		var svcId = $('#SVC_ID').val();
		const svcInfoData = KdiData().getSvcInfo(svcId);
		$('#DS_NM').val(svcInfoData.DS_NM);

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
	});

	function colUseCheck() {
		const use_yn = $("#use_yn").val;
	}

	// 연계플래그 타입 선택에 따른 onChange Event
	/**	$('input[name="flag_type"]').on(
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
