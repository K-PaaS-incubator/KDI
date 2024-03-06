<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/link.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='${homeUrl}linkList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">연계서비스 테이블 상세</div>

		<form>

			<div class="inputTitle"><div>테이블명 :</div>
			<input type="text" name="tbl_nm" placeholder="PUB_TEST_TABLE" readonly></div>
			<div class="inputTitle"><div>인터페이스 제목 :</div>
			<input type="text" name="if_nm" placeholder="인터페이스"></div>
			<div class="inputTitle"><div>스케줄 :</div>
				<input type="text" name="lnk_time" placeholder="스케줄"><span id="infoIcon">ℹ️</span>
			</div>
			
			<div class="inputTitle"><div>연계플래그 타입 :</div>
			<div id="radioBox">
				<label><input type="radio" name="flag_type" value="1" checked="checked">STATUS</label> 
				<label><input type="radio" name="flag_type" value="2">QUERY</label>
				<label><input type="radio" name="flag_type" value="3">WHERE</label>
			</div></div>
			
			<table id="lnktableTbl">
				<thead>
					<tr>
						<th>컬럼명</th>
						<th>컬럼타입</th>
						<th>DEFUALT</th>
						<th>연계여부</th>
						<th>연계 플래그 매핑</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>COLUMN1</td>
						<td>VARCHAR2(100)</td>
						<td>timestamp();</td>
						<td>
							<input type="checkbox" name="use_yn" id="use_yn" onclick="colUseCheck()">
						</td>
						<td>
							<select>
								<option value="1">STATUS</option>
								<option value="2">QUERY</option>
								<option value="3">WHERE</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>COLUMN2</td>
						<td>VARCHAR2(100)</td>
						<td>timestamp();</td>
						<td>
							<input type="checkbox" name="use_yn" id="use_yn" onclick="colUseCheck()">
						</td>
						<td>
							<select>
								<option value="1">STATUS</option>
								<option value="2">QUERY</option>
								<option value="3">WHERE</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div id="queryBox">
			<h4>조회쿼리</h4>
			</div>

			<input type="button" value="등록" id="regbtn" onclick="location.href='${homeUrl}linkList'">

		</form>

	</div>

	<script>
		function colUseCheck() {
			const use_yn = $("#use_yn").val;
			console.log("@@@@@@@@@@@@"+use_yn);
		}
	</script>

</section>