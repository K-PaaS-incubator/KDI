package org.kPaas.kdi.main.link.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LinkTableMapper {

	// 연계서비스 테이블 생성
	public void createTable();


}
