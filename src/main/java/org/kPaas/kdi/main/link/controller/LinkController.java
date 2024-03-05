package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkController extends AbstractController {
	public LinkController() {
		super("linkService");
	}

	@Autowired
	LinkService service;

	//연계서비스 조회 화면
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
	@GetMapping("/linkList")
	public String linkList(Model model) {
		//model.addAttribute("selectDsList", service.selectDsList());
		return layout("linkList");
	}

	//연계서비스 등록 첫화면
	@GetMapping("/linkService")
	public String linkService(Model model) {
		model.addAttribute("selectDsList", service.selectDsList());
		return layout("linkService");
	}
	
	//연계서비스 등록 두번째화면 - 연계서비스항목
	@GetMapping("/linkDetail")
	public String linkDetail() {
		return layout("linkDetail");
	}
	
	//연계서비스 등록 세번째화면 - 연계테이블상세
	@GetMapping("/linkTable")
	public String linkTable() {
		return layout("linkTable");
	}

}
