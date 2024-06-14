package org.kPaas.kdi.main.res.si.service.impl;

import javax.annotation.Resource;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.si.mapper.SvcInfoMapper;
import org.kPaas.kdi.main.res.si.service.SvcInfoService;
import org.springframework.stereotype.Service;

@Service
public class SvcInfoServiceImpl extends KdiGridServiceImpl implements SvcInfoService {

	@Resource
	private SvcInfoMapper mapper;

	public SvcInfoServiceImpl() {
		putStringByteLengthCheck("svcId", "서비스ID", 100);
		putStringByteLengthCheck("svcNm", "서비스명", 100);
		putEmptyValueCheck("svcType", "서비스유형");
		putStringByteLengthCheck("dsNm", "데이터소스명", 100);
		putStringByteLengthCheck("tpiId", "전송경로정보ID", 100);
	}

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_SVC_INFO";
	}

	@Override
	protected String getBizName() {
		return "서비스정보";
	}

}
