<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/signUp.css">

<section class="wrap">
	<div class="signUp">
		<h2>회원가입</h2>
		<div class="signUpEx">
			<p>
				<span id="valid" class="alert alert-danger">${exception}</span>
			</p>
		</div>
		<form id="signupUser">
		<!-- onsubmit="return false;"옵션은 해당 form태그안에 input type='text'가 1개일 경우 엔터키 입력시 자동으로 form태그의 action에 명시된 url을 통해서 submit이 호출되는것을 막아줌 -->
			<div class="insert">
				<h4>사용하실 아이디를 입력해주세요.</h4>
				<input type="text" name="usr_id" placeholder="ID" required>
			</div>
			<div class="insert">
				<h4>사용하실 비밀번호를 입력해주세요.</h4>
				<input type="password" name="usr_pw" placeholder="PASSWORD" required>
			</div>
			<div class="insert">
				<h4>회원명 입력해주세요.</h4>
				<input type="text" name="usr_nm" placeholder="NAME" required>
			</div>
			<div class="insert">
				<h4>연락처를 입력해주세요.</h4>
				<input type="tel" name="usr_phone" placeholder="010-1234-5678"
					required>
			</div>
			<div class="insert">
				<h4>이메일을 입력해주세요.</h4>
				<input type="email" name="usr_email" placeholder="you@example.com"
					required>
			</div>
			<div class="signUpEx">
				<h4>※ 가입완료 후 관리자에게 권한을 요청하세요.</h4>
			</div>
			<div class="submit">
				<input type="button" id="signupBtn" value="회원가입">
			</div>
		</form>
	</div>
	<script>
	function validation(){ //사용안하는중
		var RegExp = /^[a-zA-Z0-9]{4,12}$/; //id와 pwassword 유효성 검사 정규식       
		//이메일 유효성검사        
		var e_RegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;      
		var n_RegExp = /^[가-힣]{2,15}$/; //이름 유효성검사 정규식
		var usr_id =  $("[name='usr_id']").val();
		var usr_pw = $("[name='usr_pw']").val();
		var usr_phone = $("[name='usr_phone']").val();
		var usr_email = $("[name='usr_email']").val();
	}
		
	$('#signupBtn').click(function signupCheck() {
		$('form').validate(); 
		if(!fn_check_duplicate_id()){
			alert('아이디가 중복되었습니다.');
			return;
		}
		$.ajax({
			url : '${homeUrl}signUpProc', //컨트롤러에서 요청받을 주소
			type : 'POST',
			async : false,
			data :  $('#signupUser').serialize(),
			success : function(result) { //컨트롤러에서 넘어온 cnt값을 받는다
				alert('회원가입 완료');
				location.href='${homeUrl}login';
			},
			error : function(result) {
		    	console.log(result);
		        console.log('statusCode:'+result.statusCode);
		        console.log('responseJSON:'+result.responseJSON.state);
		        console.log('responseJSON:'+result.responseJSON.msg);
		        alert('회원가입 실패');
			}
		});
	});
		
function fn_check_duplicate_id(){
	var usr_id = $('input[name=usr_id]').val();
	var checkResult = false;
	$.ajax({
		url : '/api/noAuth/idCheck', //컨트롤러에서 요청받을 주소
		type : 'POST',
		async : false,
		data : {
			'usr_id' : usr_id,
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
	</script>
</section>