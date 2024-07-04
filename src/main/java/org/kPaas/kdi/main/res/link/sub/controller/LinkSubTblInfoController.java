package org.kPaas.kdi.main.res.link.sub.controller;

import java.util.Map;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.link.sub.service.LinkSubTblInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("res/link/sub/tbl")
@Controller
public class LinkSubTblInfoController extends KdiGridController {
	public LinkSubTblInfoController() {
		super("res/link/sub/tbl");
	}

	@Autowired
	private LinkSubTblInfoService service;

	@Override
	protected KdiGridService getService() {
		return service;
	}
	
	@GetMapping("columns.json")
	public ResponseEntity<String> getColumns(@RequestParam Map<String, Object> params) {
		return service.getColumns(mapToKdiParam(params));
	}


}
