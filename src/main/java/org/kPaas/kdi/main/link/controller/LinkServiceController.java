package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.util.criteria.Criteria;
import org.kPaas.kdi.com.util.criteria.PageVo;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String linkList(Model model,
						   @RequestParam(value = "pageNum", required = false, defaultValue = "1")Integer pageNum,
						   @RequestParam(value = "svc_nm", required = false)String svc_nm,
						   RedirectAttributes redirectAttributes
						   ) {
		if (pageNum == null) {
			redirectAttributes.addAttribute("pageNum", 1);
			redirectAttributes.addAttribute("amount", 10);
			return "redirect:/link/linkList";
		}

		LinkServiceVo linkServiceVo = new LinkServiceVo();
		linkServiceVo.setPageNum(pageNum);
		linkServiceVo.setAmount(10);
		linkServiceVo.setSvc_nm(svc_nm);

		Criteria criteria = new Criteria();
		criteria.setPageNum(pageNum);

		PageVo pageVo = new PageVo(criteria, service.selectLinkListCount(linkServiceVo));

		model.addAttribute("selectLinkListPage", service.selectLinkListPage(linkServiceVo));
		model.addAttribute("pagination", pageVo);

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
