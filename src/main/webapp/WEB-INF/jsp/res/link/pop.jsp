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
<script src="${jsUrl}kdi/kdi-main-data.js"></script>
<script src="${jsUrl}kdi/kdi-grid.js"></script>
<script type="text/javascript">
	const contextPath = '${homeUrl}';
</script>

<style type="text/css">
.selectSch {
	background-color: rgba(51, 106, 234, 0.10);
}
</style>
</head>
<body>
	<div class="mainContent" style="margin: 15px;">
		<form id="modify">
			<input type="hidden" id="SVC_ID" name="svcId" value="${svcId}">
			<div class="link-table-box-top">
				<div class="link-interface-box-top">
					<div class="header4 label-title">서비스 정보 변경</div>
				</div>
			</div>
			<div class="link-table-box-top">
				<div class="link-interface-box-top">
					<div class="link-inputs-row">
						<div class="common-input-box">
							<div class="header6 label-title">서비스명</div>
							<input type="text" class="interface-input subtitle1 gray400 tableSearch" id="SVC_NM" name="svcNm">
							<div class="header6 label-title">토픽명</div>
							<input type="text" class="interface-input subtitle1 gray400 tableSearch" id="TP_NM" name="tpNm">
							<div class="header6 label-title">데이터소스명</div>
							<select class="interface-input subtitle1 gray400" id="DS_NM" name="dsNm">
								<option value="">로딩중...</option>
							</select>
						</div>
					</div>
					<input class="button-primary" type="button" id="popIFbtn" value="저장">
				</div>
			</div>
		</form>
	</div>
	<div style="display: none;">
		<select id="DS_NM_FORMAT">
			<option value="#DS_NM#">#DS_NM#</option>
		</select>
	</div>
	<script type="text/javascript">
		var fn_editIF_SvcDs = function() {
			$('#modify').validate();
			$.ajax({
				url: contextPath + 'res/link/modify.json',
				type: 'POST',
				data: $('#modify').serialize(),
				dataType: 'json',
				success: function() {
					window.opener.parent.location.reload();
					window.close();
				},
				error: function(result) {
					console.log('statusCode:' + result.statusCode);
					console.log('responseJSON:' + result.responseJSON.state);
					console.log('responseJSON:' + result.responseJSON.msg);
					alert(pageNm + ' 수정 실패');
				}
			});
		};
		const fn_load_ds_nm = function() {
			const dsNmFormat = $('#DS_NM_FORMAT').html();
			$('#DS_NM').html('');
			$.each(kdiData().getAllDataSourceName(), function(idx, dsNm) {
				$('#DS_NM').append(dsNmFormat.replaceAll('#DS_NM#', dsNm));
			});
		};
		const fn_get_data = function() {
			const svcId = encodeURIComponent($('#SVC_ID').val());
			$.ajax({
				url : contextPath + 'res/link/get.json',
				type : 'GET',
				data : {
					svcId : svcId
				},
				dataType : 'json',
				success : function(result) {
					$('#SVC_NM').val(result.data.SVC_NM);
					$('#TP_NM').val(result.data.TP_NM)
					$('#DS_NM').val(result.data.DS_NM).prop('selected', true);
				}
			});
		}
		$().ready(function() {
			fn_load_ds_nm();
			fn_get_data();
			$('#popIFbtn').click(fn_editIF_SvcDs);

		});
	</script>
</body>
</head>