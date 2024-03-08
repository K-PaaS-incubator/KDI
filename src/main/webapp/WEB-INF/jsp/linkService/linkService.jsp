<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/link.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='${homeUrl}linkList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">연계서비스 등록</div>
		
		<form id="linkCreate">
			<!-- 연계서비스 제목 -->
			<div class="divTitle">연계서비스 제목</div>
			<input type="text" id="svc_nm" name="svc_nm" required>
		
			<!-- 연계서비스 구분 -->
			<div class="divTitle">연계서비스 구분</div>
			<label><input type="radio" name="svc_type" value="P" checked="checked">송신서비스</label>
			<label><input type="radio" name="svc_type" value="S">수신서비스</label>	
		
			<!-- 데이터소스 선택 -->
			<div class="divTitle">데이터소스 선택</div>
			<select name="ds_nm" id="ds_nm">
					<option>--선택--</option>
				<c:forEach var="dsList" items="${selectDsList}" begin="1">
					<option value="${dsList}">${dsList}</option>
				</c:forEach>
			</select>
			<div></div>
		
			<input type="button" value="다음🔜" id="regbtn">
		</form>
		
	</div>
	
	<script>
	
	function fn_check_duplicate_link(){
		var svc_nm = $('#svc_nm').val();
		var checkResult = false;
		$.ajax({
			url : '/link/linkCntCheck', //컨트롤러에서 요청받을 주소
			type : 'POST',
			async : false,
			data : {
				'svc_nm' : svc_nm,
			},
			success : function(result) { //컨트롤러에서 넘어온 cnt값을 받는다
				if (result == 0) {
					checkResult =  true;
				} else {
					checkResult = false;
				}
			},
			error : function(a, b, c) {
				console.log(a, b, c);
			}
		});
		return checkResult;
	}
	
	$('#regbtn').click(function LinkServiceSave() {
		console.log("데이터소스 선택: "+$('#ds_nm').val());
		$('form').validate(); 
		 if(!fn_check_duplicate_link()){
			 alert('제목이 중복되었습니다.');
			 return;
		 }
		$.ajax({
			url : '${homeUrl}LinkInsert',
			type : 'POST',
			async : false,
			data :  $('#linkCreate').serialize(),
			success : function(result) {
				location.href='${homeUrl}getLinkService?svc_nm='+$("#svc_nm").val();
			},
			error : function(result) {
				console.log('statusCode:'+result.statusCode);
		        console.log('responseJSON:'+result.responseJSON.state);
		        console.log('responseJSON:'+result.responseJSON.msg);
			}
		});
	});	
	</script>

</section>