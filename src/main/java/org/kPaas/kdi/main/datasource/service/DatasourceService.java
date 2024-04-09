package org.kPaas.kdi.main.datasource.service;

import java.util.List;

import org.kPaas.kdi.com.util.criteria.Criteria;
import org.kPaas.kdi.main.datasource.vo.DatasourceVo;
import org.springframework.http.ResponseEntity;

public interface DatasourceService {

	public ResponseEntity<String> insertDS(DatasourceVo datasource_vo) ;
	
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) ;

	public List<DatasourceVo> selectDsList();
	public List<DatasourceVo> selectDsListPage(DatasourceVo datasource_vo);
	public int selectDsListCount(DatasourceVo datasource_vo);

	public DatasourceVo selectDsInfo(String ds_nm);

	public ResponseEntity<String> editDS(DatasourceVo datasource_vo);

	public Integer getSameDsCheck(String ds_nm);

	public ResponseEntity<String> delDS(String ds_nm);
	
}
