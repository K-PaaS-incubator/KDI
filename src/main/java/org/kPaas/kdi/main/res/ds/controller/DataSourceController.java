package org.kPaas.kdi.main.res.ds.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.ds.service.DatasourceService;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/res/ds")
@Controller
public class DataSourceController extends KdiGridController {
	public DataSourceController() {
		super("res/ds");
	}

	@Autowired
	private DatasourceService service;

	@Override
	protected KdiGridService getService() {
		return service;
	}

	@PostMapping("/testConnection.json")
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		return service.testConnection(datasource_vo);
	}
	
	@GetMapping("/get_all_ds_nm.json")
	public ResponseEntity<String> getAllDsList() {
		return service.getAllDsNm();
	}
}
