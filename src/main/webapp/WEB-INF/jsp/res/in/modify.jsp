<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/in/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}ds.css">

<div class="mainContent">
	<form id="modify" onsubmit="return false;">
		<input type="hidden" name="orgIfId">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스ID</div>
					<input class="ds-input subtitle1 gray400" type="text" name="ifId">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스명</div>
					<input class="ds-input subtitle1 gray400" type="text" name="ifNm">
				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="수정" id="modifyBtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="삭제" id="deleteBtn"> <input class="button-second-gray" type="button" value="이전"
					onclick="location.href='${pageUrl}'">
			</div>
		</div>
	</form>
</div>
<script>
	$(document).ready(function() {
		//배너 타이틀 세팅
		$('.banner-title').text('인터페이스명 수정');
		$('.banner-sub-title').text('인터페이스명을 수정합니다.');
		//페이지 타이틀 세팅
		$('.main-title-text').text('인터페이스명 수정');
		$('.navi-arrow').text(' > 자원관리 > 인테페이스명');
		const orgIfId = new URL(location.href).searchParams.get('ifId');
		$('input[name="orgIfId"]').val(orgIfId);
		$('input[name="ifId"]').val(orgIfId);
		$('input[name="ifNm"]').val(fn_get_if_nm(orgIfId));
	});

	$('#modifyBtn').click(function() {
		$('#modify').validate();
		$.ajax({
			url : '${pageUrl}modify.json',
			type : 'POST',
			data : $('#modify').serialize(),
			dataType : 'json',
			success : function(result) {
				location.href = '${pageUrl}';
			},
			error : function(result) {
				console.log('statusCode:' + result.statusCode);
				console.log('responseJSON:' + result.responseJSON.state);
				console.log('responseJSON:' + result.responseJSON.msg);
				alert('인터페이스명 수정 실패');
			}
		});
	});

	$('#deleteBtn').click(function() {
		if (confirm('인터페이스명을 삭제하시겠습니까?')) {
			$.ajax({
				url : '${pageUrl}delete.json',
				type : 'POST',
				data : $('#modify').serialize(),
				dataType : 'json',
				success : function(result) {
					location.href = '${pageUrl}';
					alert('정상적으로 삭제되었습니다.');
				},
				error : function(result) {
					console.log(result);
					console.log('statusCode:' + result.statusCode);
					console.log('responseJSON:' + result.responseJSON.state);
					console.log('responseJSON:' + result.responseJSON.msg);
					alert('인터페이스명 삭제 실패');
				}
			});
		} else {
			alert('삭제 취소');
		}

	});
</script>
