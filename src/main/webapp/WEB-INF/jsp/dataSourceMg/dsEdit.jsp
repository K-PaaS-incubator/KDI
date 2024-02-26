<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css" />
<link rel="stylesheet" href="${cssUrl}/ds.css">

<section class="contents">

	<div class="sideMenu">
		<div onclick="location.href=${homeUrl}dsList'">데이터소스 조회</div>
	</div>

	<div class="mainContent">
		<div id="pageTitle">데이터소스 수정</div>
		
		<form id="dsEdit" onsubmit="return false;">
		<input type="hidden" id="ds_url" name="ds_url"  value="${selectDsInfo.ds_url}" >
		<!-- 데이터소스명 -->
		<div class="divTitle">데이터소스 제목</div>
		<label id="ds_nm">${selectDsInfo.ds_nm}</label>
		<input type="hidden" id="ds_nm" name="ds_nm"  value="${selectDsInfo.ds_nm}" >
		<!-- DB타입-->
		<div class="divTitle">DB Type</div>
		<label id="ds_type">${selectDsInfo.ds_type}</label>
		<input type="hidden" name="ds_type"  value="${selectDsInfo.ds_type}" >
		
		<div class="divTitle">Server Host</div> <!-- IP주소 -->
		<input type="text" id="ds_addr" name="ds_addr" value="${selectDsInfo.ds_addr}" onkeyup="printName()">
		<div class="divTitle">Port</div> <!-- DB포트 -->
		<input type="number" id="ds_port" name="ds_port" value="${selectDsInfo.ds_port}" onkeyup="printName()" >
		
		<!-- 주소와 포트 자동완성-키업사용-->
		<div class="divTitle">URL:</div><span id="ds_url_label"></span>
		<!-- Database/SID -->
		<div class="divTitle">Database</div>
		<input type="text" id="ds_sid" name="ds_sid" value="${selectDsInfo.ds_sid}" onkeyup="printName()"  required>
		<!-- DB계정 유저명 -->
		<div class="divTitle">UserName</div>
		<input type="text" id="ds_usr_nm" name="ds_usr_nm" onkeyup="printName()"  required>
		<!-- DB계정 패스워드 -->
		<div class="divTitle">Password</div>
		<input type="password" id="ds_usr_pw" name="ds_usr_pw" required>
		<div id="test_result"></div>
		<div id="test_result2"></div>
		
		<!-- 커넥션 테스트 기능 -->
		<input type="button" value="테스트" id="connTestBtn">
		<input type="button" value="수정" id="modifyBtn">
		<input type="button" value="삭제" id="deleteBtn">
		</form>
	</div>
	
<script>
const ds_url ='${selectDsInfo.ds_url}';
const urlMap = {
	    oracle: 'jdbc:oracle:thin:@',
	    mysql: 'jdbc:mysql://'
	  };

$( document ).ready(function() {
	printName();
	$('#ds_url_label').text(ds_url);
});

function printName()  {
	  var ds_addr = $('#ds_addr').val();
	  var ds_port = $('#ds_port').val();
	  var ds_sid = $('#ds_sid').val();
	  var urlDriver = null;
		if(ds_url.includes('oracle')){
			urlDriver=urlMap['oracle'];
		}else if(ds_url.includes('mysql')){
			urlDriver=urlMap['mysql'];
		}
	  $('#ds_url_label').text(urlDriver+ds_addr+':'+ds_port+':'+ds_sid);
	  $('#ds_url').val(urlDriver+ds_addr+':'+ds_port+':'+ds_sid);
	}
	
$('#modifyBtn').click(function databaseSave() {
	$('form').validate();
	$.ajax({
	    url : '/ds/dsEditProc',
		type : 'POST',
		data : $('form').serialize(),
	    dataType : 'JSON',
	    success : function(result) {
	        console.log('result:'+result.state);
	        location.href = '${homeUrl}dsList';
	    },
	    error : function(result) {
	        console.log('statusCode:'+result.statusCode);
	        console.log('responseJSON:'+result.responseJSON.state);
	        console.log('responseJSON:'+result.responseJSON.msg);
	        alert('데이터소스 등록 실패');
		}
	});
});	
	
$('#connTestBtn').click(function databaseCheck() {
	$('form').validate(); 
	$.ajax({
	    url : '/ds/testConnection',
		type : 'POST',
		data : $('form').serialize(),
	    dataType : 'JSON',
	    success : function(result) {
	        console.log('result:'+result.state);
	        $('#test_result').text('접속 테스트 성공');
	    },
	    error : function(result) {
	        console.log('statusCode:'+result.statusCode);
	        console.log('responseJSON:'+result.responseJSON.state);
	        console.log('responseJSON:'+result.responseJSON.msg);
	        $('#test_result').text('접속 테스트 실패');
	        $('#test_result2').text(result.responseJSON.msg);
		}
	});
});


$('#deleteBtn').click(function databaseDel() {
	if(confirm('데이터소스를 삭제하시겠습니까?')){
		$.ajax({
		    url : '/ds/dsDelProc',
			type : 'POST',
			data : $('form').serialize(),
		    dataType : 'JSON',
		    success : function(result) {
		        console.log('result:'+result.state);
		        $('form').submit();
		        location.href = '${homeUrl}dsList';
		        alert('정상적으로 삭제되었습니다.');
		    },
		    error : function(result) {
		    	console.log(result);
		        console.log('statusCode:'+result.statusCode);
		        console.log('responseJSON:'+result.responseJSON.state);
		        console.log('responseJSON:'+result.responseJSON.msg);
		        alert('데이터소스 삭제 실패');
			}
		});		
	}else{
		alert('삭제 취소');
	}
	
});
</script>

</section>




