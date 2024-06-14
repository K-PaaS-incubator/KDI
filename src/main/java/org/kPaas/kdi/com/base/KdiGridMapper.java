package org.kPaas.kdi.com.base;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.util.KdiParam;

public interface KdiGridMapper {
	public void createTable();

	Long getListCnt(@Param("param") KdiParam mapToKdiParam);

	List<Map<String, Object>> getList(@Param("param") KdiParam mapToKdiParam);

	void insert(@Param("param") KdiParam kdiParam);

	int duplicateCheck(@Param("param") KdiParam kdiParam);

	Map<String, Object> get(@Param("param") KdiParam kdiParam);

	void modify(@Param("param") KdiParam kdiParam);

	void delete(@Param("param") KdiParam kdiParam);

}
