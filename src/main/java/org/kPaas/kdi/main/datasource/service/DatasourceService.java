package org.kPaas.kdi.main.datasource.service;

import org.kPaas.kdi.main.datasource.dto.DatasourceVo;

public interface DatasourceService {

	public void insertDS(DatasourceVo datasource_vo) ;
	
	public boolean testConnection(DatasourceVo datasource_vo) ;
	
}
