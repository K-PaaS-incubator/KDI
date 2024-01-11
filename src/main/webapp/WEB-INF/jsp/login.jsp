<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="wrap">
        <div class="login">
            <h2>Log-in</h2>
            <div class="login_sns">
            <li><a href=""><i class="fab fa-instagram"></i></a></li>
            <li><a href=""><i class="fab fa-facebook-f"></i></a></li>
            <li><a href=""><i class="fab fa-twitter"></i></a></li>
            </div>
            <form action="/loginProc" method="POST">
            <div class="login_id">
                <h4>E-mail</h4>
                <input type="text" name="email" id="email">
            </div>
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="password" id="password" placeholder="Password">
            </div>
            <div class="login_etc">
                <div class="checkbox">
                <input type="checkbox" name="" id=""> Remember Me?
                </div>
                <div class="forgot_pw">
                <a href="">Forgot Password?</a>
            </div>
            </div>
            <span>
					<p id="valid" class="alert alert-danger">${exception}</p>
           </span>

            <div class="submit">
                <input type="submit" value="submit">
            </div>
            </form>
        </div>
    </div>
</body>
</html>