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
				<!-- 
            <li><a href=""><i class="fab fa-instagram"></i></a></li>
            <li><a href=""><i class="fab fa-facebook-f"></i></a></li>
            <li><a href=""><i class="fab fa-twitter"></i></a></li>
             -->
				<span>
					<p id="valid" class="alert alert-danger">${exception}</p>
				</span>
			</div>
			<form action="/loginProc" method="POST" id="loginform">
				<div class="login_id">
					<h4>���̵�</h4>
					<input type="text" name="usr_id" id="email" placeholder="ID">
				</div>
				<div class="login_pw">
					<h4>��й�ȣ</h4>
					<input type="password" name="usr_pw" id="password"
						placeholder="Password">
				</div>
				<div class="login_etc">
					<div class="signup">
						<a href="/signUp">ȸ������</a>
					</div>
					<div class="forgot_pw">
						<a href="/forgotPw">��й�ȣ ã��</a>
					</div>
				</div>
				<div class="submit">
					<input type="submit" value="�α���">
				</div>
			</form>
		</div>
	</div>
</body>
</html>