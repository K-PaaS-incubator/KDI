<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<div class="mainContent">
	<form id="modify" onsubmit="return false;">
		<input type="hidden" id="pk" name="orgIfId">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스ID</div>
					<input class="ds-input subtitle1 gray400 pk id-pattern" type="text" id="IF_ID" name="ifId">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스명</div>
					<input class="ds-input subtitle1 gray400" type="text" id="IF_NM" name="ifNm">
				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="수정" id="modifyBtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="삭제" id="deleteBtn"> <input class="button-second-gray" type="button" value="이전" id="previousBtn">
			</div>
		</div>
	</form>
</div>
<script>
	$(document).ready(function() {
		fn_modify_page_load('자원관리', '인터페이스명');
	});
</script>
