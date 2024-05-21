package org.kPaas.kdi.main.link.service;

import java.util.List;

import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.link.vo.LinkDetailVo;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;

public interface LinkService {
	public ResponseEntity<String> getLinkList(KdiParam kdiParam);
	public List<LinkServiceVo> selectLinkList();
	public List<LinkServiceVo> selectLinkListPage(LinkServiceVo linkService_vo);
	public int selectLinkListCount(LinkServiceVo linkService_vo);

	//연계서비스 등록 시작
	public List<String> selectDsList();
	public Integer getSameLinkCheck(String svc_nm);
	public ResponseEntity<String> insertLink(LinkServiceVo linkService_vo);
	
	public List<LinkDetailVo> getInterfaceList(String svc_nm);

}
