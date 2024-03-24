<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
	<jsp:include page="../component/subTitle.jsp"></jsp:include>
	<div class="sideMenu">
		<div>송/수신 현황</div>
		<div>Log 조회</div>
	</div>
	<div class="mainContent">
		<div id="pageTitle">연계 모니터링</div>
		<h2>모니터링 및 LOG 조회</h2>
	</div>

</section>
<script defer>
	$(document).ready(function () {
		$('.banner-title').text('연계 모니터링')
		$('.banner-sub-title').text('연계 정보를 확인해 보세요')

		//페이지 타이틀 세팅
		$('.main-title-text').text('연계 모니터링');
		$('.navi-arrow').text(' > 모니터링 > 연계 모니터링 조회')

		const subTitleArray = ['연계 모니터링 조회', '송/수신 현황', 'Log 조회'];
		subTitleArray.forEach(function (subtitle){
			let html = '<div class="current-title header6">' + subtitle + '</div>'
			$('.current-title-box').append(html);
		})
	});
</script>
