<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/userInfo.css">

<div class="contents">

		<div class="menuBox">
			<div class="menuBar" onclick="location.href='/dsList'">데이터소스</div>
			<div class="menuBar" onclick="location.href='/linkList'" >연계</div>
			<div class="menuBar" onclick="location.href='/monitorList'">모니터링</div>
			<div class="menuBar" onclick="location.href='/userInfo'">사용자관리</div>	<!-- 계정정보 수정 -->
			<div class="menuBar" onclick="location.href='/main'">What's KDI</div>
		</div>

		<div class="sideMenu">
			<div>사용자 정보 조회</div>
			<div>사용자 정보 수정</div>
		</div>
		
		<div class="mainContent">
			<div id="pageTitle">사용자 계정 정보</div>
			<div class="usrInfoBox">
				<div class="usrInfo">
					<h4>아이디</h4><span>${userInfo.usr_id}</span>
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
	
</div>

 