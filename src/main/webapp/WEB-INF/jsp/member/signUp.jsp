<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>KDI SignUp</title>
<link rel="stylesheet" href="css/signUp.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="signUp">
			<h2>ȸ������</h2>
			<div class="signUpEx">
				<span>
					<p id="valid" class="alert alert-danger">${exception}</p>
				</span>
			</div>
			<form action="/signUpProc" method="POST" id="signupUser">
				<div class="insert">
					<h4>����Ͻ� ���̵� �Է����ּ���.</h4>
					<input type="text" name="usr_id" placeholder="ID" required> 
					<span class="id_ok">��� ������ ���̵��Դϴ�.</span> 
					<span class="id_already">�ߺ� ���̵��Դϴ�!! �ٸ� ���̵� �õ����ּ���.</span>
					<button id="idbtn">ID �ߺ�Ȯ��</button>
				</div>
				<div class="insert">
					<h4>����Ͻ� ��й�ȣ�� �Է����ּ���.</h4>
					<input type="password" name="usr_pw" placeholder="PASSWORD"
						required>
				</div>
				<div class="insert">
					<h4>ȸ���� �Է����ּ���.</h4>
					<input type="text" name="usr_nm" placeholder="NAME" required>
				</div>
				<div class="insert">
					<h4>����ó�� �Է����ּ���.</h4>
					<input type="tel" name="usr_phone" placeholder="010-1234-5678"
						required>
				</div>
				<div class="insert">
					<h4>�̸����� �Է����ּ���.</h4>
					<input type="email" name="usr_email" placeholder="you@example.com"
						required>
				</div>
				<div class="signUpEx">
					<h4>�� ���ԿϷ� �� �����ڿ��� ������ ��û�ϼ���.</h4>
				</div>
				<div class="submit">
					<input type="submit" value="ȸ������">
				</div>
			</form>
		</div>
	</div>
</body>

<script>

$('#idbtn').click(function checkId(){
		var usr_id = $('input[name=usr_id]').val();
		if(usr_id != ''){
			$.ajax({
				url: "/api/noAuth/idCheck", //��Ʈ�ѷ����� ��û���� �ּ�
				type: "POST",
				data: {
					"usr_id" : usr_id,
				},
				success : function(result) { //��Ʈ�ѷ����� �Ѿ�� cnt���� �޴´�
					if(result == 0) {
						alert("��밡���� ���̵��Դϴ�.");
					} else{
						alert("�ߺ��� ���̵��Դϴ�.");
						$('input[name=usr_id]').focus();
					}
				},
				error : function(a,b,c) {
					console.log(a,b,c);
				}
			});
		}else {
			alert('���̵� �Է��ϼ���');
			$('input[name=usr_id]').focus();
		}
	});
			
</script>
</html>