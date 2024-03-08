package org.kPaas.kdi.main.link.service;

import java.util.List;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;

public interface LinkService {

	public List<LinkServiceVo> selectLinkList();

	//연계서비스 등록 시작
	public List<String> selectDsList();
	public Integer getSameLinkCheck(String svc_nm);
	public ResponseEntity<String> insertLink(LinkServiceVo linkService_vo);

}