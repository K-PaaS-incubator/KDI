package org.kPaas.kdi.main.link.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;

@Mapper
public interface LinkMapper {
	// 연계서비스 테이블 생성
	public void createTable();

	public Long getLinkListCnt(KdiParam kdiParam);

	public List<Map<String, String>> getLinkList(KdiParam kdiParam);

	// 연계서비스 조회
	public List<LinkServiceVo> selectLinkList();

	// 연계서비스 등록 시작
	public List<String> selectDsList();

	public Integer getSameLinkCheck(String svc_nm);

	public void insertLink(LinkServiceVo linkService_vo);

	public void lnkDel(Map<String, Object> params);

	// public List<LinkServiceVo> getLinkListAll();
	// public List<LinkDetailVo> getInterfaceList(String svc_nm);
	// public List<LinkServiceVo> selectLinkListPage(LinkServiceVo linkService_vo);
	//public int selectLinkListCount(LinkServiceVo linkService_vo);
}
