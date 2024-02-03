<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KDI SignUp</title>
<link rel="stylesheet" href="css/signUp.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="signUp">
			<h2>회원가입</h2>
			<div class="signUpEx">
				<span>
					<p id="valid" class="alert alert-danger">${exception}</p>
				</span>
			</div>
			<form action="/signUpProc" method="POST" id="signupUser">
				<div class="insert">
					<h4>사용하실 아이디를 입력해주세요.</h4>
					<input type="text" name="usr_id" placeholder="ID" required>
					<span class="id_ok">사용 가능한 아이디입니다.</span> <span class="id_already">중복
						아이디입니다!! 다른 아이디를 시도해주세요.</span>
					<button id="idbtn">ID 중복확인</button>
				</div>
				<div class="insert">
					<h4>사용하실 비밀번호를 입력해주세요.</h4>
					<input type="password" name="usr_pw" placeholder="PASSWORD"
						required>
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
					<input type="submit" value="회원가입">
				</div>
			</form>
		</div>
	</div>
</body>

<script>
	$('#idbtn').click(function checkId() {
		var usr_id = $('input[name=usr_id]').val();
		if (usr_id != '') {
			$.ajax({
				url : "/api/noAuth/idCheck", //컨트롤러에서 요청받을 주소
				type : "POST",
				data : {
					"usr_id" : usr_id,
				},
				success : function(result) { //컨트롤러에서 넘어온 cnt값을 받는다
					if (result == 0) {
						alert("사용가능한 아이디입니다.");
					} else {
						alert("중복된 아이디입니다.");
						$('input[name=usr_id]').focus();
					}
				},
				error : function(a, b, c) {
					console.log(a, b, c);
				}
			});
		} else {
			alert('아이디를 입력하세요');
			$('input[name=usr_id]').focus();
		}
	});
</script>
</html>