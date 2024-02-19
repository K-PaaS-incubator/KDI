package org.kPaas.kdi.main.datasource.service;

import java.util.List;

import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.springframework.http.ResponseEntity;

public interface DatasourceService {

	public ResponseEntity<String> insertDS(DatasourceVo datasource_vo) ;
	
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) ;

	public List<DatasourceVo> selectDsList();
	
}
