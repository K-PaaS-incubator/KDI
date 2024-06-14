package org.kPaas.kdi.main.res.in.service;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface InterfaceNameService {

	ResponseEntity<String> get(String ifId);

	ResponseEntity<String> getList(KdiParam mapToKdiParam);

	ResponseEntity<String> duplicateCheck(String ifId);

	ResponseEntity<String> insert(String ifId, String ifNm);

	ResponseEntity<String> modify(String ifId, String orgIfId, String ifNm);

	ResponseEntity<String> delete(String ifId);

}
