<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<div class="mainContent">
	<form id="modify" onsubmit="return false;">
		<input type="hidden" id="pk" name="orgTrnsPathId">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로 ID</div>
					<input class="ds-input subtitle1 gray400 pk" type="text"
						id="TRNS_PATH_ID" name="trnsPathId" maxlength="33" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로명</div>
					<input class="ds-input subtitle1 gray400" type="text"
						id="TRNS_PATH_NM" name="trnsPathNm" maxlength="33" required>
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로 유형</div>
					<select class="ds-input subtitle1 gray400" id="TRNS_PATH_TYPE"
						name="trnsPathType">
						<option value="1" selected="selected">파일</option>
						<option value="2">JMS</option>
						<option value="3">MQTT</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로</div>
					<input class="ds-input subtitle1 gray400" type="text"
						id="TRNS_PATH" name="trnsPath" maxlength="33" required>
				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="수정" id="modifyBtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="삭제"
					id="deleteBtn"> <input class="button-second-gray"
					type="button" value="이전" id="previousBtn">
			</div>
		</div>
	</form>
</div>
<script>
	$(document).ready(function() {
		fn_modify_page_load('자원관리', '전송경로 정보');
	});
</script>
