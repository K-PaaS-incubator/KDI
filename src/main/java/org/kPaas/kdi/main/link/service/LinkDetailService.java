package org.kPaas.kdi.main.link.service;

import java.util.List;

import org.kPaas.kdi.main.link.vo.LinkServiceVo;

public interface LinkDetailService {

	public LinkServiceVo getLinkService(String svc_nm);
	public List<String> connectLinkDs(String svc_nm) ;
	

}
