package org.kPaas.kdi.main.res.link.pub.controller;

import java.util.Map;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.link.pub.service.LinkPubTblInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("res/link/pub/tbl")
@Controller
public class LinkPubTblInfoController extends KdiGridController {
	public LinkPubTblInfoController() {
		super("res/link/pub/tbl");
	}

	@Autowired
	private LinkPubTblInfoService service;

	@Override
	protected KdiGridService getService() {
		return service;
	}
	
	@GetMapping("columns.json")
	public ResponseEntity<String> getColumns(@RequestParam Map<String, Object> params) {
		return service.getColumns(mapToKdiParam(params));
	}

}
