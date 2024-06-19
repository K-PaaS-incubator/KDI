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
	 * 테이블 존재유무 확인하는 기능
	 */
	@Override
	public boolean isExists(final String tableName) {
		return 0 < mapper.isExists(tableName);
	}
	
	/**
	 * DatasourceServiceImpl.java 실행 시 한번에 검증 후 한번에 생성 (각 테이블의 FK관계떄문)
	 */

	public void createTableKDI_LINK_SERVICE() {
		mapper.createTableKDI_LINK_SERVICE();
	}
	public void createTableKDI_LINK_DETAIL() {
		mapper.createTableKDI_LINK_DETAIL();
	}
	public void createTableKDI_LINK_TABLE() {
		mapper.createTableKDI_LINK_TABLE();
	}
	
}
