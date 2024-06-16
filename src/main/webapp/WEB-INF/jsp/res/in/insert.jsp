<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="pageUrl" value="/res/in/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<div class="mainContent">
	<form id="insert">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title pkTitle">인터페이스ID</div>
					<input class="ds-input subtitle1 gray400 pk" type="text"
						name="ifId" maxlength="33" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">인터페이스명</div>
					<!-- IP주소 -->
					<input class="ds-input subtitle1 gray400" type="text" name="ifNm"
						maxlength="33" required>

				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="등록" id="regbtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="취소"
					id="previousBtn">
			</div>
		</div>
	</form>
</div>

<script>
	$(document).ready(function() {
		fn_insert_page_load('자원관리', '인터페이스명');
	});
</script>
