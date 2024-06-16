<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="cssUrl" value="/css/" />
<c:url var="jsUrl" value="/js/" />
<link rel="stylesheet" href="${cssUrl}ds.css">
<script src="${jsUrl}kdi/kdi-grid-option.js"></script>
<style>
div[class*='detail-'] {
	display: none;
}
</style>

<div class="mainContent">
	<form id="modify" onsubmit="return false;">
		<input style="display: none;" type="text" id="pk" name="orgTrnsPathId">
		<div class="ds-wrapper">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title pk-title">전송경로 ID</div>
					<input class="ds-input subtitle1 gray400 pk id-pattern" type="text" id="TRNS_PATH_ID" name="trnsPathId" maxlength="33" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로 유형</div>
					<select class="ds-input subtitle1 gray400" id="TRNS_PATH_TYPE" name="trnsPathType">
						<option value="1">파일</option>
						<option value="2">JMS</option>
						<option value="3">MQTT</option>
					</select>
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로명</div>
					<input class="ds-input subtitle1 gray400" type="text" id="TRNS_PATH_NM" name="trnsPathNm" maxlength="33" required>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">전송경로</div>
					<input class="ds-input subtitle1 gray400" type="text" id="TRNS_PATH" name="trnsPath" maxlength="1000" required>
				</div>
			</div>
		</div>
		<div class="ds-wrapper detail-jms">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">Connection Factory</div>
					<input class="ds-input subtitle1 gray400" type="text" id="TRNS_PATH_JMS_CF" name="trnsPathJmsCf" maxlength="1000"
						placeholder="com.nguru.mq2.jms.NConnectionFactory">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">메시지 전송 유형</div>
					<select class="ds-input subtitle1 gray400" id="TRNS_PATH_JMS_DEST" name="trnsPathJmsDest">
						<option value="1">TOPIC</option>
						<option value="2">QUEUE</option>
					</select>
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">메시지 지속성</div>
					<select class="ds-input subtitle1 gray400" id="TRNS_PATH_JMS_PER" name="trnsPathJmsPer">
						<option value="TRUE">사용</option>
						<option value="FALSE">미사용</option>
					</select>
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">메시지 전송 유형명</div>
					<input class="ds-input subtitle1 gray400 id-pattern" type="text" id="TRNS_PATH_JMS_DEST_NM" name="trnsPathJmsDestNm" maxlength="100">
				</div>
			</div>
		</div>

		<div class="ds-wrapper detail-mqtt">
			<div class="ds-box-left">
				<div class="ds-input-box">
					<div class="header6 label-title">MQTT세부설정 향후 구현필요</div>
					<input class="ds-input subtitle1 gray400" type="text" id="TRNS_PATH_MQTT_CF" name="trnsPathMqttCf" maxlength="33">
				</div>
				<div class="ds-input-box">
					<div class="header6 label-title">메시지 업무명</div>
					<input class="ds-input subtitle1 gray400" type="text" id="TRNS_PATH_MQTT_NM" name="trnsPathMqttNm" maxlength="33">
				</div>
			</div>
			<div class="ds-box-right">
				<div class="ds-input-box">
					<div class="header6 label-title">메시지 지속성</div>
					<select class="ds-input subtitle1 gray400" id="TRNS_PATH_MQTT_PER" name="trnsPathMqttPer">
						<option value="TRUE">사용</option>
						<option value="FALSE">미사용</option>
					</select>
				</div>
			</div>
		</div>
		<div class="ds-button-box">
			<div>
				<input class="button-second" type="button" value="수정" id="modifyBtn">
			</div>
			<div>
				<input class="button-second-gray" type="button" value="삭제" id="deleteBtn"> <input class="button-second-gray" type="button" value="이전"
					id="previousBtn">
			</div>
		</div>
	</form>
</div>
<script>
	const dtlName = 'trnsPathType';
	const trnsPathTypeMapping = {
		2 : 'jms',
		3 : 'mqtt'
	};
	$(document).ready(function() {
		dtlDispEvent = fn_detail_display_event(dtlName, trnsPathTypeMapping);
		const postEvent = [ dtlDispEvent.select ];
		fn_modify_page_load('자원관리', '전송경로 정보', postEvent);
	});
</script>
