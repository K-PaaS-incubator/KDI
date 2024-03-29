package org.kPaas.kdi.main.link.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;

@Mapper
public interface LinkMapper {

	// 연계서비스 테이블 생성
	public void createTable();

	//연계서비스 조회
	public List<LinkServiceVo> selectLinkList();
	public List<LinkServiceVo> selectLinkListPage();
	
	//연계서비스 등록 시작
	public List<String> selectDsList();
	public Integer getSameLinkCheck(String svc_nm);
	public void insertLink(LinkServiceVo linkService_vo);
	
}
