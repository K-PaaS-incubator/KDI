package org.kPaas.kdi.com.tool.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface DBCheckMapper {

	Integer isExists(@Param("tableName")String tableName);

	public void createTableKDI_LINK_SERVICE();
	public void createTableKDI_LINK_DETAIL();
	public void createTableKDI_LINK_TABLE();

}
