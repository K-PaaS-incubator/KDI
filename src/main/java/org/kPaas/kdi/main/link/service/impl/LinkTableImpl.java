package org.kPaas.kdi.main.link.service.impl;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.link.mapper.LinkTableMapper;
import org.kPaas.kdi.main.link.service.LinkTableService;
import org.kPaas.kdi.main.link.vo.LinkDetailVo;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Service;

@Service("LinkTableService")
@DependsOn("LinkInterfaceService")
public class LinkTableImpl implements LinkTableService {

	@Resource
	private LinkTableMapper mapper;
	
	@Resource
	private DBCheckService dbCheckService;

	/**
	 * 최초 기동시에 연계서비스 테이블의 유무를 확인하고 DependsOn(명칭)<br>
	 * 해당 테이블이 없으면 연계서비스관련 테이블을 순서맞춰 생성하는 기능(테이블간의 FK관계 때문에 테이블생성순서 보장)
	 */
	@PostConstruct
	protected void init() {
		if (!dbCheckService.isExists("KDI_LINK_TABLE")) {
			mapper.createTable();
		}
	}

	// svc_id가 같은 인터페이스목록 보기
	@Override
	public List<LinkDetailVo> getDetailList(String svc_lnk_id) {
		return mapper.getDetailList(svc_lnk_id);
	}
	
	//테이블상세설정화면에서 인터페이스내용 보여주기 위한 VO
	@Override
	public LinkDetailVo getDetailVo(String svc_lnk_id,String ds_nm,String svc_id) {
		return mapper.getDetailVo(svc_lnk_id,ds_nm,svc_id);
	}
	

}
