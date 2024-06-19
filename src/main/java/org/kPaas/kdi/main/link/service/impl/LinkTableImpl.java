package org.kPaas.kdi.main.link.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.kPaas.kdi.main.link.mapper.LinkTableMapper;
import org.kPaas.kdi.main.link.service.LinkTableService;
import org.kPaas.kdi.main.link.vo.LinkDetailVo;
import org.springframework.stereotype.Service;

@Service
public class LinkTableImpl implements LinkTableService {

	@Resource
	private LinkTableMapper mapper;

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
