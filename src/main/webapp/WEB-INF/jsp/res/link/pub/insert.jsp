<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="imgUrl" value="/img/" />
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<c:url var="pageUrl" value="/res/link/pub/" />
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
								스케줄 <span class="guide-icon"> <img src="${imgUrl}icon-guide-mark.png" alt=""> ️<span id="schGuideText" class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="쿼리가 실행되는 주기를 설정할 수 있습니다.<br><br> 각 자리수의 의미는<br><br> *     *    *   *    *    *     *<br> 초  분  시  일  월 요일 년도(생락가능)<br><br>요일은 일요일부터 1로 표기 토요일은 7"
											escapeXml="false" /></span>
								</span>
							</div>
							<input class="common-input subtitle1 gray400" type="text" name="lnkTime" placeholder="0/10 * * * * ? (매 십초마다 실행)">
						</div>
					</div>
				</div>
				<div class="link-table-box-top-right">
					<div class="flag-box">
						<div class="flag-title body1 gray500 bg-gray200 border-gray300">연계 데이터 감지 방법</div>
						<div class="flag-radio-box subtitle1 gray400">
							<div>
								<label><input type="radio" name="flagType" value="S" checked="checked">상태값 기준 감지</label>
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
				<input class="common-input subtitle1 gray400" id="flagTypeInputWhere" type="text" name="flagQuery" placeholder="조건문을 입력하세요">
			</div>
			<div class="query-box detail-flag-type-query">
				<div class="query-box">
					<div class="header6 label-title">임의 조회문 작성</div>
					<input class="common-input subtitle1 gray400" id="flagTypeInputQuery" type="text" placeholder="쿼리를 입력하세요">
				</div>
			</div>
		</div>
		<div class="link-table-wrapper">
			<div class="link-table-box-bottom">
				<table class="link-table-list">
					<colgroup>
						<col width="22%">
						<col width="22%">
						<col width="9%">
						<col width="9%">
						<col width="8%">
						<col>
					</colgroup>
					<thead class="list-head">
						<tr class="subtitle1 gray500">
							<th>컬럼명</th>
							<th>컬럼명 매핑<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="컬럼명을 변경하여 송신할 경우 명시" escapeXml="false" /></span></span></th>
							<th>컬럼 타입</th>
							<th class="ta-c">연계 컬럼 정보<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="● 일반 컬럼<br>&nbsp;&nbsp;&nbsp;&nbsp;연계 업무관련 컬럼이 아닌것을 의미함<br><br>● 명령 코드값<br>&nbsp;&nbsp;&nbsp;&nbsp;설정된 컬럼의 값 'I','U','D'에 따라 업무 수행<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I : Insert 메시지 생성요청<br>&nbsp;&nbsp;&nbsp;&nbsp;U : Update 메시지 생성요청<br>&nbsp;&nbsp;&nbsp;&nbsp;D : Delete 메시지 생성요청<br><br>● 연계 상태값<br>&nbsp;&nbsp;&nbsp;&nbsp;설정된 컬럼의 값이 'N'인 데이터 감지"
											escapeXml="false" /></span></span></th>
							<th class="ta-c">연계 여부</th>
							<th>컬럼 설명<span class="guide-icon"><img src="${imgUrl}icon-guide-mark.png" alt=""><span class="guide-box bg-gray400 subtitle2 white100"><c:out
											value="데이터베이스에 명시된 컬럼 Comment 출력" escapeXml="false" /></span></span></th>
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
			<h4 class="query-title body1 gray500">조회쿼리 예시</h4>
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
				<td class="ta-l"><select class="tdLinkSelect ta-c" name="colLnkType">
						<option value="D">일반 컬럼</option>
						<option value="O">명령 코드값</option>
						<option value="S">연계 상태값</option>
				</select></td>
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
<script>
	//KdiListGrid 시작 >>>>>
	const grid = KdiListGrid('grid', '${pageUrl}tbl/columns.json');
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
	grid.event.setPostEvent(function() {
		// 연계 여부 변동시 이벤트 등록
		$('form input[name="colLnkYn"]').change(function() {
			if (this.checked) {
				$(this).attr('value', 'Y');
			} else {
				$(this).attr('value', 'N');
			}
			fn_make_lnk_qry();
		});
		$('form select[name="colLnkType"]').change(fn_make_lnk_qry);
		$('form input[name="colNmMp"]').keyup(fn_make_lnk_qry);

		fn_make_lnk_qry();
	});
	// KdiListGrid 끝 <<<<<

	// 조회쿼리를 생성하는 기능
	const fn_make_lnk_qry = function() {
		let qry = '';
		$('form select[name="colLnkType"],form input[name="colLnkYn"]')
				.removeClass('hide');
		switch ($('input[name="flagType"]:checked').val()) {
		default:
		case 'S': // 상태값 기준 감지
			var cols = fn_get_col_data();
			cols.oper = cols.oper || '';
			cols.state = cols.state || '';
			if ('' == cols.oper) {
				cols.oper = '<span class="c-red fw-bold">\'명령 코드값 지정필요\'</span>';
			}
			if ('' == cols.state) {
				cols.state = [ '<span class="c-red fw-bold">\'연계 상태값 지정필요\'</span>' ];
			}
			qry = 'SELECT<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.oper
					+ ',<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.nm
					+ '<br>FROM<br>&nbsp;&nbsp;&nbsp;&nbsp;'
					+ $('input[name="schNm"]').val() + "."
					+ $('input[name="tblNm"]').val()
					+ '<br>WHERE<br>&nbsp;&nbsp;&nbsp;&nbsp;';
			var whereQry = '';
			$.each(cols.state, function() {
				if ('' != whereQry) {
					whereQry += ' AND '
				}
				whereQry += this;
				whereQry += ' = \'N\'';
			});
			qry += whereQry;
			break;
		case 'W': // 조건문 임의 작성
			var cols = fn_get_col_data();
			cols.oper = cols.oper || '';
			cols.state = cols.state || '';
			if ('' == cols.oper) {
				cols.oper = '<span class="c-red fw-bold">\'명령 코드값 지정필요\'</span>';
			}
			if ('' == cols.state) {
				cols.state = '<span class="c-red ">\'연계 상태값 지정필요\'</span>';
			}
			$('#flagTypeInputQuery').removeAttr('name');
			$('#flagTypeInputWhere').attr('name', 'flagQuery');
			qry = 'SELECT<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.oper
					+ ',<br>&nbsp;&nbsp;&nbsp;&nbsp;' + cols.nm
					+ '<br>FROM<br>&nbsp;&nbsp;&nbsp;&nbsp;'
					+ $('input[name="schNm"]').val() + "."
					+ $('input[name="tblNm"]').val()
					+ '<br>WHERE<br>&nbsp;&nbsp;&nbsp;&nbsp;'
					+ $('#flagTypeInputWhere').val();
			break;
		case 'Q': // 임의 조회문 작성
			$('#flagTypeInputWhere').removeAttr('name');
			$('#flagTypeInputQuery').attr('name', 'flagQuery');
			qry = $('#flagTypeInputQuery').val();
			$('form select[name="colLnkType"],form input[name="colLnkYn"]')
					.addClass('hide');
			console.log(qry);
			break;
		}
		$('#queryResult').html(qry);
	}

	// 연계 여부가 체크된 컬럼명을 반환하는 기능
	const fn_get_col_data = function() {
		// return value
		let cols_nm = [];
		let state_yn = [];
		let oper_cd = [];

		// tmp value
		let col_nm;
		let colLnkType;
		let colLnkYn;
		let colNmMp;
		$.each($('form tbody tr'), function() {
			col_nm = $(this).find('input[name="colName"]').val();
			colLnkType = $(this).find('select[name="colLnkType"]').val();
			colLnkYn = $(this).find('input[name="colLnkYn"]').val();
			colNmMp = $(this).find('input[name="colNmMp"]').val() || '';

			if ('Y' == colLnkYn) {
				if ('' == colNmMp) {
					cols_nm.push(col_nm);
				} else {
					cols_nm.push(col_nm + ' AS ' + colNmMp);
				}
			}
			if ('S' == colLnkType) {
				state_yn.push(col_nm);
			}
			if ('O' == colLnkType) {
				oper_cd.push(col_nm + ' AS LNK_OPER_CD');
			}
		});
		return {
			nm : cols_nm,
			state : state_yn,
			oper : oper_cd
		};
	}

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
		$(".guide-icon").on({
			mouseenter : function() {
				$(this).addClass('show')
			},
			mouseleave : function() {
				$(this).removeClass('show')
			}
		});
		// 크론탭 가이드 <<<

		// 검색 준비가 된 시점으로 최소 document 준비된 시점에 호출되어야 한다.
		grid.ready();
	});

	// 연계 데이터 감지 방법 변동시 이벤트 등록
	$('input[name="flagType"]').change(fn_make_lnk_qry);
	//연계플래그 input 입력 시 조회쿼리 TEXT로 적용되는 함수
	$('#flagTypeInputQuery, #flagTypeInputWhere').on('input', fn_make_lnk_qry);

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
