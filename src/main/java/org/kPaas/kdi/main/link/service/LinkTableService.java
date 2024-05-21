package org.kPaas.kdi.main.link.service;

import java.util.List;

import org.kPaas.kdi.main.link.vo.LinkDetailVo;

public interface LinkTableService {

	public List<LinkDetailVo> getDetailList(String svc_lnk_id);
	public LinkDetailVo getDetailVo(String svc_lnk_id,String ds_nm,String svc_id);

}
