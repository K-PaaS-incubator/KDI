package org.kPaas.kdi.com.base;

import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface KdiGridService {
	ResponseEntity<String> get(KdiParam mapToKdiParam);

	ResponseEntity<String> getList(KdiParam mapToKdiParam);

	ResponseEntity<String> duplicateCheck(KdiParam mapToKdiParam);

	ResponseEntity<String> insert(KdiParam mapToKdiParam);

	ResponseEntity<String> modify(KdiParam mapToKdiParam);

	ResponseEntity<String> delete(KdiParam mapToKdiParam);
}
