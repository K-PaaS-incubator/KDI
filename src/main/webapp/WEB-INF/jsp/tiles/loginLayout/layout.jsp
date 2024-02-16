<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<c:url var="jsUrl" value="/js" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>KDI</title>
<script src="${jsUrl}/jquery/jquery-3.7.1.min.js"></script>
<script src="${jsUrl}/jquery/additional-methods.min.js"></script>
<script src="${jsUrl}/jquery/jquery.validate.min.js"></script>
<script src="${jsUrl}/jquery/messages_ko.min.js"></script>
<style>
header {
	background: #0077B6;
	height: 100px;
}

section {
	height: 100%;
	background: rgba(144, 224, 239, 0.2);
}

footer {
	background: #03045E;
	height: 100px;
	text-align: center;
	color: #CAF0C8;
}
</style>

</head>
<body>
	<!-- Page Header -->
	<tiles:insertAttribute name="header" />

	<!-- Page Contents -->
	<tiles:insertAttribute name="section" />

	<!-- Page Footer -->
	<tiles:insertAttribute name="footer" />

</body>
</html>