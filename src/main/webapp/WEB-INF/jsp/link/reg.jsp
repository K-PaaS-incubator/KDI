<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url var="homeUrl" value="/" />
<c:url var="linkUrl" value="/link/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
	<jsp:include page="../component/subTitle.jsp"></jsp:include>
	<div class="mainContent">
		<form id="linkCreate">
			<div class="link-wrapper">
				<div class="link-box-left">
					<div class="common-input-box">
						<div class="header6 label-title">연계서비스 제목</div>
						<input class="common-input subtitle1 gray400" type="text"
							id="svc_nm" name="svc_nm" required>
					</div>
					<div class="link-input-box">
						<div class="header6 label-title">데이터소스 선택</div>
						<select class="link-input subtitle1 gray400" name="ds_nm"
							id="ds_nm">
							<option selected disabled>--선택--</option>
							<c:forEach var="dsList" items="${selectDsList}">
								<option value="${dsList}">${dsList}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="link-box-right">
					<div class="link-input-box">
						<div class="header6 label-title">연계서비스 구분</div>
						<div class="link-radio-box">
							<label class="subtitle1 gray400"><input type="radio"
								name="svc_type" value="P" checked="checked">송신</label> <label
								class="subtitle1 gray400"><input type="radio"
								name="svc_type" value="S">수신</label>
						</div>
					</div>
					<div class="link-input-box"></div>
				</div>
			</div>
			<div class="link-button-box">
				<input class="button-second-gray" type="button" value="취소"
					onclick="location.href='${linkUrl}'"> <input
					class="button-primary" type="button" value="연계서비스 등록 >" id="regbtn">
			</div>
		</form>
	</div>

	<script>
		$(document).ready(function() {
			//배너 타이틀 세팅
			$('.banner-title').text('연계서비스')
			$('.banner-sub-title').text('연계서비스를 제공합니다')
			//페이지 타이틀 세팅
			$('.main-title-text').text('연계서비스 등록');
			$('.navi-arrow').text(' > 연계서비스 > 연계서비스 등록')
		});

		function fn_check_duplicate_link() {
			var svc_nm = $('#svc_nm').val();
			var checkResult = false;
			$.ajax({
				url : '${linkUrl}duplicateCheck.json', //컨트롤러에서 요청받을 주소
				type : 'POST',
				async : false,
				data : {
					'svc_nm' : svc_nm,
				},
				dataType : 'json',
				success : function(result) { //컨트롤러에서 넘어온 cnt값을 받는다
					if (result.data.cnt == 0) {
						checkResult = true;
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

		$('#regbtn').click(
				function LinkServiceSave() {
					$('form').validate();
					if (!fn_check_duplicate_link()) {
						alert('중복된 연계서비스명 입니다.');
						return;
					}

					$.ajax({
						url : '${linkUrl}reg.json',
						type : 'POST',
						async : false,
						data : $('#linkCreate').serialize(), //연계서비스생성(svc_id)
						success : function(result) {
							location.href = '${homeUrl}link';
						},
						error : function(result) {
							console.log('statusCode:' + result.statusCode);
							console.log('responseJSON:'
									+ result.responseJSON.state);
							console.log('responseJSON:'
									+ result.responseJSON.msg);
						}
					});
				});
	</script>

</section>