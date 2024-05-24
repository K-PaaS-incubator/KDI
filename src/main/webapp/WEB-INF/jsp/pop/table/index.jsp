<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />

<c:url var="cssUrl" value="/css/" />
<c:url var="defaultCssUrl" value="/css/default/" />

<c:url var="jsUrl" value="/js/" />
<c:url var="jqueryUrl" value="/js/jquery/" />

<c:url var="imgUrl" value="/img/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<title>테이블선택</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="${defaultCssUrl}basic.css">
<link rel="stylesheet" href="${defaultCssUrl}common.css">
<link rel="stylesheet" href="${cssUrl}link.css">
<script src="${jqueryUrl}jquery-3.7.1.min.js"></script>
<script src="${jqueryUrl}jquery.validate.min.js"></script>
<script src="${jqueryUrl}additional-methods.min.js"></script>
<script src="${jqueryUrl}messages_ko.min.js"></script>
<script src="${jsUrl}kdi/kdi-grid.js"></script>

<style type="text/css">
.selectSch {
	background-color: rgba(51, 106, 234, 0.10);
}
</style>
</head>
<body>
	<%-- window.open('http://localhost:8080/pop/table?ds_nm=데이터소스명&parent_id=부모창명','_blank', 'toolbar=no,menubar=no,location=no,status=no,scrollbars=yes,resizeable=yes,width=900,height=800'); --%>
	<div class="mainContent" style="margin: 15px;">
		<form>
			<div class="content-wrapper">
				<div class="left-content">
					<div class="left-content-title header4 gray500" id="ds_nm" title="데이터소스명"></div>
					<div class="left-content-box">
						<div class="left-title header5 white100">스키마 선택</div>
						<ul id="schemaNames" class="left-content-list-box">
							<li class="body2 gray400 selectSch schemaLoading"><input type="hidden" name="schemaName" value="#">로딩중</li>
						</ul>
					</div>
				</div>
				<div class="right-content">
					<div class="right-content-top">
						<div class="header6 gray400" id="schemaTitle"></div>
						<div class="search-box">
							<div>
								<input type="text" placeholder="검색"> <img src="${imgUrl}icon-search.png" alt="">
							</div>
							<button id="searchBtn" class="button-second">확인</button>
						</div>
					</div>
					<table id="detailTbl" class="schema-list">
						<colgroup>
							<col width="10%">
							<col width="50%">
							<col width="40%">
						</colgroup>
						<thead class="list-head">
							<tr>
								<th>No</th>
								<th>테이블명</th>
								<th>Comment</th>
							</tr>
							<tr class="table-spacing"></tr>
						</thead>
						<tbody id="gridTableDataBody" class="list-body">
							<tr class="detailTr">
								<td colspan="4">스키마를 선택해 주세요</td>
							</tr>
							<tr class="table-spacing"></tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 일단 임시로 이 영역에 구현함 -->
			<div class="link-button-box">
				<div class="body2">
					<span>전체 :</span> <span class="totalCnt">1</span>건
				</div>
				<!-- 이 영역에 구현된 페이지 번호영역은 static/html/kdi/pagination-num.html에 구현함 -->
				<div class="body2 pagination-ul pageCtlZone"></div>
				<div class="body2 gray500">
					<span class="currentPageNum">1</span> / <span class="totalPage">1</span> 페이지
				</div>
			</div>
		</form>
	</div>
	<div style="display: none;">
		<ul id="schemaNameListHtmlFormat">
			<li class="body2 gray400 schemaName <%-- 선택된 항목은 "selectEl" class 추가--%>"><input type="hidden" name="schemaName" value="#SCHEMA_NAME#">#SCHEMA_NAME#</li>
		</ul>
		<table>
			<tbody id="gridHtmlFormatId">
				<tr class="detailTr" onclick="fn_select_table(this);">
					<td>#NO#</td>
					<td><input type="hidden" name="tableName" value="#TABLE_NAME#">#TABLE_NAME#</td>
					<td>#COMMENT#</td>
				</tr>
				<tr class="table-spacing"></tr>
			</tbody>
		</table>
		<table>
			<tbody id="gridNoDataHtmlFormatId">
				<tr class="detailTr">
					<td colspan="4">테이블이 존재하지 않습니다.</td>
				</tr>
				<tr class="table-spacing"></tr>
			</tbody>
		</table>
		<table>
			<tbody id="gridLoadingHtmlFormatId">
				<tr class="detailTr">
					<td colspan="4">로딩중...</td>
				</tr>
				<tr class="table-spacing"></tr>
			</tbody>
		</table>
	</div>
	<script type="text/javascript">
		const ds_nm = new URL(location.href).searchParams.get('ds_nm');
		const parent_id = new URL(location.href).searchParams.get('parent_id');
		let selectSchema = "";
		
		let schemaNameLoadingHtmlFormat = "";
		let schemaNameListHtmlFormat = "";
		
		// KdiListGrid 시작 >>>>>
		// 선언한 변수명, 주소
		const grid = KdiListGrid('grid', '${homeUrl}pop/table/tables.json');

		// 그리드 세부조작시 사용하는 환경설정
		const gridEnv = grid.env;
		// kdiListGrid 생성과정에서 url 정보를 입력안하거나 변경시 사용
		// gridEnv.setUrl('호출할URL주소');

		// 입력한 JSON 데이터는 {'치환할 태그명':'조회된값의Key명'} 구조로 입력
		// html포맷과 데이터를 매핑하는 작업으로 JSON포맷으로 입력
		gridEnv.setMapping({
			'#TABLE_NAME#' : 'TB_NM',
			'#COMMENT#' : 'TB_COMMENTS'
		});
		
		// 페이지당 출력건수 변경기능 (기본값:10)
		// gridEnv.setPagePerRow(10);

		// 검색결과를 출력할때 사용할 html포맷
		// gridEnv.setGridHtmlFormatId('#gridHtmlFormatId');

		// 검색결과를 Html포맷을 기준으로 작성할 위치 (기본값 : #gridTableDataBody)
		// gridEnv.setTableDataBodyId('#gridTableDataBody');

		// 로딩 기능을 사용할때 로딩과정에 보여줄 html포맷 (기본값:#gridLoadingHtmlFormatId)
		// 이 함수를 호출하면 자동으로 gridEnv.loading.enable();가 호출된다.
		// gridEnv.loading.setGridLoadingHtmlFormatId('#gridLoadingHtmlFormatId');

		// 로딩기능 이용시 호출한다. 다시 비활성화하기 위해서는 gridEnv.loading.enable();을 호출하면 된다.
		gridEnv.loading.enable();

		// 데이터가 없는경우 출력할 내용을 설정한다.
		//gridEnv.setGridNoDataHtmlFormatId('#gridNoDataHtmlFormatId');
		gridEnv.nodata.enable();

		// 순번 사용시 순번이 들어가는 곳의 명칭을 입력한다.
		gridEnv.seq.enable('#NO#');

		// 전체건수 정의 (미사용시 정의 불필요, 정의 후 다시 비활성화하고싶으면 공백입력)
		gridEnv.setTotalCntId('.totalCnt');

		// 페이지번호 설정
		// 파라미터 : 현재페이지ID, 전체페이지ID
		// 미사용시 정의 불필요, 정의 후 다시 비활성화하고싶으면 공백입력
		gridEnv.setPageNumInfo('.currentPageNum', '.totalPage');

		// 페이지제어 설정
		// 페이지 번호 영역, 현재 페이지표기 class명, 비활성화표기 class명, 디자인html파일경로 및 추출영역
		// 페이지 번호 영역 호출 및 적용기능
		gridEnv.setPageCtlInfo('.pageCtlZone', '${homeUrl}');

		// 파라미터 JSON포맷
		let paramData = {
			'ds_nm' : ds_nm,
			'sch_nm' : ''
		};
		
		// 데이터 Load과정에서 에러 발생시 이벤트 정의 예제
		var errEvent = function(xhr) {
			/* console.log('statusCode:' + xhr.statusCode);
			console.log('responseJSON:' + xhr.responseJSON.state);
			console.log('responseJSON:' + xhr.responseJSON.errMsg); */
			alert(xhr.responseJSON.errMsg);
		}
		// 안쓰려면 호출안하면 됨
		grid.event.setErrEvent(errEvent);

		// 페이지당 출력건수를 변경하려면 아래 함수 호출
		//gridEnv.setPagePerRow(10);
		
		var fn_select_table = function(el) {
			const tableName = $(el).find('input[name="tableName"]').val();
			$(parent_id +' input[name="schemaName"]', opener.document).val(selectSchema);
			$(parent_id +' input[name="tableName"]', opener.document).val(tableName);
			self.close();
		}
		
		// KdiListGrid 끝 <<<<<
		
		var fn_load_tables = function() {
			$('#schemaNames li').removeClass('selectSch');
			$(this).addClass('selectSch');
			selectSchema = $(this).children('input[name="schemaName"]').val()
			paramData['sch_nm'] = selectSchema;
			grid.search(1, paramData);
		}
		
		var fn_load_schema = function() {
			$.ajax({
				url : '${homeUrl}pop/table/schemas.json',
				type : 'GET',
				data : {
					'ds_nm' : ds_nm,
				},
				dataType : 'json',
				beforeSend: function() {
					$('#schemaNames').html(schemaNameLoadingHtmlFormat);
				},
				success : function(result) {
					if (result.stateCode != 0) {
						alert(result.state)
						return;
					}
					let htmlTemp = '';
					for (var schemaName of result.data) {
						htmlTemp += schemaNameListHtmlFormat.replaceAll('#SCHEMA_NAME#',schemaName);
					}
					$('#schemaNames').html(htmlTemp);
					$('#schemaNames .schemaName').click(fn_load_tables);
				},
				error : function(result) {
					alert(result.responseJSON.state);
				}
			});
		}
		$().ready(function() {
			$('#ds_nm').text(ds_nm);
			schemaNameLoadingHtmlFormat = $('li.schemaLoading').parent().html();
			schemaNameListHtmlFormat = $('#schemaNameListHtmlFormat').html();
			fn_load_schema();
			
			// 검색 준비가 된 시점으로 최소 document 준비된 시점에 호출되어야 한다.
			grid.ready();
		});
	</script>
</body>
</head>