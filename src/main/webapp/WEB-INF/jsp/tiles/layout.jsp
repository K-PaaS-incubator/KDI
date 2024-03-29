<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KDI</title>

<style>
.header {
	background: #0077B6;
	height: 100px;
}

.contents {
	height: 100%;
	background: rgba(144, 224, 239, 0.2);
}

.footer {
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
	<tiles:insertAttribute name="body" />

	<!-- Page Footer -->
	<tiles:insertAttribute name="footer" />

</body>
</html>