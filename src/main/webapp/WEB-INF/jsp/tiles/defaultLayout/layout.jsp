<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="defaultCssUrl" value="/css/default/" />
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
<script src="${jqueryUrl}additional-methods.min.js"></script>
<script src="${jqueryUrl}jquery.validate.min.js"></script>
<script src="${jqueryUrl}messages_ko.min.js"></script>
<script src="${jsUrl}kdi/kdi-grid.js"></script>
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