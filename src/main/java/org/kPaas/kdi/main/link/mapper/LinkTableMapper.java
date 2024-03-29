package org.kPaas.kdi.main.link.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;

@Mapper
public interface LinkTableMapper {

	// 연계서비스 테이블 생성
	public void createTable();

	//
	public List<LinkServiceVo> selectLinkList();
	public List<LinkServiceVo> selectLinkListPage();
	
	public List<String> selectDsList();
	public Integer getSameLinkCheck(String svc_nm);
	public void insertLink(LinkServiceVo linkService_vo);

}
