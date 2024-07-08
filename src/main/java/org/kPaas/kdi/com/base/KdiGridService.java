package org.kPaas.kdi.com.base;

import java.util.List;
import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface KdiGridService {
	ResponseEntity<String> get(KdiParam mapToKdiParam);

	ResponseEntity<String> getList(KdiParam mapToKdiParam);

	ResponseEntity<String> duplicateCheck(KdiParam mapToKdiParam);

	ResponseEntity<String> insert(KdiParam mapToKdiParam);

	ResponseEntity<String> modify(KdiParam mapToKdiParam);

	ResponseEntity<String> delete(KdiParam mapToKdiParam);

	Map<String, Object> getData(KdiParam kdiParam) throws Exception;

	public List<Map<String, Object>> getListData(KdiParam kdiParam) throws Exception;
}
