package org.kPaas.kdi.main.res.link.sub.service.impl;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.link.sub.mapper.LinkSubInfoMapper;
import org.kPaas.kdi.main.res.link.sub.service.LinkSubInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;

@DependsOn("LinkSvcInfoService")
@Service("SubLinkDetailInfoService")
public class LinkSubInfoServiceImpl extends KdiGridServiceImpl implements LinkSubInfoService {

	@Autowired
	private LinkSubInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_SUB_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 수신업무 정보";
	}
}
