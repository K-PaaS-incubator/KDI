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
	<form <%-- action="${dsUrl}dsCheck" method="POST"  --%>id="dsCreate">
		<input type="hidden" id="ds_url" name="dsUrl">
		<!-- 데이터소스명 -->
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">데이터소스명</div>
					<input class="ds-input subtitle1 gray400 pk id-pattern" type="text" id="DS_NM" name="dsNm" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Server Host</div>
					<!-- IP주소 -->
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
					<select class="ds-input subtitle1 gray400" name="dsType" onchange="printName()">
						<option value="oracle" selected="selected">Oracle</option>
						<option value="mysql">Mysql</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Port</div>
					<!-- DB포트 -->
					<input class="ds-input subtitle1 gray400" type="text" id="ds_port" name="dsPort" onkeyup="printName()" placeholder="PORT" required>
				</div>
				<div class="ds-input-box">
					<!-- 주소와 포트 자동완성-키업사용-->
					<div class="header6 label-title">URL</div>
					<input class="ds-input subtitle1 gray400" id="dsUrlLabel" readonly />
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Password</div>
					<input class="ds-input subtitle1 gray400" type="password" id="ds_usr_pw" name="dsUsrPw" required>
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
				<input class="button-second-gray" type="button" value="취소" onclick="location.href='${dsUrl}'">
			</div>
		</div>
	</form>
</div>

<script>
	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('데이터소스')
		$('.banner-sub-title').text('데이터 정보를 한눈에 볼 수 있습니다')
		//페이지 타이틀 세팅
		$('.main-title-text').text('데이터소스 등록');
		$('.navi-arrow').text(' > 데이터소스 > 데이터소스 등록')
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
		var ds_addr = $('#ds_addr').val();
		var ds_port = $('#ds_port').val();
		var ds_sid = $('#ds_sid').val();
		var ds_type = $("select[name='dsType']").val();

		if (ds_addr == '') {
			ds_addr = 'localhost';
			$('#ds_addr').val('localhost');
		}
		if (ds_port == '') {
			ds_port = portMap[ds_type];
			$('#ds_port').val(portMap[ds_type]);
		}
		$('#ds_url_label').val(
				urlMap[ds_type] + ds_addr + ':' + ds_port + ':' + ds_sid);
		$('#ds_url').val(
				urlMap[ds_type] + ds_addr + ':' + ds_port + ':' + ds_sid);
	}

	$('#regbtn').click(function databaseSave() {

		$('form').validate();
		if (!fn_check_duplicate_ds()) {
			alert('데이터소스명이 중복되었습니다.');
			return;
		}
		$.ajax({
			url : '${dsUrl}dsInsert', //컨트롤러에서 요청받을 주소
			type : 'POST',
			async : false,
			data : $('#dsCreate').serialize(),
			success : function(result) {
				alert('등록 완료');
				location.href = '${dsUrl}';
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
			}
		});
	});

	function fn_check_duplicate_ds() {
		var ds_nm = $('input[name=dsNm]').val();
		var checkResult = false;
		$.ajax({
			url : '${dsUrl}dsCheck', //컨트롤러에서 요청받을 주소
			type : 'POST',
			async : false,
			data : {
				'ds_nm' : ds_nm,
			},
			success : function(result) {
				console.log(result);
				if (result == '정상') {
					checkResult = true;
				} else {
					checkResult = false;
				}
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
			}
		});
		return checkResult;
	}

	$('#connTestBtn').click(function databaseCheck() {
		$('form').validate();
		$.ajax({
			url : '${dsUrl}testConnection',
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
