<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="imgUrl" value="/img/" />
<link rel="stylesheet" href="${cssUrl}footer.css">
<footer>
	<div class="footer-wrapper">
		<div class="footer-main">
			<img src="${imgUrl}logo-kdi-footer.png" alt="">
			<p class="logo-text">K-PaaS Data Integration</p>
		</div>
		<div class="footer-sub subtitle1">
			<div class="footer-info">
				<p>주소 : 서울특별시 광진구</p>
				<p>대표번호 : 070-1234-5678</p>
				<p>팩스 : 070-1234-5678</p>
				<p>이메일 : pps@ppsystem.co.kr</p>
			</div>
			<div>
				<p>Contact PPS for more information</p>
			</div>
		</div>
	</div>
</footer>