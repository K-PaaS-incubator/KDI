<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<c:url var="cssUrl" value="/css/" />

<link rel="stylesheet" href="${cssUrl}userInfo.css">

<div class="mainContent">
	<div class="user-info-box">
		<div class="common-input-box">
			<div class="header6 label-title">아이디</div>
			<input class="common-input subtitle1 gray400" value="${userInfoEdit.usrId}" type="text" readonly>
		</div>
		<div class="common-input-box">
			<div class="header6 label-title">회원명</div>
			<input class="common-input subtitle1 gray400" value="${userInfoEdit.usrNm}" type="text">
		</div>
		<div class="common-input-box">
			<div class="header6 label-title">연락처</div>
			<input class="common-input subtitle1 gray400" value="${userInfoEdit.usrPhone}" type="text">
		</div>
		<div class="common-input-box">
			<div class="header6 label-title">이메일</div>
			<input class="common-input subtitle1 gray400" value="${userInfoEdit.usrEmail}" type="text">
		</div>
	</div>
	<div class="user-info-button-box">
		<input class="button-second" type="button" value="저장" id="saveBtn"> <input class="button-second-gray" type="button" value="취소" id="cancelBtn"
			onclick="location.href='${homeUrl}member/userInfo'">
	</div>
</div>
<script defer>
	$(document).ready(function() {
		$('.banner-title').text('사용자 계정 정보')
		$('.banner-sub-title').text('사용자 정보를 확인 및 수정할 수 있습니다')
		//페이지 타이틀 세팅
		$('.main-title-text').text('사용자정보 수정');
		$('.navi-arrow').text(' > 사용자정보 조회 > 사용자정보 수정')
	});
</script>

