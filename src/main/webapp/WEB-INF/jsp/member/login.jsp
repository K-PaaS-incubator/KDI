<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:url var="homeUrl" value="/" />
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/login.css">
<section class="wrap">
	<div class="login">
		<h2>KDI Log-in</h2>
		<div class="login_sns">
			<p>
				<span id="valid" class="alert alert-danger">${exception}</span>
			</p>
		</div>
		<form:form action="${homeUrl}member/loginProc" method="POST" id="loginform">
			<div class="login_id">
				<h4>아이디</h4>
				<input type="text" name="usr_id" id="email" placeholder="ID">
			</div>
			<div class="login_pw">
				<h4>비밀번호</h4>
				<input type="password" name="usr_pw" id="password" placeholder="Password">
			</div>
			<div class="login_etc">
				<div class="signup">
					<a href="${homeUrl}member/signUp">회원가입</a>
				</div>
				<div class="forgot_pw">
					<a href="${homeUrl}member/forgotPw">비밀번호 찾기</a>
				</div>
			</div>
			<div class="submit">
				<input type="submit" value="로그인">
			</div>
		</form:form>
	</div>
</section>