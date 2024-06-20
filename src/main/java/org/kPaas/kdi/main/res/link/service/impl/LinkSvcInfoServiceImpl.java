package org.kPaas.kdi.main.res.link.service.impl;

import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.base.KdiGridServiceImpl;
import org.kPaas.kdi.main.res.link.mapper.LinkSvcInfoMapper;
import org.kPaas.kdi.main.res.link.service.LinkSvcInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;

/**
 * 최초 기동시에 연계서비스 테이블의 유무를 확인하고 DependsOn(명칭)<br>
 * 해당 테이블이 없으면 연계서비스관련 테이블을 순서맞춰 생성하는 기능(테이블간의 FK관계 때문에 테이블생성순서 보장)
 */
@DependsOn("DatasourceService")
@Service("LinkSvcInfoService")
public class LinkSvcInfoServiceImpl extends KdiGridServiceImpl implements LinkSvcInfoService {

	@Autowired
	private LinkSvcInfoMapper mapper;

	@Override
	protected KdiGridMapper getMapper() {
		return mapper;
	}

	@Override
	protected String getTableName() {
		return "KDI_LINK_SVC_INF";
	}

	@Override
	protected String getBizName() {
		return "연계 서비스 정보";
	}
}
