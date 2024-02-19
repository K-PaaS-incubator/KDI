<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='/ds/dsList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">데이터소스 등록</div>
		<form action="/ds/dsCreateProc" method="POST" id="dsCreate">
		<input type="hidden" id="ds_url" name="ds_url">
		<!-- 데이터소스명 -->
		<div>데이터소스 제목</div>
		<input type="text" id="ds_nm" name="ds_nm" required>
		<button>데이터소스 중복 체크</button>
		
		<!-- DB타입-->
		<div>DB Type</div>
		<select name="ds_type" onchange="printName()">
			<option value="oracle">Oracle</option>
			<option value="mysql">Mysql</option>
		</select>
		
		<div>Server Host</div> <!-- IP주소 -->
		<input type="text" id="dbHost" onkeyup="printName()" placeholder="localhost">
		<div>Port</div> <!-- DB포트 -->
		<input type="number" id="dbPort" onkeyup="printName()" placeholder="PORT">
		
		<!-- 주소와 포트 자동완성-키업사용-->
		<div>URL:</div><span id="ds_url_label"></span>
		<!-- Database/SID -->
		<div>Database</div>
		<input type="text" id="ds_sid" name="ds_sid" onkeyup="printName()"  required>
		<!-- DB계정 유저명 -->
		<div>UserName</div>
		<input type="text" id="ds_usr_nm" name="ds_usr_nm" onkeyup="printName()"  required>
		<!-- DB계정 패스워드 -->
		<div>Password</div>
		<input type="password" id="ds_usr_pw" name="ds_usr_pw" required>
		<div id="test_result"></div>
		<div id="test_result2"></div>
		
		<!-- 커넥션 테스트 기능 -->
		<input type="button" value="연결테스트" id="connTestBtn">
		<input type="button" value="접속정보등록" id="regBtn">
		</form>
	</div>
	
<script>
$( document ).ready(function() {
	printName();
});
const portMap = {
	    oracle: '1521',
	    mysql: '3306',
	    postgres: '5432',
	    mssql: '1433'
	  };
const urlMap = {
	    oracle: 'jdbc:oracle:thin:@',
	    mysql: 'jdbc:mysql://'
	  };
	  
function printName()  {
	  var dbHost = document.getElementById('dbHost').value;
	  var dbPort = document.getElementById('dbPort').value;
	  var ds_sid = document.getElementById('ds_sid').value;
	  var ds_type = $("select[name=ds_type]").val();

	  if (dbHost==''){
		  dbHost = 'localhost';
	  }
	  if(dbPort==''){
		  dbPort = portMap[ds_type];
	  }
	  document.getElementById("ds_url_label").innerText = urlMap[ds_type]+dbHost+":"+dbPort+":"+ds_sid;
	  $("#ds_url").val(urlMap[ds_type]+dbHost+":"+dbPort+":"+ds_sid);
	}
	
$('#regBtn').click(function databaseCheck() {
	$('form').validate(); 
	
	$('form').submit();
});	
	
$('#connTestBtn').click(function databaseCheck() {
	$('form').validate(); 
	$.ajax({
	    url : "/ds/testConnection",
		type : "POST",
		data : $("form").serialize(),
	    dataType : "JSON",
	    success : function(result) {
	        console.log("result:"+result.state);
	        document.getElementById("test_result").innerText = '접속 테스트 성공';
	        document.getElementById("test_result2").innerText = '';
	    },
	    error : function(result) {
	        console.log("statusCode:"+result.statusCode);
	        console.log("responseJSON:"+result.responseJSON.state);
	        console.log("responseJSON:"+result.responseJSON.msg);
	        document.getElementById("test_result").innerText = '접속 테스트 실패';
	        document.getElementById("test_result2").innerText = result.responseJSON.msg;
		}
	});
});
</script>

</section>




