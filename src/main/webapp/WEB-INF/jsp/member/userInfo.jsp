<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />

<html lang="ko">
<head>
	<link rel="stylesheet" href="${cssUrl}/userInfo.css">
	<link rel="stylesheet" href="${cssUrl}/ds.css">
	<meta charset="UTF-8">

	<title>사용자 계정 정보</title>
	<script>
		$(document).ready(function () {
			$('.banner-title').text('사용자 계정 정보')
			$('.banner-sub-title').text('사용자 정보를 확인 및 수정할 수 있습니다')
		});
	</script>
</head>
<body>
<jsp:include page="../tiles/bannerLayout.jsp"></jsp:include>
<section class="contents">

	<div class="sideMenu">
		<div>사용자 정보</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">사용자 계정 정보</div>
		
		<div class="usrInfoBox">
			<div class="usrInfo">
				<h4>아이디</h4>
				<span>${userInfo.usr_id}</span>
			</div>
			<div class="usrInfo">
				<h4>회원명</h4>
				<input type="text" name="usr_nm" placeholder="${userInfo.usr_nm}">
			</div>
			<div class="usrInfo">
				<h4>연락처</h4>
				<input type="tel" name="usr_phone" placeholder="${userInfo.usr_phone}">
			</div>
			<div class="usrInfo">
				<h4>이메일</h4>
				<input type="email" name="usr_email" placeholder="${userInfo.usr_email}">
			</div>
		</div>
		
		<button id="saveBtn">저장</button>
	</div>

</section>
</body>
</html>

