<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<header>
	<h1>K-PaaS Data Integration</h1>
	<sec:authorize access="isAuthenticated()">
		<a href="/logout">로그아웃</a>
	</sec:authorize>
	<nav class="menuBox">
		<div class="menuBar" onclick="location.href='${homeUrl}ds'">데이터소스</div>
		<div class="menuBar" onclick="location.href='${homeUrl}link'">연계</div>
		<div class="menuBar" onclick="location.href='${homeUrl}monitoring'">모니터링</div>
		<div class="menuBar" onclick="location.href='${homeUrl}userInfo'">사용자관리</div>
		<!-- 계정정보 수정 -->
		<div class="menuBar" onclick="location.href='${homeUrl}'">What's KDI</div>
	</nav>
</header>


