package org.kPaas.kdi.main.res.table.service;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface ResTableService {

	ResponseEntity<String> getSchemas(String dsNm);

	ResponseEntity<String> getTables(KdiParam mapToKdiParam);
}
