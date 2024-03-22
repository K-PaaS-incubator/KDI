<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="homeUrl" value="/"/>
<c:url var="cssUrl" value="/css"/>
<c:url var="imgUrl" value="/img"/>
<link rel="stylesheet" href="${cssUrl}/header.css">
<header>
    <section class="title">
        <div class="header-wrapper">
            <div class="logo-box" onclick="location.href='${homeUrl}'">
                <img src="${imgUrl}/logo-kdi.png" alt="">
                <h1 class="header-title" >K-PaaS Data Integration</h1>
            </div>
            <div class="menu-wrapper">
                <nav class="menuBox header5">
                    <div class="menuBar" onclick="location.href='${homeUrl}ds/dsList'">데이터소스</div>
                    <div class="menuBar" onclick="location.href='${homeUrl}link/linkList'">연계서비스</div>
                    <div class="menuBar" onclick="location.href='${homeUrl}monitoring'">모니터링</div>
                    <div class="menuBar" onclick="location.href='${homeUrl}member/userInfo'">사용자정보</div>
                    <!-- 계정정보 수정 -->
                    <div class="menuBar" style="margin-right: 0px" onclick="location.href='${homeUrl}'">What's KDI</div>
                </nav>
            </div>
            <div>
                <sec:authorize access="isAuthenticated()">
<%--                    <a class="button-second" href="${homeUrl}member/singUp" style="margin-right: 12px">회원가입</a>--%>
<%--                    <a class="button-primary" href="${homeUrl}member/login">로그인</a>--%>
                    <a class="button-primary" href="${homeUrl}member/logout">로그아웃</a>
                </sec:authorize>
            </div>
        </div>
    </section>
</header>


