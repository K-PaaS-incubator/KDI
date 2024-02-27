<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/link.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='${homeUrl}linkList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">연계 서비스 상세 관리</div>
	</div>

</section>