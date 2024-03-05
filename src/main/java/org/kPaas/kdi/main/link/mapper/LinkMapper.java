package org.kPaas.kdi.main.link.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;

@Mapper
public interface LinkMapper {

	// 데이터소스 테이블 생성
	public void createTable();

	public List<String> selectDsList();

}
