package org.kPaas.kdi.main.datasource.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.datasource.dto.DatasourceVo;
import org.kPaas.kdi.main.datasource.service.DatasourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RequestMapping("/ds")
@Controller
public class DataSourceController extends AbstractController {
	public DataSourceController() {
		super("dataSourceMg");
	}

	@Autowired
	DatasourceService service;

	@GetMapping("/dsList")
	public String dsList(Model model) {
		model.addAttribute("selectDsList",service.selectDsList());
		return layout("dsList");
	}
	
	@GetMapping("/dsCreate")
	public String dsCreate() {
		return layout("dsCreate");
	}

	@ResponseBody
	@PostMapping("/dsCreateProc")
	public ResponseEntity<String> dsCreateProc(DatasourceVo datasource_vo) {
		return service.insertDS(datasource_vo);
	}

	@GetMapping("edit")
	public String dsEdit() {
		return layout("dsEdit");
	}

	@ResponseBody
	@PostMapping("/testConnection")
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		return service.testConnection(datasource_vo);
	}
}
