<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<header>
	<section class="title">
		<sec:authorize access="isAuthenticated()">
			<a class="logout" href="${homeUrl}member/logout">로그아웃</a>
		</sec:authorize>
		<h1>K-PaaS Data Integration</h1>
	</section>
	<nav class="menuBox">
		<div class="menuBar" onclick="location.href='${homeUrl}ds/dsList'">데이터소스</div>
<<<<<<< HEAD
		<div class="menuBar" onclick="location.href='${homeUrl}link/linkList'">연계</div>
=======
		<div class="menuBar" onclick="location.href='${homeUrl}link/linkList'">연계서비스</div>
>>>>>>> branch 'main' of http://git.biz.ppsystem.co.kr/cloud/kdi.git
		<div class="menuBar" onclick="location.href='${homeUrl}monitoring'">모니터링</div>
		<div class="menuBar" onclick="location.href='${homeUrl}member/userInfo'">사용자정보</div>
		<!-- 계정정보 수정 -->
		<div class="menuBar" onclick="location.href='${homeUrl}'">What's KDI</div>
	</nav>
</header>


