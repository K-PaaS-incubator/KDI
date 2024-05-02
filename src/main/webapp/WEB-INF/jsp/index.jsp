<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="imgUrl" value="/img/" />
<link rel="stylesheet" href="${cssUrl}home.css">
<section>
	<div class="container">
		<div class="img-box">
			<img class="img-content" src="${imgUrl}bg-img-02.png" alt="">
		</div>
		<div class="bottom-box">
			<div class="description-box">
				<div class="description-main-text">K-PaaS Data Integration</div>
				<div class="description-sub-text">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temporidunt ut labore veniam...</div>
			</div>
			<div class="link-box">
				<a class="link-card" href="http://ppsystem.co.kr/"> <img class="card-img" src="${imgUrl}icon-pps.png" alt="피피에스 로고">
					<span class="card-text">PPS</span>
				</a> <a class="link-card" href="https://k-paas.or.kr/"> <img class="card-img" src="${imgUrl}icon-kpaas.png" alt="K-PAAS 로고">
					<span class="card-text">K-PaaS Data Integration</span>
				</a> <a class="link-card" href="https://github.com/K-PaaS-incubator/KDI"> <img class="card-img" src="${imgUrl}icon-github.png" alt="GitHub 로고">
					<span class="card-text">GitHub</span>
				</a> <a class="link-card" href="https://github.com/K-PaaS-incubator/KDI"> <img class="card-img" src="${imgUrl}icon-user.png" alt="">
					<span class="card-text">User Guide</span>
				</a>
			</div>
		</div>
	</div>
</section>
