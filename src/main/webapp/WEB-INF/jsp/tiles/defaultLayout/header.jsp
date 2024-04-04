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
        <div class="header-container">
            <div class="header-wrapper">
                <div class="logo-box" onclick="location.href='${homeUrl}'">
                    <img src="${imgUrl}/logo-kdi.png" alt="">
                    <h1 class="header-title">K-PaaS Data Integration</h1>
                </div>
                <nav class="menu-wrapper">
                    <ul class="menuBox header5">
                        <li class="menuBar" onclick="location.href='${homeUrl}ds/dsList'">데이터소스</li>
                        <li class="menuBar" onclick="location.href='${homeUrl}link/linkList'">연계서비스</li>
                        <li class="menuBar" onclick="location.href='${homeUrl}monitoring'">모니터링</li>
                        <li class="menuBar" onclick="location.href='${homeUrl}member/userInfo'">사용자정보</li>
                        <li class="menuBar" onclick="location.href='${homeUrl}'">What's KDI</li>
                    </ul>
                </nav>
                <div>
                    <sec:authorize access="isAuthenticated()">
                        <a class="button-primary" href="${homeUrl}member/logout" style="padding: 12px 40px;">로그아웃</a>
                    </sec:authorize>
                </div>
            </div>
            <div id="menuListHover" class="dropdown-menu">
                <div class="menu-list">
                    <div class="logo-box" style="visibility: hidden">
                        <img src="${imgUrl}/logo-kdi.png" alt="">
                        <h1 class="header-title">K-PaaS Data Integration</h1>
                    </div>
                    <div class="flex-col">
                        <nav class="menu-wrapper">
                            <ul class="menu-hover-box body1 gray500">
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}ds/dsList'">데이터소스 조회</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}link/linkList'">연계서비스 조회</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}monitoring'">모니터링 조회</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}member/userInfo'">사용자정보 조회</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}'">What's KDI</li>
                            </ul>
                        </nav>
                        <nav class="menu-wrapper">
                            <ul class="menu-hover-box body1 gray500">
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}ds/dsCreate'">데이터소스 등록</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}link/linkService'">연계서비스 등록</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}monitoring'">로그 조회</li>
                                <li class="menu-hover-content" onclick="location.href='${homeUrl}member/userInfo'">사용자정보 수정</li>
                                <li class="menu-hover-content"></li>
                            </ul>
                        </nav>
                    </div>
                    <div style="visibility: hidden">
                        <div class="button-primary" style="padding: 12px 40px;">로그아웃</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script defer>
        var hoveringMenu = false

        $('.menuBar').on({
            mouseenter: function () {
                $('#menuListHover').stop().fadeIn(200)
            },
            mouseleave: function () {
                if(!hoveringMenu) {
                    $('#menuListHover').stop().fadeOut(200)
                }
            }
        });
        $('#menuListHover').on({
            mouseenter: function () {
                hoveringMenu = true
            },
            mouseleave: function () {
                hoveringMenu = true
                $('#menuListHover').stop().fadeOut(200);
            }
        })
    </script>
</header>


