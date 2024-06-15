<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/tpi/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<div class="mainContent">
	<form id="insert">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로 ID</div>
					<input class="ds-input subtitle1 gray400" type="text" name="trnsPathId" maxlength="33" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로명</div>
					<input class="ds-input subtitle1 gray400" type="text" name="trnsPathNm" maxlength="33" required>
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로 유형</div>
					<select class="ds-input subtitle1 gray400" name="trnsPathType">
						<option value="1" selected="selected">파일</option>
						<option value="2">JMS</option>
						<option value="3">MQTT</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로</div>
					<input class="ds-input subtitle1 gray400" type="text" name="trnsPath" maxlength="33" required>
				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="등록" id="regbtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="취소" onclick="location.href='${pageUrl}'">
			</div>
		</div>
	</form>
</div>

<script>
	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('전송경로 정보 등록');
		$('.banner-sub-title').text('전송경로 정보를 등록합니다.');
		//페이지 타이틀 세팅
		$('.main-title-text').text('전송경로 정보 등록');
		$('.navi-arrow').text(' > 자원관리 > 전송경로 정보 > 등록');
	});

	$('#regbtn').click(function databaseSave() {

		$('form').validate();
		const duplicate = fn_duplicate_check();
		if (!duplicate) {
			alert('인터페이스ID가 중복되었습니다.');
			return;
		}
		$.ajax({
			url : '${pageUrl}insert.json', //컨트롤러에서 요청받을 주소
			type : 'POST',
			async : false,
			data : $('#insert').serialize(),
			dataType : 'json',
			success : function(result) {
				alert('등록 완료');
				location.href = '${pageUrl}';
			},
			error : function(result) {
				alert(result.responseJSON.msg);
			}
		});
	});

	function fn_duplicate_check() {
		const trnsPathId = encodeURIComponent($('input[name="trnsPathId"]').val());
		let checkResult = false;
		$.ajax({
			url : '${pageUrl}duplicateCheck.json', //컨트롤러에서 요청받을 주소
			type : 'GET',
			async : false,
			dataType : 'json',
			data : {
				'trnsPathId' : trnsPathId
			},
			success : function(result) {
				checkResult = result.data;
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
			}
		});
		return checkResult;
	}
</script>
