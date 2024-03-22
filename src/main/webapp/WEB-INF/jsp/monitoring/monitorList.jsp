<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">
<head>
	<link rel="stylesheet" href="${cssUrl}/ds.css">
	<meta charset="UTF-8">
	<title>연계 모니터링</title>
	<script>
		$(document).ready(function () {
			$('.banner-title').text('연계 모니터링')
			$('.banner-sub-title').text('연계 정보를 확인해 보세요')
		});
	</script>
</head>
<body>
<jsp:include page="../tiles/bannerLayout.jsp"></jsp:include>
<section class="contents">

	<div class="sideMenu">
		<div>송/수신 현황</div>
		<div>Log 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">연계 모니터링</div>
		<h2>모니터링 및 LOG 조회</h2>
	</div>

</section>
</body>
</html>
