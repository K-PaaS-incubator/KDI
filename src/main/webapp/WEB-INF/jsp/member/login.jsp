<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url var="homeUrl" value="/"/>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/login.css">

<section class="login-wrap">
    <div class="login-box">
        <div class="login-logo-box">
            <img src="/img/logo-kdi.png" alt="">
            <h1 class="login-logo-text">K-PaaS Data Integration</h1>
        </div>
        <div class="login_sns">
            <p>
                <span id="valid" class="alert alert-danger">${exception}</span>
            </p>
        </div>
        <div class="login-form-box">
            <form:form action="${homeUrl}member/loginProc" method="POST" id="loginform">
                <div class="login-input-box">
                    <div>
                        <img src="/img/icon-login-id.png" alt="">
                    </div>
                    <input class="login-input subtitle1" type="text" name="usr_id" id="email" placeholder="아이디">
                </div>
                <div class="login-input-box">
                    <div>
                        <img src="/img/icon-login-pw.png" alt="">
                    </div>
                    <input class="login-input subtitle1" type="password" name="usr_pw" id="password" placeholder="비밀번호">
                </div>
                <div class="login-signup-box">
                    <div class="forgot_pw body1 gray500">
                        <a href="${homeUrl}member/forgotPw">비밀번호 찾기</a>
                    </div>
                    <div class="login-divided">|</div>
                    <div class="signup body1 gray500">
                        <a href="${homeUrl}member/signUp">회원가입</a>
                    </div>
                </div>
                <div class="login-button-box">
                    <input type="submit" class="login-button-style" value="로그인">
                </div>
            </form:form>
        </div>
    </div>
</section>