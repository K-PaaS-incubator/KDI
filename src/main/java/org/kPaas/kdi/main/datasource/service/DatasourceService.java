package org.kPaas.kdi.main.datasource.service;

import org.kPaas.kdi.com.util.KdiParam;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.springframework.http.ResponseEntity;

public interface DatasourceService {
	public ResponseEntity<String> getDsList(KdiParam kdiParam);

	public ResponseEntity<String> insertDS(DatasourceVo datasource_vo);

	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo);

	public DatasourceVo selectDsInfo(String ds_nm);

	public ResponseEntity<String> editDS(DatasourceVo datasource_vo);

	public Integer getSameDsCheck(String ds_nm);

	public ResponseEntity<String> delDS(String ds_nm);

}
