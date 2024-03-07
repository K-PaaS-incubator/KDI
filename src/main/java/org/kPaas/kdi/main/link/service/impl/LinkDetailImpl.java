package org.kPaas.kdi.main.link.service.impl;

import javax.annotation.Resource;
import org.kPaas.kdi.main.link.mapper.LinkDetailMapper;
import org.kPaas.kdi.main.link.service.LinkDetailService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.stereotype.Service;

@Service
public class LinkDetailImpl implements LinkDetailService {

	@Resource
	private LinkDetailMapper mapper;

	@Override
	public LinkServiceVo getLinkService(String svc_nm) {
		return mapper.getLinkService(svc_nm);
	}
	
}
