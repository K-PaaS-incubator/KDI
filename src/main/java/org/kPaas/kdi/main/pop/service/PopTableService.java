package org.kPaas.kdi.main.pop.service;

import java.util.Map;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface PopTableService {

	ResponseEntity<String> getSchemas(String ds_nm);

	ResponseEntity<String> getTables(KdiParam mapToKdiParam);

	ResponseEntity<String> editIF_SvcDs(Map<String, Object> params);
}
