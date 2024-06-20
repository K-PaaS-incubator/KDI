package org.kPaas.kdi.main.res.ds.service;

import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.springframework.http.ResponseEntity;

public interface DatasourceService extends KdiGridService {
	ResponseEntity<String> testConnection(DatasourceVo datasource_vo);

	/**
	 * 모든 데이터소스 반환
	 */
	ResponseEntity<String> getAllDsNm();
}
