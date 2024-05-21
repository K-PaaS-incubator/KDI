package org.kPaas.kdi.main.link.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.link.vo.LinkDetailVo;

@Mapper
public interface LinkTableMapper {

	// 연계서비스 테이블 생성
	public void createTable();
	
	public List<LinkDetailVo> getDetailList(String svc_id);
	
	public LinkDetailVo getDetailVo(String svc_lnk_id,String ds_nm,String svc_id);


}
