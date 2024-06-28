<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}link.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<style>
div[class*='detail-'] {
	display: none;
}
</style>

<div class="mainContent">  <!-- 연계 서비스 등록 (KDI_LINK_SVC_INF)-->
	<form id="insert">
		<div class="link-wrapper">
			<div class="link-box-left">
				<div class="common-input-box">
					<div class="header6 label-title pk-title">연계서비스ID</div>
					<input class="common-input subtitle1 gray400 pk id-pattern" type="text" placeholder="영어,숫자,특수문자(@-_.)만 허용" id="SVC_ID" name="svcId" maxlength="50" required>
				</div>
				<div class="common-input-box">
					<div class="header6 label-title">연계서비스명</div>
					<input class="common-input subtitle1 gray400" type="text" placeholder="자유롭게 작성" id="SVC_NM" name="svcNm" maxlength="50" required>
				</div>
				<div class="common-input-box">
					<div class="header6 label-title">TOPIC명</div>
					<input class="common-input subtitle1 gray400 id-pattern" type="text" placeholder="영어,숫자,특수문자(@-_.)만 허용" id="TP_NM" name="tpNm" maxlength="50" required>
				</div>
			</div>

			<div class="link-box-right">
				<div class="common-input-box">
					<div class="header6 label-title">연계서비스 구분</div>
					<div class="link-radio-box">
						<label class="subtitle1 gray400"><input type="radio" name="svcType" value="P" checked="checked">송신</label> <label class="subtitle1 gray400"><input
							type="radio" name="svcType" value="S">수신</label>
					</div>
				</div>
				<div class="common-input-box">
					<div class="header6 label-title">데이터소스 선택</div>
					<select class="link-input subtitle1 gray400" id="DS_NM" name="dsNm">
						<option selected disabled>로딩중...</option>
					</select>
				</div>
			</div>
		</div>

		<div class="link-button-box">
			<input class="button-second-gray" type="button" value="취소" onclick="location.href='${linkUrl}'">
			<input class="button-primary" type="button" value="연계서비스 등록 >" id="regbtn">
		</div>
	</form>
</div>
<div style="display: none;">
	<select id="DS_NM_FORMAT">
		<option value="#DS_NM#">#DS_NM#</option>
	</select>
</div>

<script>
	const fn_load_ds_nm = function() {
		const dsNmFormat = $('#DS_NM_FORMAT').html();
		$('#DS_NM').html('');
		$.each(KdiData().getAllDataSourceName(), function(idx, dsNm) {
			$('#DS_NM').append(dsNmFormat.replaceAll('#DS_NM#', dsNm));
		});
	};
	$(document).ready(function() {
		fn_insert_page_load('연계서비스', '연계서비스');
		fn_load_ds_nm();
	});
</script>