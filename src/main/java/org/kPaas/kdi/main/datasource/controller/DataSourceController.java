package org.kPaas.kdi.main.datasource.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.kPaas.kdi.main.datasource.service.DatasourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/ds")
@Controller
public class DataSourceController extends AbstractController {
	public DataSourceController() {
		super("dataSourceMg");
	}

	@Autowired
	DatasourceService service;

	@GetMapping()
	public String dsList() { 
		return layout("dsList");
	}

	@PostMapping("/create")
	public ResponseEntity<String> dsCreate(DatasourceVo datasource_vo) {
		System.out.println("---------");
		service.insertDS(datasource_vo);
		//return layout("dsCreate");
		return ResponseEntity.ok("데이터소스정보 등록완료");
	}

	@GetMapping("edit")
	public String dsEdit() {
		return layout("dsEdit");
	}
	
	@PostMapping("/testConnection")
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		System.out.println("-----testConnection----");
		//datasource_vo
		
		
		return ResponseEntity.ok("데이터소스정보 등록완료");
	}
}
