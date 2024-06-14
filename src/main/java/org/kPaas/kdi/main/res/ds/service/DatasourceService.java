package org.kPaas.kdi.main.res.ds.service;

import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.springframework.http.ResponseEntity;

public interface DatasourceService {

	ResponseEntity<String> getList(KdiParam mapToKdiParam);

	ResponseEntity<String> duplicateCheck(String dsNm);

	ResponseEntity<String> insert(DatasourceVo datasource_vo);

	ResponseEntity<String> modify(DatasourceVo datasource_vo);

	DatasourceVo get(String ds_nm);
	
	ResponseEntity<String> delete(String dsNm);

	ResponseEntity<String> testConnection(DatasourceVo datasource_vo);

}
