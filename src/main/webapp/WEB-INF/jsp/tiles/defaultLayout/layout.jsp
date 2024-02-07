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
<link rel="stylesheet" href="${cssUrl}/default/basic.css">
<script src="${jsUrl}/jquery/jquery-3.7.1.min.js"></script>
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