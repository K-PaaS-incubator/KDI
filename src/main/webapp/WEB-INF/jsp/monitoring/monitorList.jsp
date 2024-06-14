<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="mainContent">
	<table class="data-list">
		<colgroup>
			<col width="15%">
			<col width="40%">
			<col width="45%">
		</colgroup>
		<thead class="list-head">
			<tr class="subtitle1 gray500">
				<th>No</th>
				<th>데이터소스명</th>
				<th>URL</th>
			</tr>
			<tr class="table-spacing"></tr>
		</thead>
		<tbody class="list-body">
			<c:choose>
				<c:when test="${false}">
					<tr class="subtitle1 gray500">
						<td>1</td>
						<td>test</td>
						<td>test:test</td>
					</tr>
					<tr class="table-spacing"></tr>
				</c:when>
				<c:otherwise>
					<tr class="subtitle1 gray500">
						<td colspan="3">- 표시할 데이터가 없습니다 -</td>
					</tr>
					<tr class="table-spacing"></tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<script defer>
	$(document).ready(
			function() {
				$('.banner-title').text('연계 모니터링')
				$('.banner-sub-title').text('연계 정보를 확인해 보세요')

				//페이지 타이틀 세팅
				$('.main-title-text').text('연계 모니터링');
				$('.navi-arrow').text(' > 모니터링 > 연계 모니터링 조회')

				const subTitleArray = [ '연계 모니터링 조회', '송/수신 현황', 'Log 조회' ];
				subTitleArray.forEach(function(subtitle) {
					let html = '<div class="current-title header6">' + subtitle
							+ '</div>'
					$('.current-title-box').append(html);
				})
			});
</script>
