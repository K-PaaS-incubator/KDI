package org.kPaas.kdi.main.res.link.sub.service;

import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface LinkSubTblInfoService extends KdiGridService {

	ResponseEntity<String> getColumns(KdiParam mapToKdiParam);

}
