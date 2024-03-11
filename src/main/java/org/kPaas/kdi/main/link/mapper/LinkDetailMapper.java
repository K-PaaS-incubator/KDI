package org.kPaas.kdi.main.link.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;

@Mapper
public interface LinkDetailMapper {

	public LinkServiceVo getLinkService(String svc_nm);
	
	public DatasourceVo connectLinkDs(String svc_nm);


}
