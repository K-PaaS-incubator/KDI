<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="contents">

	<div class="menuBox">
		<div class="menuBar" onclick="location.href='/dsList'">데이터소스</div>
		<div class="menuBar" onclick="location.href='/link'">연계</div>
		<div class="menuBar" onclick="location.href='/monitorList'">모니터링</div>
		<div class="menuBar" onclick="location.href='/userInfo'">사용자관리</div>
		<!-- 계정정보 수정 -->
		<div class="menuBar" onclick="location.href='/main'">What's KDI</div>
	</div>

	<div class="sideMenu">
		<div onclick="location.href='/dsList'">데이터소스 조회</div>
		<div>데이터소스 등록</div>
		<div>데이터소스 변경</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">데이터소스 관리</div>
		<h2>데이터소스 설정해주세요</h2>
	</div>

</div>

