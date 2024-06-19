package org.kPaas.kdi.main.link.controller;

import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkServiceController extends AbstractController {
	public LinkServiceController() {
		super("link");
	}

	@Autowired
	private LinkService service;

	// 연계서비스 조회 화면
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
	@GetMapping
	public String getIndex() {
		return layout("index");
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("list.json")
	public ResponseEntity<String> getLinkList(@RequestParam Map<String, Object> params) {
		return service.getLinkList(mapToKdiParam(params));
	}
	
	//연계서비스 등록화면
	@GetMapping("reg")
	public String getReg(Model model) {
		model.addAttribute("selectDsList", service.selectDsList());
		return layout("reg");
	}

	//연계서비스중복검사(svc_id)
	@PostMapping("duplicateCheck.json")
	public ResponseEntity<String> linkCntCheck(@RequestParam("svc_id") String svc_id) {
		return service.duplicateCheck(svc_id);
	}

	//연계서비스 등록 로직
	@PostMapping("reg.json")
	public ResponseEntity<String> linkInsert(LinkServiceVo linkService_vo) {
		return service.insertLink(linkService_vo);
	}
	
	// 연계서비스 삭제 (pk:svc_id,ds_nm)
	@PostMapping("/lnkDel")
	public ResponseEntity<String> lnkDel(@RequestParam Map<String, Object> params) {
		return service.lnkDel(params);
	}
	
}
