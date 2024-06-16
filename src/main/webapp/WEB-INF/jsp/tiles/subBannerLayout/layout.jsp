<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="homeUrl" value="/" />
<c:url var="defaultCssUrl" value="/css/default/" />
<c:url var="imgUrl" value="/img/" />
<c:url var="jsUrl" value="/js/" />
<c:url var="jqueryUrl" value="/js/jquery/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>KDI</title>
<link rel="stylesheet" href="${defaultCssUrl}basic.css">
<link rel="stylesheet" href="${defaultCssUrl}common.css">
<script src="${jqueryUrl}jquery-3.7.1.min.js"></script>
<script src="${jqueryUrl}jquery.validate.min.js"></script>
<script src="${jqueryUrl}additional-methods.min.js"></script>
<script src="${jqueryUrl}messages_ko.min.js"></script>
<script src="${jsUrl}kdi/kdi-grid.js"></script>
<script type="text/javascript">
	const contextPath = '${homeUrl}';
</script>
</head>
<body>
	<!-- Page Header -->
	<tiles:insertAttribute name="header" />
	<div class="banner-box">
		<div class="banner-image-box">
			<img src="${imgUrl}img-banner-sm.png" alt="배너">
		</div>
		<div class="banner-title-box">
			<div class="banner-title header1 white80"></div>
			<div class="banner-sub-title subtitle1 white100"></div>
		</div>
	</div>
	<section class="contents">
		<div class="flex-col">
			<div class="main-title-text header2 gray500"></div>
			<div class="navi-text subtitle1 flex-row">
				<span><img src="${imgUrl}icon-home.png" alt=""></span> <span class="navi-arrow"></span>
			</div>
			<%--    <div class="flex-row current-title-box">--%>
			<%--    </div>--%>
		</div>
		<!-- Page Contents -->
		<tiles:insertAttribute name="section" />
	</section>
	<!-- Page Footer -->
	<tiles:insertAttribute name="footer" />

</body>
</html>