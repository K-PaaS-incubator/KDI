<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url var="memberUrl" value="/member/" />
<c:url var="cssUrl" value="/css/" />
<link rel="stylesheet" href="${cssUrl}signUp.css">

<section class="signup-wrap">
	<div class="signup-box">
		<div class="signup-logo-box">
			<h2 class="header3 gray500">회원가입</h2>
		</div>
		<div class="signUpEx">
			<p>
				<span id="valid" class="alert alert-danger">${exception}</span>
			</p>
		</div>
		<form id="signupUser">
			<!-- onsubmit="return false;"옵션은 해당 form태그안에 input type='text'가 1개일 경우 엔터키 입력시 자동으로 form태그의 action에 명시된 url을 통해서 submit이 호출되는것을 막아줌 -->
			<div class="signup-input-box">
				<p class="subtitle1 gray400">사용하실 아이디를 입력해 주세요.</p>
				<input class="signup-input subtitle1" type="text" name="usrId" placeholder="ID" required>
			</div>
			<div class="signup-input-box">
				<p class="subtitle1 gray400">사용하실 비밀번호를 입력해 주세요.</p>
				<input class="signup-input subtitle1" type="password" name="usrPw" placeholder="PASSWORD" required>
			</div>
			<div class="signup-input-box">
				<p class="subtitle1 gray400">회원명 입력해 주세요.</p>
				<input class="signup-input subtitle1" type="text" name="usrNm" placeholder="NAME" required>
			</div>
			<div class="signup-input-box">
				<p class="subtitle1 gray400">연락처를 입력해 주세요.</p>
				<input class="signup-input subtitle1" type="tel" name="usrPhone" placeholder="ex) 010-1234-5678" required>
			</div>
			<div class="signup-input-box">
				<p class="subtitle1 gray400">이메일을 입력해 주세요.</p>
				<input class="signup-input subtitle1" type="email" name="usrEmail" placeholder="ex) you@example.com" required>
			</div>
			<div class="signUpEx">
				<p class="subtitle1 primary">※ 가입완료 후 관리자에게 권한을 요청하세요.</p>
			</div>
			<div class="submit signup-button-box">
				<input class="signup-button-style" type="button" id="signupBtn" value="회원가입">
			</div>
		</form>
	</div>
	<script>
		function validation() { //사용안하는중
			/* var RegExp = /^[a-zA-Z0-9]{4,12}$/; //id와 pwassword 유효성 검사 정규식
			//이메일 유효성검사        
			var e_RegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			var n_RegExp = /^[가-힣]{2,15}$/; *///이름 유효성검사 정규식
			var usr_id = $("[name='usrId']").val();
			var usr_pw = $("[name='usrPw']").val();
			var usr_phone = $("[name='usrPhone']").val();
			var usr_email = $("[name='usrEmail']").val();
		}

		$('#signupBtn').click(function() {
			$('form').validate();
			if (!fn_check_duplicate_id()) {
				alert('아이디가 중복되었습니다.');
				return;
			}
			$.ajax({
				url : '${memberUrl}signUp',
				type : 'POST',
				async : false,
				data : $('#signupUser').serialize(),
				dataType : 'json',
				success : function(result) {
					alert('회원가입 완료');
					location.href = '${memberUrl}login';
				},
				error : function(result) {
					if (result.statusCode == '400') {
						alert(responseJSON.state + "\n" + responseJSON.msg);
					} else {
						alert("회원가입실패\n" + result);
					}
				}
			});
		});

		function fn_check_duplicate_id() {
			var check = false;
			$.ajax({
				url : '${memberUrl}idCheck',
				type : 'POST',
				async : false,
				data : $('input[name=usrId]').serialize(),
				dataType : 'json',
				success : function(result) {
					console.log(result)
					if (!result.state) {
						check = false;
					} else {
						check = true;
					}
				},
				error : function(xhr) {
					check = false;
					console.log(xhr);
				}
			});
			return Boolean(check);
		}
	</script>
</section>