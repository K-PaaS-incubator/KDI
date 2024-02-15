<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='/dsList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">데이터소스 관리</div>
		<form action="/create" method="POST" id="dsCreate" onsubmit="return false;">
		<!-- 데이터소스명 -->
		<div>데이터소스 제목</div>
		<input type="text">
		<button>데이터소스 중복 체크</button>
		
		<!-- DB타입-->
		<div>DB Type</div>
		<select name="dbType">
			<option value="Oracle">Oracle</option>
			<option value="Mysql">Mysql</option>
		</select>
		
		<div>Server Host</div> <!-- IP주소 -->
		<input type="text" id="dbHost" onkeyup="printName()" placeholder="localhost">
		<div>Port</div> <!-- DB포트 -->
		<input type="number" id="dbPort" onkeyup="printName()" placeholder="PORT">
		
		<!-- 주소와 포트 자동완성-키업사용-->
		<div>URL:</div><span id="jdbcDriver"></span><span id="fullUrl"></span>		
		<!-- DB계정 유저명 -->
		<div>UserName</div>
		<input type="text" id="dbUser" onkeyup="printName()" >
		<!-- DB계정 패스워드 -->
		<div>Password</div>
		<input type="text">
		
		<!-- 커넥션 테스트 기능 -->
		<button>Test Connection</button>
		<input type="submit" value="Apply">
		</form>
	</div>
	
<script>

function printName()  {
	  var dbHost = document.getElementById('dbHost').value;
	  var dbPort = document.getElementById('dbPort').value;
	  var dbType = $("select[name=dbType]").val();
	  const dbUser = document.getElementById('dbUser').value;

	  if (dbHost==''){
		  dbHost = 'localhost';
	  }
	  if(dbPort==''){
		  dbPort = '1521';
	  }
	  document.getElementById("fullUrl").innerText = "jdbc:oracle:thin:@"+dbHost+":"+dbPort+":"+dbUser;
	}

</script>

</section>




