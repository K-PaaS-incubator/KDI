<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/ds.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='${homeUrl}dsList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">데이터소스 관리</div>
		<table id="dsTbl">
			<thead>
				<tr>
					<th>No</th>
					<th>데이터소스 제목</th>
					<th>URL</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dsList" items="${selectDsList}">
					<tr>
						<td>${dsList.no}</td>
						<td>${dsList.ds_nm}</td>
						<td>${dsList.ds_url}</td>
					</tr>
				</c:forEach>
			
			</tbody>
		</table>

	<div><input type="button" id="savebtn" value="등록" onclick="location.href='${homeUrl}dsCreate'"></div>
        
	</div>
</section>


<script>
$( document ).ready(function() {
	$("#dsTbl tr").click(function(){
		location.href = "${homeUrl}dsEdit?ds_nm="+$(this).find("td:nth-child(2)").text();
	});
});
</script>

