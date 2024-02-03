package org.kPaas.kdi.com.tool.service.impl;

import org.kPaas.kdi.com.tool.mapper.DBCheckMapper;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DBCheckServiceImpl implements DBCheckService {
	@Autowired
	private DBCheckMapper mapper;

	/**
	 * 사용자테이블(KDI_USER) 존재유무 확인하는 기능
	 */
	@Override
	public boolean isExists(final String tableName) {
		return 0 < mapper.isExists(tableName);
	}

}
