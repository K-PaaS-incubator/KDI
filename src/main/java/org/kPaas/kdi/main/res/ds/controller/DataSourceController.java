package org.kPaas.kdi.main.res.ds.controller;

import java.util.Map;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.res.ds.service.DatasourceService;
import org.kPaas.kdi.main.res.ds.vo.DatasourceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/res/ds")
@Controller
public class DataSourceController extends AbstractController {
	public DataSourceController() {
		super(SUB_BANNER_LAYOUT, "res/ds");
	}

	@Autowired
	private DatasourceService service;

	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자가 아닌 일반 사용자)
	@GetMapping()
	public String dsList() {
		return layout("index");
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("list.json")
	public ResponseEntity<String> getDsList(@RequestParam Map<String, Object> params) {
		return service.getList(mapToKdiParam(params));
	}

	@GetMapping("/dsCreate")
	public String dsCreate() {
		return layout("dsCreate");
	}

	@PostMapping("/dsCheck")
	public ResponseEntity<String> dsCheck(DatasourceVo datasource_vo) {
		return service.duplicateCheck(datasource_vo.getDsNm());
	}

	@PostMapping("/dsInsert")
	public ResponseEntity<String> dsWrite(DatasourceVo datasource_vo) {
		return service.insert(datasource_vo);
	}

	@GetMapping("/dsEdit")
	public String dsEdit(Model model, @RequestParam("dsNm") String ds_nm) {
		model.addAttribute("selectDsInfo", service.get(ds_nm));
		return layout("dsEdit");
	}

	@ResponseBody
	@PostMapping("/dsEditProc")
	public ResponseEntity<String> dsEditProc(DatasourceVo datasource_vo) {
		return service.modify(datasource_vo);
	}

	@ResponseBody
	@PostMapping("/dsDelProc")
	public ResponseEntity<String> dsDelProc(String ds_nm) {
		return service.delete(ds_nm);
	}

	@ResponseBody
	@PostMapping("/testConnection")
	public ResponseEntity<String> testConnection(DatasourceVo datasource_vo) {
		return service.testConnection(datasource_vo);
	}
}
