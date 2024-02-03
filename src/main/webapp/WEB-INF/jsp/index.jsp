<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>

<body id="index" onload="redirectPage();">
페이지 전환 중 입니다.
</body>

<script>
	function redirectPage() {
<%-- 팝업 허용되있거나 팝업기능을 사용하지 않아야 정상적으로 페이지가 노출된다.--%>
		window.open('main', '_self').close();
	}
	//"trans_list.do"
</script>

</html>
