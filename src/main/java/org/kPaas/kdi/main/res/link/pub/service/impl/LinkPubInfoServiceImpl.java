package org.kPaas.kdi.main.res.link.pub.service.impl;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.link.pub.mapper.LinkPubInfoMapper;
import org.kPaas.kdi.main.res.link.pub.service.LinkPubInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;

@DependsOn("LinkSvcInfoService")
@Service("PubLinkDetailInfoService")
public class LinkPubInfoServiceImpl extends KdiGridServiceImpl implements LinkPubInfoService {

	@Autowired
	private LinkPubInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_PUB_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 송신업무 정보";
	}
}
