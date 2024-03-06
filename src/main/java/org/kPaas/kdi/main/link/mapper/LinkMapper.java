package org.kPaas.kdi.main.link.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;

@Mapper
public interface LinkMapper {

	// 연계서비스 테이블 생성
	public void createTable();

	//연계서비스 조회
	public List<LinkServiceVo> selectLinkList();
	
}
