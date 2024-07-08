package org.kPaas.kdi.main.res.link.pub.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.base.KdiGridMapper;
import org.kPaas.kdi.com.util.KdiParam;

@Mapper
public interface LinkPubTblInfoMapper extends KdiGridMapper {

	boolean columnExists(@Param("schNm") String schemaName, @Param("tbNm") String tableName, @Param("colNm") String columnName);

	List<Map<String, Object>> getColumns(@Param("param") KdiParam kdiParam);

	void insertChild(@Param("param") Map<String, Object> childParam);

	void modifyChild(@Param("param") Map<String, Object> childParam);

}
