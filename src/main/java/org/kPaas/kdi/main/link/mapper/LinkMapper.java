package org.kPaas.kdi.main.link.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;

@Mapper
public interface LinkMapper {
	// 기동단계에서 사용
	public List<LinkServiceVo> getLinkListAll();
	public Long getLinkListCnt(KdiParam kdiParam);
	public List<Map<String, String>> getLinkList(KdiParam kdiParam);
	
	// 연계서비스 테이블 생성
	public void createTable();

	//연계서비스 조회
	public List<LinkServiceVo> selectLinkList();
	public List<LinkServiceVo> selectLinkListPage(LinkServiceVo linkService_vo);
	public int selectLinkListCount(LinkServiceVo linkService_vo);
	
	//연계서비스 등록 시작
	public List<String> selectDsList();
	public Integer getSameLinkCheck(String svc_nm);
	public void insertLink(LinkServiceVo linkService_vo);
	
}
