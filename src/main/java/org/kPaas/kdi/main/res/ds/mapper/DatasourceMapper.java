package org.kPaas.kdi.main.res.ds.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;

@Mapper
public interface DatasourceMapper extends KdiGridMapper {
	// 기동단계에서 사용
	public List<DatasourceVo> getDsListAll();

	public String validationQuery(@Param("dsType") String ds_type);
}
