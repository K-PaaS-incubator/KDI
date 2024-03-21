package org.kPaas.kdi.main.link.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.kPaas.kdi.com.abs.AbstractService;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.kPaas.kdi.main.link.mapper.LinkDetailMapper;
import org.kPaas.kdi.main.link.service.LinkDetailService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.stereotype.Service;

@Service
public class LinkDetailImpl extends AbstractService implements LinkDetailService {

	@Resource
	private LinkDetailMapper mapper;

	@Override
	public LinkServiceVo getLinkService(String svc_nm) {
		return mapper.getLinkService(svc_nm);
	}

	public List<String> connectLinkDs(String svc_nm) {
		DatasourceVo datasource_vo = mapper.connectLinkDs(svc_nm);
		final String orgContext = getContext();
		try {
			setContext(datasource_vo.getDs_nm());
			return mapper.getSchema();
		} finally {
			setContext(orgContext);
		}
	}

}
