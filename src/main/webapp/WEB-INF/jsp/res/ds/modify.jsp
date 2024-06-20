<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<style>
div[class*='detail-'] {
	display: none;
}
</style>
<div class="mainContent">
	<form id="modify" onsubmit="return false;">
		<input type="hidden" id="pk" name="dsNm">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title pk-title">데이터소스명</div>
					<input class="ds-input subtitle1 gray400 pk id-pattern" type="text" id="DS_NM" name="dsNm" readonly="readonly">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">DB Type</div>
					<select class="ds-input subtitle1 gray400" id="DS_TYPE" name="dsType" onchange="printName()">
						<option value="oracle" selected="selected">Oracle</option>
						<option value="mysql">Mysql</option>
						<option value="mariadb">MariaDB</option>
					</select>
				</div>
				<div class="ds-input-box detail-oracle-con-type">
					<div class="header6 label-title">접근방식</div>
					<select class="ds-input subtitle1 gray400" id="ORACLE_CON_TYPE" name="oracleConType" onchange="printName()">
						<option value=":">SID</option>
						<option value="/">서비스명</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div id="DS_TITLE" class="header6 label-title">데이터베이스명</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_SID" name="dsSid" onkeyup="printName()" required>
				</div>
				<div class="ds-input-box">
					<!-- 주소와 포트 자동완성-키업사용-->
					<div class="header6 label-title">URL</div>
					<input class="ds-input subtitle1 gray400" id="DS_URL" name="dsUrl" readonly />
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">Server Host</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_ADDR" name="dsAddr" onkeyup="printName()" placeholder="localhost" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Port</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_PORT" name="dsPort" onkeyup="printName()" placeholder="PORT" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">UserName</div>
					<input class="ds-input subtitle1 gray400" type="text" id="DS_USR_NM" name="dsUsrNm" onkeyup="printName()" required>
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
	const dsTypeMapping = {
		oracle : 'oracle-con-type',
		mysql : '',
		mariadb : '',
	};
	const fn_change_ds_title = function() {
		const dsType = $('#DS_TYPE').val();
		if ('oracle' == dsType) {
			const dsTitle = $('#ORACLE_CON_TYPE option:selected').text();
			$('#DS_TITLE').text(dsTitle);
			return;
		}
		$('#DS_TITLE').text('데이터베이스명');
	};
	$(document).ready(function() {
		fn_modify_page_load('데이터소스', '데이터소스');
		fn_input_box_display_event('dsType', dsTypeMapping).select();
		fn_change_ds_title();
	});

	$('#DS_TYPE, #ORACLE_CON_TYPE').change(function() {
		fn_change_ds_title();
	});

	const portMap = {
		oracle : '1521',
		mysql : '3306',
		mariadb : '3306',
		postgres : '5432',
		mssql : '1433'
	};
	const urlMap = {
		oracle : 'jdbc:oracle:thin:@',
		mysql : 'jdbc:mysql://',
		mariadb : 'jdbc:mariadb://'
	};

	function printName() {
		let ds_addr = $('#DS_ADDR').val() || '';
		let ds_port = $('#DS_PORT').val() || '';
		let ds_sid = $('#DS_SID').val() || '';
		let ds_type = $("#DS_TYPE").val() || '';

		if (ds_addr == '') {
			ds_addr = 'localhost';
			$('#DS_ADDR').val('localhost');
		}
		if (ds_port == '') {
			ds_port = portMap[ds_type];
			$('#DS_PORT').val(portMap[ds_type]);
		}
		let ds_url = urlMap[ds_type];
		switch (ds_type) {
		case 'mysql':
		case 'mariadb':
			ds_url += ds_addr + ':' + ds_port + '/' + ds_sid;
			break;
		case 'oracle':
		default:
			const oracleConType = $('select[name="oracleConType"]').val();
			ds_url += ds_addr + ':' + ds_port + oracleConType + ds_sid;
			break;
		}
		$('#DS_URL').val(ds_url);
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
