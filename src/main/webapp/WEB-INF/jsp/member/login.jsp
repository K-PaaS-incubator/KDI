<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Login</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="wrap">
		<div class="login">
			<h2>KDI Log-in</h2>
			<div class="login_sns">
				<span>
					<p id="valid" class="alert alert-danger">${exception}</p>
				</span>
			</div>
			<form action="/loginProc" method="POST" id="loginform">
				<div class="login_id">
					<h4>아이디</h4>
					<input type="text" name="usr_id" id="email" placeholder="ID">
				</div>
				<div class="login_pw">
					<h4>비밀번호</h4>
					<input type="password" name="usr_pw" id="password"
						placeholder="Password">
				</div>
				<div class="login_etc">
					<div class="signup">
						<a href="/signUp">회원가입</a>
					</div>
					<div class="forgot_pw">
						<a href="/forgotPw">비밀번호 찾기</a>
					</div>
				</div>
				<div class="submit">
					<input type="submit" value="로그인">
				</div>
			</form>
		</div>
	</div>
</body>
</html>