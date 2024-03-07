<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/link.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='${homeUrl}linkList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">연계서비스 항목 설정</div>

		<form>
			<div id="inContent">
				<div id="leftContent">
					<!-- //TODO 선택한 ds_nm이 와야함 -->
					<div class="leftTitle">${getLinkService.ds_nm}</div>
					<div></div>
					<div class="subTitle">스키마 선택</div>
					<ul><!-- //TODO 스키마명 많을 경우 스크롤로 볼 수 있게 개발 -->
						<li>스키마명1</li>
						<li>스키마명2</li>
						<li>스키마명3</li>
					</ul>
				</div>

				<div id="rightContent">
				<!--  //TODO 선택한 ds_nm과 선택한 스키마명이 와야함 -->
				<div class="subTitle">데이터소스제목 - 스키마명1</div>
				<!--  //TODO 테이블명 검색기능 -->
				<div id="searchBox"><span>🔎 </span>검색어를 입력하세요</div>
					<table id="detailTbl">
						<thead>
							<tr>
								<th>No</th>
								<th>테이블명</th>
								<th>연계여부</th>
								<th>Comment</th>
							</tr>
						</thead>
						<tbody>
							<tr class="detailTr">
								<td>1</td>
								<td>PUB_TEST_TABLE</td>
								<td>N</td>
								<td></td>
							</tr>
							<tr class="detailTr">
								<td>2</td>
								<td>PUB_TEST_TABLE2</td>
								<td>N</td>
								<td></td>
							</tr>
						</tbody>
					</table>

				</div>
			</div>
			<input type="button" value="다음🔜" id="regbtn" onclick="location.href='${homeUrl}linkTable'">
		</form>
	</div>

	<script>
	
	function linkgetDs(){
		var svc_nm = $('#svc_nm').val();
		var checkResult = false;
		$.ajax({
			url : '/link/getLinkService', //컨트롤러에서 요청받을 주소
			type : 'POST',
			async : false,
			data : {
				'svc_nm' : svc_nm,
			},
			success : function(result) {
				consol.log("여기로 오나보자:" + svc_nm);
			},
			error : function(a, b, c) {
				console.log(a, b, c);
			}
		});
		return checkResult;
	}
		
	</script>

</section>