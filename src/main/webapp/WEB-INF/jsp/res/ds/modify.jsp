<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<div class="mainContent">
	<form id="modify" onsubmit="return false;">
		<input type="hidden" id="pk" name="orgDsUrl">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">데이터소스명</div>
					<input class="ds-input subtitle1 gray400 pk id-pattern" id="DS_NM" name="dsNm" readonly>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Server Host</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_ADDR" name="dsAddr" onkeyup="printName()">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Database</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_SID" name="dsSid" onkeyup="printName()" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">UserName</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_USR_NM" name="dsUsrNm" onkeyup="printName()" required>
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">DB Type</div>
					<select class="ds-input subtitle1 gray400" id="DS_TYPE" name="dsType" onchange="printName()">
						<option value="oracle">Oracle</option>
						<option value="mysql">Mysql</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Port</div>
					<!-- DB포트 -->
					<input class="ds-input subtitle1 gray400" type="text" id="DS_PORT" name="dsPort" onkeyup="printName()">
				</div>
				<div class="ds-input-box">
					<!-- 주소와 포트 자동완성-키업사용-->
					<div class="header6 label-title">URL:</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_URL" name="dsUrl" readonly>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Password</div>
					<input class="ds-input subtitle1 gray400" type="password" id="DS_USR_PW" name="dsUsrPw" required>
					<div id="test_result"></div>
					<div id="test_result2"></div>
				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="테스트" id="connTestBtn"> <input class="button-second" type="button" value="수정" id="modifyBtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="삭제" id="deleteBtn"> <input class="button-second-gray" type="button" value="이전" id="previousBtn">
			</div>
		</div>
	</form>
</div>
<script>
	const urlMap = {
		oracle : 'jdbc:oracle:thin:@',
		mysql : 'jdbc:mysql://'
	};

	$(document).ready(function() {
		fn_modify_page_load('데이터소스', '데이터소스');
		printName();
	});

	function printName() {
		var ds_addr = $('input[name="dsAddr"]').val();
		var ds_port = $('input[name="dsPort"]').val();
		var ds_sid = $('input[name="dsSid"]').val();
		var dsType = $('select[name="dsType"]').val();
		var urlDriver = urlMap[dsType];
		$('input[name="dsUrl"]').val(urlDriver + ds_addr + ':' + ds_port + ':' + ds_sid);
	}

	$('#connTestBtn').click(function databaseCheck() {
		$('form').validate();
		$.ajax({
			url : contextPath + 'res/ds/testConnection',
			type : 'POST',
			data : $('form').serialize(),
			dataType : 'JSON',
			success : function(result) {
				$('#test_result').text('');
				$('#test_result2').text('');
				$('#test_result').text('접속 테스트 성공');
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
				$('#test_result').text('접속 테스트 실패');
				$('#test_result2').text(result.responseJSON.msg);
			}
		});
	});
</script>
