package org.kPaas.kdi.main.res.tpi.controller;

import java.util.Map;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.res.in.service.InterfaceNameService;
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
@RequestMapping("/res/tpi")
@Controller
public class TransPathController extends AbstractController {
	public TransPathController() {
		super(SUB_BANNER_LAYOUT, "res/tpi");
	}

	@Autowired
	private InterfaceNameService service;

	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자가 아닌 일반 사용자)
	@GetMapping()
	public String getIndex() {
		return layout("index");
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/get.json")
	public ResponseEntity<String> get(@RequestParam("trns_path_id") String trns_path_id) {
		return service.get(trns_path_id);
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("list.json")
	public ResponseEntity<String> getList(@RequestParam Map<String, Object> params) {
		return service.getList(mapToKdiParam(params));
	}

	@GetMapping("/insert")
	public String dsCreate() {
		return layout("insert");
	}

	@GetMapping("/duplicateCheck.json")
	public ResponseEntity<String> getDuplicateCheck(@RequestParam("trns_path_id") String trnsPathId) {
		return service.duplicateCheck(trnsPathId);
	}

	@PostMapping("/insert.json")
	public ResponseEntity<String> insert(@RequestParam("trns_path_id") String trnsPathId, @RequestParam("trns_path_nm") String trnsPathNm) {
		return service.insert(trnsPathId, trnsPathNm);
	}

	@GetMapping("/modify")
	public String getModify(Model model, @RequestParam("trns_path_id") String trns_path_id) {
		return layout("modify");
	}

	@PostMapping("/modify.json")
	public ResponseEntity<String> dsEditProc(@RequestParam("trns_path_id") String trnsPathId,
			@RequestParam("org_trns_path_id") String orgTrnsPathId, @RequestParam("trns_path_nm") String trnsPathNm) {
		return service.modify(trnsPathId, orgTrnsPathId, trnsPathNm);
	}

	@ResponseBody
	@PostMapping("/delete.json")
	public ResponseEntity<String> dsDelProc(@RequestParam("org_trns_path_id") String orgTrnsPathId) {
		return service.delete(orgTrnsPathId);
	}

}
