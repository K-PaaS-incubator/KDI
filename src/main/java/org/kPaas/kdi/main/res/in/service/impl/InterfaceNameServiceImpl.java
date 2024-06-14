package org.kPaas.kdi.main.res.in.service.impl;

import javax.annotation.Resource;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.in.mapper.InterfaceNameMapper;
import org.kPaas.kdi.main.res.in.service.InterfaceNameService;
import org.springframework.stereotype.Service;

@Service
public class InterfaceNameServiceImpl extends KdiGridServiceImpl implements InterfaceNameService {

	@Resource
	private InterfaceNameMapper mapper;

	public InterfaceNameServiceImpl() {
		putStringByteLengthCheck("ifId", "인터페이스ID", 100);
		putStringByteLengthCheck("ifNm", "인터페이스명", 100);
	}

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_INTERFACE_NM";
	}

	@Override
	protected String getBizName() {
		return "인터페이스명";
	}
}
