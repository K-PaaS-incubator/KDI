package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkTableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkTableController extends AbstractController {
	public LinkTableController() {
		super("linkService");
	}
	
	@Autowired
	LinkTableService service;
	
	//연계서비스 등록 세번째화면 - 연계테이블상세
	@GetMapping("/linkTable")
	public String linkTable() { //Model model, @RequestParam("svc_lnk_id") String svc_lnk_id
		return layout("linkTable");
	}
	
	
	
}
