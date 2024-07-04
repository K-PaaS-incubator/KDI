package org.kPaas.kdi.main.res.link.pub.service;

import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.com.util.KdiParam;
import org.springframework.http.ResponseEntity;

public interface LinkPubTblInfoService extends KdiGridService {

	ResponseEntity<String> getColumns(KdiParam mapToKdiParam);

}
