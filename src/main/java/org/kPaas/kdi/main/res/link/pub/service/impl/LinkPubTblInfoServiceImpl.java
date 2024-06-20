package org.kPaas.kdi.main.res.link.pub.service.impl;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.link.pub.mapper.LinkPubTblInfoMapper;
import org.kPaas.kdi.main.res.link.pub.service.LinkPubTblInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;

@Service("LinkPubTblInfoService")
@DependsOn("PubLinkDetailInfoService")
public class LinkPubTblInfoServiceImpl extends KdiGridServiceImpl implements LinkPubTblInfoService {

	@Autowired
	private LinkPubTblInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_PUB_TBL_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 송신업무 테이블 정보";
	}
}
