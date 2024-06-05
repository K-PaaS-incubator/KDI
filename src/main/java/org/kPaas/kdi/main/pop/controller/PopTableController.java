package org.kPaas.kdi.main.pop.controller;

import java.util.Map;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkService;
import org.kPaas.kdi.main.pop.service.PopTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("pop/table")
public class PopTableController extends AbstractController {
	@Autowired
	private PopTableService service;
	@Autowired
	private LinkService lnkService;

	public PopTableController() {
		super("pop/table");
	}

	@GetMapping
	public String get() {
		return nolayout("index");
	}

	@GetMapping("schemas.json")
	public ResponseEntity<String> getSchemas(@RequestParam("ds_nm") String ds_nm) {
		return service.getSchemas(ds_nm);
	}

	@GetMapping("tables.json")
	public ResponseEntity<String> getLinkTableList(@RequestParam Map<String, Object> params) {
		return service.getTables(mapToKdiParam(params));
	}
	
	@GetMapping("interfacePop")
	public String getInterfacePop(Model model, @RequestParam("svc_nm") String svc_nm,
			@RequestParam("ds_nm") String ds_nm) {

		model.addAttribute("selectDsList", lnkService.selectDsList());
		model.addAttribute("ds_nm",ds_nm);
		model.addAttribute("svc_nm",svc_nm);
		
		return nolayout("interfacePop");
	}
	
	@PostMapping("editIF.json")
	public ResponseEntity<String> editIF_SvcDs(@RequestParam Map<String, Object> params) {
		
		return service.editIF_SvcDs(params);
	}
	
}
