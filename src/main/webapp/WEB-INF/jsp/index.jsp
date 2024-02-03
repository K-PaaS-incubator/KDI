<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/"/>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/main.css">

<div class="contents">

	<div class="menuBox">
		<div class="menuBar" onclick="location.href='${homeUrl}dsList'">데이터소스</div>
		<div class="menuBar" onclick="location.href='${homeUrl}link'">연계</div>
		<div class="menuBar" onclick="location.href='${homeUrl}monitorList'">모니터링</div>
		<div class="menuBar" onclick="location.href='${homeUrl}userInfo'">사용자관리</div>
		<!-- 계정정보 수정 -->
		<div class="menuBar" onclick="location.href='${homeUrl}'">What's KDI</div>
	</div>

	<div style="height: 300px;">
		<div id="pageTitle">TO DO: KDI MAIN 및 첫화면 내용 추가</div>
		<h2>사용할 메뉴를 선택해주세요.</h2>
	</div>

</div>
