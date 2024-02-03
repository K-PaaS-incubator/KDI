<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/userInfo.css">

<div class="contents">

		<div class="menuBox">
			<div class="menuBar" onclick="location.href='/dsList'">�����ͼҽ�</div>
			<div class="menuBar" onclick="location.href='/linkList'" >����</div>
			<div class="menuBar" onclick="location.href='/monitorList'">����͸�</div>
			<div class="menuBar" onclick="location.href='/userInfo'">����ڰ���</div>	<!-- �������� ���� -->
			<div class="menuBar" onclick="location.href='/main'">What's KDI</div>
		</div>

		<div class="sideMenu">
			<div>����� ���� ��ȸ</div>
			<div>����� ���� ����</div>
		</div>
		
		<div class="mainContent">
			<div id="pageTitle">����� ���� ����</div>
			<div class="usrInfoBox">
				<div class="usrInfo">
					<h4>���̵�</h4><span>${userInfo.usr_id}</span>
				</div>
				<div class="usrInfo">
					<h4>ȸ����</h4>
					<input type="text" name="usr_nm" placeholder="${userInfo.usr_nm}">
				</div>
				<div class="usrInfo">
					<h4>����ó</h4>
					<input type="tel" name="usr_phone" placeholder="${userInfo.usr_phone}">
				</div>
				<div class="usrInfo">
					<h4>�̸���</h4>
					<input type="email" name="usr_email" placeholder="${userInfo.usr_email}">
				</div>
			</div>
			<button id="saveBtn">����</button>
		</div>
	
</div>

 