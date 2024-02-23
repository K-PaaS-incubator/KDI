<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/ds.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href='${homeUrl}dsList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">데이터소스 등록</div>
		
		<form action="/ds/dsCreateProc" method="POST" id="dsCreate">
		<input type="hidden" id="ds_url" name="ds_url">
		<!-- 데이터소스명 -->
		<div class="divTitle">데이터소스 제목</div>
		<input type="text" id="ds_nm" name="ds_nm" required>
		
		<!-- DB타입-->
		<div class="divTitle">DB Type</div>
		<select name="ds_type" onchange="printName()">
			<option value="oracle">Oracle</option>
			<option value="mysql">Mysql</option>
		</select>
		
		<div class="divTitle">Server Host</div> <!-- IP주소 -->
		<input type="text" id="ds_addr"  name="ds_addr" onkeyup="printName()" placeholder="localhost" required>
		<div class="divTitle">Port</div> <!-- DB포트 -->
		<input type="number" id="ds_port" name="ds_port" onkeyup="printName()" placeholder="PORT" required>
		
		<!-- 주소와 포트 자동완성-키업사용-->
		<div class="divTitle">URL:</div><span id="ds_url_label"></span>
		<!-- Database/SID -->
		<div class="divTitle">Database</div>
		<input type="text" id="ds_sid" name="ds_sid" onkeyup="printName()" required>
		<!-- DB계정 유저명 -->
		<div class="divTitle">UserName</div>
		<input type="text" id="ds_usr_nm" name="ds_usr_nm" onkeyup="printName()" required>
		<!-- DB계정 패스워드 -->
		<div class="divTitle">Password</div>
		<input type="password" id="ds_usr_pw" name="ds`2010_usr_pw" required>
		<div id="test_result"></div>
		<div id="test_result2"></div>

		
		<!-- 커넥션 테스트 기능 -->
		<input type="button" value="테스트" id="connTestBtn">
		<input type="button" value="등록" id="regBtn">
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
	  var ds_addr = document.getElementById('ds_addr').value;
	  var ds_port = document.getElementById('ds_port').value;
	  var ds_sid = document.getElementById('ds_sid').value;
	  var ds_type = $("select[name=ds_type]").val();

	  if (ds_addr==''){
		  ds_addr = 'localhost';
		  $("#ds_addr").val('localhost');
	  }
	  if(ds_port==''){
		  ds_port = portMap[ds_type];
		  $("#ds_port").val(portMap[ds_type]);
	  }
	  document.getElementById("ds_url_label").innerText = urlMap[ds_type]+ds_addr+":"+ds_port+":"+ds_sid;
	  $("#ds_url").val(urlMap[ds_type]+ds_addr+":"+ds_port+":"+ds_sid);
	}
	
$('#regBtn').click(function databaseSave() {
	var ds_nm = document.getElementById('ds_nm').value;
	$('form').validate(); 
	 if(fn_check_duplicate_ds()){
			$('form').submit();	
			//alert("데이터소스가 등록되었습니다.");
			//location.href = "${homeUrl}dsList";
	}		
});	

function fn_check_duplicate_ds(){
	var ds_nm = $('input[name=ds_nm]').val();
	var checkResult = false;
	$.ajax({
		url : "/ds/dsCheck", //컨트롤러에서 요청받을 주소
		type : "POST",
		async : false,
		data : {
			"ds_nm" : ds_nm,
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




