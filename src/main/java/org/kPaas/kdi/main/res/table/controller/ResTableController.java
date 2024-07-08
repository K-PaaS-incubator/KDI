package org.kPaas.kdi.main.res.table.controller;

import java.util.Map;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.res.table.service.ResTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 스키마 및 테이블 선택 기능
 */
@Controller
@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("res/table")
public class ResTableController extends AbstractController {
	@Autowired
	private ResTableService service;

	public ResTableController() {
		super("res/table");
	}

	@GetMapping
	public String get() {
		return nolayout("index");
	}

	@GetMapping("schemas.json")
	public ResponseEntity<String> getSchemas(@RequestParam("dsNm") String dsNm) {
		return service.getSchemas(dsNm);
	}

	@GetMapping("tables.json")
	public ResponseEntity<String> getLinkTableList(@RequestParam Map<String, Object> params) {
		return service.getTables(mapToKdiParam(params));
	}
}
