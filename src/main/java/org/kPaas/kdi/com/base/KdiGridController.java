package org.kPaas.kdi.com.base;

import java.util.Map;

import org.kPaas.kdi.com.abs.AbstractController;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

public abstract class KdiGridController extends AbstractController {
	protected KdiGridController(String jspDirPath) {
		super(SUB_BANNER_LAYOUT, jspDirPath);
	}

	protected abstract KdiGridService getService();

	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자가 아닌 일반 사용자)
	@GetMapping()
	public String getIndex() {
		return layout("index");
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/get.json")
	public ResponseEntity<String> get(@RequestParam Map<String, Object> params) {
		return getService().get(mapToKdiParam(params));
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("list.json")
	public ResponseEntity<String> getList(@RequestParam Map<String, Object> params) {
		return getService().getList(mapToKdiParam(params));
	}

	@GetMapping("/insert")
	public String dsCreate() {
		return layout("insert");
	}

	@GetMapping("/duplicateCheck.json")
	public ResponseEntity<String> getDuplicateCheck(@RequestParam Map<String, Object> params) {
		return getService().duplicateCheck(mapToKdiParam(params));
	}

	@PostMapping("/insert.json")
	public ResponseEntity<String> insert(@RequestParam Map<String, Object> params) {
		return getService().insert(mapToKdiParam(params));
	}

	@GetMapping("/modify")
	public String getModify() {
		return layout("modify");
	}

	@PostMapping("/modify.json")
	public ResponseEntity<String> modify(@RequestParam Map<String, Object> params) {
		return getService().modify(mapToKdiParam(params));
	}

	@ResponseBody
	@PostMapping("/delete.json")
	public ResponseEntity<String> delete(@RequestParam Map<String, Object> params) {
		return getService().delete(mapToKdiParam(params));
	}

}