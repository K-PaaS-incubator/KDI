package org.kPaas.kdi.main.res.tpi.service.impl;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.res.tpi.mapper.TransPathJmsMapper;
import org.kPaas.kdi.main.res.tpi.mapper.TransPathMapper;
import org.kPaas.kdi.main.res.tpi.service.TransPathService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class TransPathServiceImpl extends KdiGridServiceImpl implements TransPathService {

	@Resource
	private TransPathMapper mapper;

	@Resource
	private TransPathJmsMapper jmsMapper;

	public TransPathServiceImpl() {
		// default
		putStringByteLengthCheck("trnsPathId", "전송경로ID", 100);
		putStringByteLengthCheck("trnsPathNm", "전송경로명", 100);
		putEmptyValueCheck("trnsPathType", "전송경로유형");
		putStringByteLengthCheck("trnsPath", "전송경로", 2000);

		// jms
		putStringByteLengthCheck("jms", "trnsPathJmsCf", "Connection Factory", 1000);
		putEmptyValueCheck("jms", "trnsPathJmsPer", "메시지 지속성");
		putEmptyValueCheck("jms", "trnsPathJmsDest", "메시지 전송 유형");
		putStringByteLengthCheck("jms", "trnsPathJmsDestNm", "메시지 전송 유형명", 100);

		// mqtt
		// TODO MQTT 구현필요

	}

	@PostConstruct
	protected void init() {
		super.init();
		if (!isTableExists("KDI_TRNS_PATH_JMS")) {
			this.jmsMapper.createTable();
		}
// TODO MQTT 구현해야함
//		if (!isTableExists("KDI_TRNS_PATH_MQTT")) {
//			this.mapper.createJmsTable();
//		}
	}

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_TRNS_PATH";
	}

	@Override
	protected String getBizName() {
		return "전송경로정보";
	}

	@Override
	public ResponseEntity<String> insert(KdiParam kdiParam) {
		ResponseEntity<String> result = super.insert(kdiParam);
		if (HttpStatus.OK != result.getStatusCode()) {
			return result;
		}
		switch (kdiParam.getValue("trnsPathType", String.class)) {
		case "2": {
			return insert("jms", getBizName() + " JMS정보", this.jmsMapper, kdiParam);
		}
		/**
		 * // TODO Mqtt 구현해야함<br>
		 * case "3":{ return xxxx }
		 */
		case "1":
		default:
			return result;
		}
	}

	@Override
	public ResponseEntity<String> modify(KdiParam kdiParam) {
		ResponseEntity<String> result = super.modify(kdiParam);
		if (HttpStatus.OK != result.getStatusCode()) {
			return result;
		}
		switch (kdiParam.getValue("trnsPathType", String.class)) {
		case "2": {
			return modify("jms", getBizName() + " JMS정보", this.jmsMapper, kdiParam);
		}
		/**
		 * // TODO Mqtt 구현해야함<br>
		 * case "3":{ return xxxx }
		 */
		case "1":
		default:
			return result;
		}
	}

	@Override
	public ResponseEntity<String> delete(KdiParam kdiParam) {
		delete("jms", getBizName() + " JMS정보", this.jmsMapper, kdiParam);
		// TODO 향후 MQTT 구현
		// delete("mqtt", getBizName() + " MQTT정보", this.mqttMapper, kdiParam);
		return super.delete(kdiParam);
	}

	@Override
	protected Map<String, Object> selectDataProc(Map<String, Object> data) {
		if (null == data.get("TRNS_PATH_TYPE")) {
			data.put("TRNS_PATH_TYPE_NM", "미정");
			return data;
		}
		data.put("TRNS_PATH_TYPE_NM", switch (data.get("TRNS_PATH_TYPE").toString()) {
		case "1" -> "파일";
		case "2" -> "JMS";
		case "3" -> "MQTT";
		default -> "미정";
		});
		return data;
	}
}
