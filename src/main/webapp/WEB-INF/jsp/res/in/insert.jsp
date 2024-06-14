<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/in/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<div class="mainContent">
	<form id="insert">
		<input type="hidden" id="ds_url" name="ds_url">
		<!-- 데이터소스명 -->
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스ID</div>
					<input class="ds-input subtitle1 gray400" type="text" id="if_id" name="if_id" maxlength="33" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스명</div>
					<!-- IP주소 -->
					<input class="ds-input subtitle1 gray400" type="text" id="ds_addr" name="if_nm" maxlength="33" required>

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
		$('.banner-title').text('인터페이스명 등록');
		$('.banner-sub-title').text('인터페이스명을 등록합니다.');
		//페이지 타이틀 세팅
		$('.main-title-text').text('인터페이스명 등록');
		$('.navi-arrow').text(' > 자원 > 인테페이스명 등록');
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
			success : function(result) {
				alert('등록 완료');
				location.href = '${pageUrl}';
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
			}
		});
	});

	function fn_duplicate_check() {
		const if_id = $('input[name="if_id"]').val();
		let checkResult = false;
		$.ajax({
			url : '${pageUrl}duplicateCheck.json', //컨트롤러에서 요청받을 주소
			type : 'GET',
			async : false,
			dataType : 'json',
			data : {
				'if_id' : if_id,
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
