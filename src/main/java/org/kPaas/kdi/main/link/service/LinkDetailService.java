package org.kPaas.kdi.main.link.service;

import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.http.ResponseEntity;

public interface LinkDetailService {

	public LinkServiceVo getLinkService(String svc_nm);
	public ResponseEntity<String> connectLinkDs(String svc_nm) ;
	

}
