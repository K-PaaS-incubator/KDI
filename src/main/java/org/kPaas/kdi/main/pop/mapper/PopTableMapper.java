package org.kPaas.kdi.main.pop.mapper;

import java.util.List;
import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;

public interface PopTableMapper {

	List<String> getSchemas();

	Long getTablesCnt(KdiParam kdiParam);

	List<Map<String, String>> getTables(KdiParam kdiParam);

}
