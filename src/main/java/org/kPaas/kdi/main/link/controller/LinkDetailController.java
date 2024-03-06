package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkDetailService;
import org.kPaas.kdi.main.link.vo.LinkServiceVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkDetailController extends AbstractController {

	@Autowired
	LinkDetailService service;
	
	//연계서비스 등록 두번째화면 - 연계서비스항목
	@GetMapping("/linkDetail")
	public String linkDetail() {
		return layout("linkDetail");
	}
	
	@PostMapping("linkCntCheck")
	public @ResponseBody int dsCntCheck(String svc_nm) {
		int result = service.getSameLinkCheck(svc_nm);
		return result;
	}
	
	@PostMapping("/linkInsert")
	public ResponseEntity<String> linkInsert(LinkServiceVo linkService_vo) {
		service.insertLink(linkService_vo);
		return ResponseEntity.ok("연계서비스 등록 완료");
	}
	

}
