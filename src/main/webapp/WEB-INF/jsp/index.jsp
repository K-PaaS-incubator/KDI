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
				<div class="description-sub-text">다양한 애플리케이션과 데이터 소스를 연결하여 정보를 교환하고, 서로 연계되게 만드는 기술로써, 
				<div class="description-sub-text">여러분이 사용하는 다양한 앱이나 시스템들이 서로 정보를 주고받을 수 있도록 해줍니다.</div></div>
				<div class="description-sub-text">KDI는 데이터를 실시간으로 전송하거나 변환하는 기능을 제공하여, 여러 시스템 간에 원활한 소통과 협력을 가능하게 합니다.</div>
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
