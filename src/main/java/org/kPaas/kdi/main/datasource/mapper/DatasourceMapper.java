package org.kPaas.kdi.main.datasource.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.datasource.dto.DatasourceVo;

@Mapper
public interface DatasourceMapper {
	
	//데이터소스 정보 저장
	public void insertDS(DatasourceVo datasource_vo);
	
	//데이터소스 테이블 생성
	public void createTable();

}
