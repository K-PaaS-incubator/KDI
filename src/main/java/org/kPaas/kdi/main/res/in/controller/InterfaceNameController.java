package org.kPaas.kdi.main.res.in.controller;

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
@RequestMapping("/res/in")
@Controller
public class InterfaceNameController extends AbstractController {
	public InterfaceNameController() {
		super(SUB_BANNER_LAYOUT, "res/in");
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
	public ResponseEntity<String> get(@RequestParam("if_id") String if_id) {
		return service.get(if_id);
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
	public ResponseEntity<String> getDuplicateCheck(@RequestParam("if_id") String ifId) {
		return service.duplicateCheck(ifId);
	}

	@PostMapping("/insert.json")
	public ResponseEntity<String> insert(@RequestParam("if_id") String ifId, @RequestParam("if_nm") String ifNm) {
		return service.insert(ifId, ifNm);
	}

	@GetMapping("/modify")
	public String getModify(Model model, @RequestParam("if_id") String if_id) {
		return layout("modify");
	}

	@PostMapping("/modify.json")
	public ResponseEntity<String> dsEditProc(@RequestParam("if_id") String ifId,
			@RequestParam("org_if_id") String orgIfId, @RequestParam("if_nm") String ifNm) {
		return service.modify(ifId, orgIfId, ifNm);
	}

	@ResponseBody
	@PostMapping("/delete.json")
	public ResponseEntity<String> dsDelProc(@RequestParam("org_if_id") String orgIfId) {
		return service.delete(orgIfId);
	}

}
