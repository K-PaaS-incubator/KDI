package org.kPaas.kdi.main.pop.service;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface PopTableService {

	ResponseEntity<String> getSchemas(String dsNm);

	ResponseEntity<String> getTables(KdiParam mapToKdiParam);
}
