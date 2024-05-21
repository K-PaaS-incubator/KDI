package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.util.criteria.Criteria;
import org.kPaas.kdi.com.util.criteria.PageVo;
import org.kPaas.kdi.main.link.service.LinkService;
import org.kPaas.kdi.main.link.vo.LinkDetailVo;
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

import java.util.Map;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/link")
@Controller
public class LinkServiceController extends AbstractController {
	public LinkServiceController() {
		super("linkService");
	}

	@Autowired
	LinkService service;

	//연계서비스 조회 화면
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
	@GetMapping()
	public String linkList(){return layout("index");}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("list.json")
	public ResponseEntity<String> getLinkList(@RequestParam Map<String, Object> params){
		return service.getLinkList(mapToKdiParam(params));
	}

	
/*
 * 이 파일 line35~37
 * index로 대체하므로 필요없는 Controller이나 , 참고용으로 남김
 * 연결해서 linkList.jsp도 필요없는 파일임.(사용하지 않는 jsp파일)
 * 
	@GetMapping("/linkList")
	public String linkLists(Model model,
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
*/
	

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
	
	
	//연계 인터페이스 조회
	@GetMapping("/linkInterfaceList")
	public String linkIFLists(Model model,
						   @RequestParam(value = "pageNum", required = false, defaultValue = "1")Integer pageNum,
						   @RequestParam(value = "svc_nm", required = false)String svc_nm,
						   RedirectAttributes redirectAttributes
						   ) {
		if (pageNum == null) {
			redirectAttributes.addAttribute("pageNum", 1);
			redirectAttributes.addAttribute("amount", 10);
			return "redirect:/link/linkInterfaceList";
		}

		LinkServiceVo linkServiceVo = new LinkServiceVo();
		linkServiceVo.setPageNum(pageNum);
		linkServiceVo.setAmount(10);
		linkServiceVo.setSvc_nm(svc_nm);
		
		Criteria criteria = new Criteria();
		criteria.setPageNum(pageNum);

		PageVo pageVo = new PageVo(criteria, service.selectLinkListCount(linkServiceVo));

		model.addAttribute("getInterfaceList", service.getInterfaceList(svc_nm));
		model.addAttribute("selectLinkListPage", service.selectLinkListPage(linkServiceVo));
		model.addAttribute("pagination", pageVo);
		//model.addAttribute("svc_nm",svc_nm);

		return layout("linkInterfaceList");
	}
}
