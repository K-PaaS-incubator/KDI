<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="homeUrl" value="/"/>
<c:url var="cssUrl" value="/css"/>
<c:url var="imgUrl" value="/img"/>
<link rel="stylesheet" href="${cssUrl}/home.css">
<section>
    <div class="container">
        <div class="img-box">
            <img class="img-content" src="${imgUrl}/bg-img-02.png" alt="">
        </div>
        <div class="bottom-box">
            <div class="description-box">
				<div class="description-main-text">K-PaaS Data Integration</div>
				<div class="description-sub-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temporidunt ut labore veniam...</div>
			</div>
            <div class="link-box">
				<a class="link-card" href="http://ppsystem.co.kr/">
					<img class="card-img" src="${imgUrl}/icon-pps.png" alt="">
					<div class="card-text">PPS</div>
				</a>
				<a class="link-card" href="https://k-paas.or.kr/">
					<img class="card-img" src="${imgUrl}/icon-kpaas.png" alt="">
					<div class="card-text">K-PaaS Data Integration</div>
				</a>
				<a class="link-card" href="https://github.com/K-PaaS-incubator/KDI">
					<img class="card-img" src="${imgUrl}/icon-github.png" alt="">
					<div class="card-text">GitHub</div>
				</a>
				<a class="link-card" href="https://github.com/K-PaaS-incubator/KDI">
					<img class="card-img" src="${imgUrl}/icon-guide.png" alt="">
					<div class="card-text">User Guide</div>
				</a>
			</div>
        </div>
    </div>
</section>
