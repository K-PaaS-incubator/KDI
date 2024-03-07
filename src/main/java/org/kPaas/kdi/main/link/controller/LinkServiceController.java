package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkServiceController extends AbstractController {
	public LinkServiceController() {
		super("linkService");
	}

	@Autowired
	LinkService service;

	//연계서비스 조회 화면
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
	@GetMapping("/linkList")
	public String linkList(Model model) {
		model.addAttribute("selectLinkList", service.selectLinkList());
		return layout("linkList");
	}
	
	
	//연계서비스 등록 시작
	
	@GetMapping("/linkService")
	public String linkService(Model model) {
		model.addAttribute("selectDsList", service.selectDsList());
		return layout("linkService");
	}
	
	@PostMapping("linkCntCheck")
	public @ResponseBody int linkCntCheck(String svc_nm) {
		int result = service.getSameLinkCheck(svc_nm);
		return result;
	}
	
	@PostMapping("/LinkInsert")
	public ResponseEntity<String> linkInsert(LinkServiceVo linkService_vo) {
		service.insertLink(linkService_vo);
		return ResponseEntity.ok("연계서비스 등록 완료");
	}


}
