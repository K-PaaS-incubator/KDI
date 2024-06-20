<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<c:url var="popUrl" value="/pop/" />

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
		<form id="editIF">
			<div class="link-table-box-top">
				<div class="link-interface-box-top">
					<div class="header4 label-title">서비스명 및 데이터소스 변경</div>
				</div>
			</div>
			<div class="link-table-box-top">
				<div class="link-interface-box-top">
					<div class="link-inputs-row">
						<div class="common-input-box">
							<div class="header6 label-title">서비스명</div>
							<input type="text" class="interface-input subtitle1 gray400 tableSearch" value="${svc_nm}" name="svc_nm"> <input type="hidden" value="${svc_id}" name="svc_id">
							<input type="hidden" value="${svc_type}" name="svc_type">
							<div class="header6 label-title">데이터소스명</div>
							<select class="interface-input subtitle1 gray400" name="dsNm">
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
		<select id="dsNmFromat">
			<option value="#DS_NM#">#DS_NM#</option>
		</select>
	</div>
	<script type="text/javascript">
		var fn_editIF_SvcDs = function() {
			var data = $('#editIF').serialize();
			$
					.ajax({
						url : '${popUrl}table/editIF.json',
						type : 'POST',
						data : data,
						dataType : 'JSON',
						success : function(result) {
							alert('수정이 완료되었습니다.');
							//serialize()에서 value값 가져오는 방법
							//svc_nm=$('#editIF [name="svc_nm"]').val(); 

							window.opener.parent.location.href = '${homeUrl}link/interface?'
									+ data;
							window.close();
						},
						error : function(result) {
							console.log('statusCode:' + result.statusCode);
							console.log('responseJSON:'
									+ result.responseJSON.state);
							console.log('responseJSON:'
									+ result.responseJSON.msg);
							alert('수정 실패');
						}
					});
		};

		$().ready(function() {
			$('#popIFbtn').click(fn_editIF_SvcDs);

		});
	</script>
</body>
</head>