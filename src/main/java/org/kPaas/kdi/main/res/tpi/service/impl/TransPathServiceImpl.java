package org.kPaas.kdi.main.res.tpi.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.tpi.mapper.TransPathMapper;
import org.kPaas.kdi.main.res.tpi.service.TransPathService;
import org.springframework.stereotype.Service;

@Service
public class TransPathServiceImpl extends KdiGridServiceImpl implements TransPathService {

	@Resource
	private TransPathMapper mapper;

	public TransPathServiceImpl() {
		putStringByteLengthCheck("trnsPathId", "전송경로ID", 100);
		putStringByteLengthCheck("trnsPathNm", "전송경로명", 100);
		putEmptyValueCheck("trnsPathType", "전송경로유형");
		putStringByteLengthCheck("trnsPath", "전송경로", 2000);
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
