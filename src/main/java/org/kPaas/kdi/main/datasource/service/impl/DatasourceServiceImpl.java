package org.kPaas.kdi.main.datasource.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.kPaas.kdi.main.datasource.mapper.DatasourceMapper;
import org.kPaas.kdi.main.datasource.service.DatasourceService;
import org.springframework.stereotype.Service;

@Service
public class DatasourceServiceImpl implements DatasourceService {
	
	@Resource
	private DatasourceMapper mapper;

	@Resource
	private DBCheckService dbCheckService;
	
	/**
	 * 최초 기동시에 데이터소스테이블(KDI_DATASOURCE)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 데이터소스테이블을 생성하는 기능
	 */
	@PostConstruct
	private void init() {
		if(!dbCheckService.isExists("KDI_DATASOURCE")) {
			mapper.createTable();
		}
	}
	
	public void insertDS(DatasourceVo datasource_vo) {
		mapper.insertDS(datasource_vo);
	}
	
	public boolean testConnection(DatasourceVo datasource_vo) {
		String ds_url = datasource_vo.getDs_url();
		String ds_usr_nm = datasource_vo.getDs_usr_nm();
		String ds_usr_pw = datasource_vo.getDs_usr_pw();
		try(Connection conn = DriverManager.getConnection(ds_url,ds_usr_nm,ds_usr_pw)) {
			return true;
		}catch(SQLException e) {
			return false;
		}
	}
}
