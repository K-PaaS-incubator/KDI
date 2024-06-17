<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>

<div class="mainContent">
	<form id="insert">
		<!-- 데이터소스명 -->
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title pk-title">데이터소스명</div>
					<input class="ds-input subtitle1 gray400 pk id-pattern" type="text" id="DS_NM" name="dsNm" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Server Host</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_ADDR" name="dsAddr" onkeyup="printName()" placeholder="localhost" required>
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
						<option value="oracle" selected="selected">Oracle</option>
						<option value="mysql">Mysql</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Port</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_PORT" name="dsPort" onkeyup="printName()" placeholder="PORT" required>
				</div>
				<div class="ds-input-box">
					<!-- 주소와 포트 자동완성-키업사용-->
					<div class="header6 label-title">URL</div>
					<input class="ds-input subtitle1 gray400" id="DS_URL" name="dsUrl" readonly />
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
				<!-- 커넥션 테스트 기능 -->
				<input class="button-second" type="button" value="테스트" id="connTestBtn"> <input class="button-second" type="button" value="등록" id="regbtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="취소" id="previousBtn">
			</div>
		</div>
	</form>
</div>

<script>
	$(document).ready(function() {
		fn_insert_page_load('데이터소스', '데이터소스');
		printName();
	});

	const portMap = {
		oracle : '1521',
		mysql : '3306',
		postgres : '5432',
		mssql : '1433'
	};
	const urlMap = {
		oracle : 'jdbc:oracle:thin:@',
		mysql : 'jdbc:mysql://'
	};

	function printName() {
		var ds_addr = $('#DS_ADDR').val();
		var ds_port = $('#DS_PORT').val();
		var ds_sid = $('#DS_SID').val();
		var ds_type = $("#DS_TYPE").val();

		if (ds_addr == '') {
			ds_addr = 'localhost';
			$('#DS_ADDR').val('localhost');
		}
		if (ds_port == '') {
			ds_port = portMap[ds_type];
			$('#DS_PORT').val(portMap[ds_type]);
		}
		$('#DS_URL').val(
				urlMap[ds_type] + ds_addr + ':' + ds_port + ':' + ds_sid);
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

				console.log('result:' + result.state);
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
