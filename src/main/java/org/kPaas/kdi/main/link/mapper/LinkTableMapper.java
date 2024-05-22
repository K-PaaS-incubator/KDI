package org.kPaas.kdi.main.link.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.main.link.vo.LinkDetailVo;

@Mapper
public interface LinkTableMapper {

	// 연계서비스 테이블 생성
	public void createTable();
	
	public List<LinkDetailVo> getDetailList(String svc_lnk_id);
	
	public LinkDetailVo getDetailVo(@Param("svc_lnk_id")String svc_lnk_id,@Param("ds_nm") String ds_nm,@Param("svc_id") String svc_id);


}
