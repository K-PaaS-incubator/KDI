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
import org.springframework.web.bind.annotation.ResponseBody;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkTableController extends AbstractController {
	public LinkTableController() {
		super("linkService");
	}
	
	@Autowired
	LinkTableService service;

	@GetMapping("/linkTable")
	public String linkTable(Model model, @RequestParam("svc_lnk_id") String svc_lnk_id, @RequestParam("svc_id") String svc_id, @RequestParam("ds_nm") String ds_nm) {
		model.addAttribute("getDetailVo", service.getDetailVo(svc_lnk_id,svc_id,ds_nm));
		return layout("linkTable");
	}
	
	
	
	
}
