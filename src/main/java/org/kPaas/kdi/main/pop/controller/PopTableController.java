package org.kPaas.kdi.main.pop.controller;

import java.util.Map;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.pop.service.PopTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("pop/table")
public class PopTableController extends AbstractController {
	@Autowired
	private PopTableService service;

	public PopTableController() {
		super("pop/table");
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
