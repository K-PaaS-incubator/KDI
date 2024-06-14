<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="dsUrl" value="/res/ds/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}ds.css">

<div class="mainContent">
	<form id="dsEdit" onsubmit="return false;">
		<input type="hidden" id="ds_url" name="dsUrl" value="${selectDsInfo.dsUrl}">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">데이터소스 제목</div>
					<input class="ds-input subtitle1 gray400" id="ds_nm" name="dsNm" value="${selectDsInfo.dsNm}" readonly>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Server Host</div>
					<!-- IP주소 -->
					<input class="ds-input subtitle1 gray400" type="text" name="dsAddr" value="${selectDsInfo.dsAddr}" onkeyup="printName()">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Database</div>
					<input class="ds-input subtitle1 gray400" type="text" name="dsSid" value="${selectDsInfo.dsSid}" onkeyup="printName()" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">UserName</div>
					<input class="ds-input subtitle1 gray400" type="text" name="dsUsrNm" value="${selectDsInfo.dsUsrNm}" onkeyup="printName()" required>
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">DB Type</div>
					<input class="ds-input subtitle1 gray400" type="text" name="dsType" value="${selectDsInfo.dsType}" readonly>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Port</div>
					<!-- DB포트 -->
					<input class="ds-input subtitle1 gray400" type="text" name="dsPort" value="${selectDsInfo.dsPort}" onkeyup="printName()">
				</div>
				<div class="ds-input-box">
					<!-- 주소와 포트 자동완성-키업사용-->
					<div class="header6 label-title">URL:</div>
					<input class="ds-input subtitle1 gray400" type="text" id="ds_url_label" readonly>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">Password</div>
					<input class="ds-input subtitle1 gray400" type="password" name="dsUsrPw" value="${selectDsInfo.dsUsrPw}" required>
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
				<input class="button-second-gray" type="button" value="삭제" id="deleteBtn"> <input class="button-second-gray" type="button" value="이전" onclick="location.href='${dsUrl}'">
			</div>
		</div>
	</form>
</div>
<script>
	const ds_url = '${selectDsInfo.dsUrl}';
	const urlMap = {
		oracle : 'jdbc:oracle:thin:@',
		mysql : 'jdbc:mysql://'
	};

	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('데이터소스')
		$('.banner-sub-title').text('데이터 정보를 한눈에 볼 수 있습니다')
		//페이지 타이틀 세팅
		$('.main-title-text').text('데이터소스 수정');
		$('.navi-arrow').text(' > 데이터소스 > 데이터소스 조회 > 데이터소스 수정')
		printName();
		$('#ds_url_label').val(ds_url);
	});

	function printName() {
		var ds_addr = $('input[name="dsAddr"]').val();
		var ds_port = $('input[name="dsPort"]').val();
		var ds_sid = $('input[name="dsSid"]').val();
		var urlDriver = null;
		if (ds_url.includes('oracle')) {
			urlDriver = urlMap['oracle'];
		} else if (ds_url.includes('mysql')) {
			urlDriver = urlMap['mysql'];
		}
		$('#ds_url_label').text(
				urlDriver + ds_addr + ':' + ds_port + ':' + ds_sid);
		$('input[name="dsUrl"]').val(urlDriver + ds_addr + ':' + ds_port + ':' + ds_sid);
	}

	$('#modifyBtn').click(function databaseSave() {
		$('form').validate();
		$.ajax({
			url : '${dsUrl}dsEditProc',
			type : 'POST',
			data : $('form').serialize(),
			dataType : 'JSON',
			success : function(result) {
				console.log('result:' + result.state);
				location.href = '${dsUrl}';
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
				alert('데이터소스 수정 실패');
			}
		});
	});

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

	$('#deleteBtn').click(function databaseDel() {
		if (confirm('데이터소스를 삭제하시겠습니까?')) {
			$.ajax({
				url : '${dsUrl}dsDelProc',
				type : 'POST',
				data : $('form').serialize(),
				dataType : 'JSON',
				success : function(result) {
					console.log('result:' + result.state);
					$('form').submit();
					location.href = '${dsUrl}';
					alert('정상적으로 삭제되었습니다.');
				},
				error : function(result) {
					console.log(result);
					console.log('statusCode:' + result.statusCode);
					console.log('responseJSON:' + result.responseJSON.state);
					console.log('responseJSON:' + result.responseJSON.msg);
					alert('데이터소스 삭제 실패');
				}
			});
		} else {
			alert('삭제 취소');
		}

	});
</script>
