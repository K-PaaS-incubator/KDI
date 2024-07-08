package org.kPaas.kdi.main.res.table.mapper;

import java.util.List;
import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;

public interface ResTableMapper {

	List<String> getSchemas();

	Long getTablesCnt(KdiParam kdiParam);

	List<Map<String, String>> getTables(KdiParam kdiParam);
}
