package org.kPaas.kdi.main.link.controller;

import java.util.Map;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkInterfaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link/interface")
@Controller
public class LinkInterfaceController extends AbstractController {
	public LinkInterfaceController() {
		super("link/interface");
	}

	@Autowired
	private LinkInterfaceService service;

	// 연계서비스 조회
	@GetMapping
	public String getIndex(Model model, @RequestParam("svc_id") String svc_id, @RequestParam("svc_nm") String svc_nm,
			@RequestParam("ds_nm") String ds_nm, @RequestParam("svc_type") String svc_type) {
		model.addAttribute("svc_id", svc_id);
		model.addAttribute("svc_nm", svc_nm);
		model.addAttribute("ds_nm", ds_nm);
		model.addAttribute("svc_type", svc_type);
		return layout("index");
	}

	/*
	 * index.jsp 파일 참고 // 그리드 객체 생성 var grid = KdiListGrid('grid',
	 * '${linkUrl}list.json');
	 */
	@GetMapping("list.json")
	public ResponseEntity<String> getList(@RequestParam Map<String, Object> params, Model model) {
		return service.getList(mapToKdiParam(params));
	}

	// 연계서비스타입(송신,수신)에 따른 인터페이스 페이지호출
	@GetMapping("data/{pageType}")
	public String getLinkService(Model model, @PathVariable("pageType") String pageType,
			@RequestParam("svc_id") String svc_id, @RequestParam("svc_nm") String svc_nm,
			@RequestParam("ds_nm") String ds_nm, @RequestParam("svc_type") String svc_type,
			@RequestParam(name = "svc_lnk_id", defaultValue = "", required = false) String svc_lnk_id) {
		model.addAttribute("pageType", pageType);
		model.addAttribute("svc_id", svc_id);
		model.addAttribute("svc_type", svc_type);
		model.addAttribute("svc_nm", svc_nm);
		model.addAttribute("ds_nm", ds_nm);
		model.addAttribute("svc_lnk_id", svc_lnk_id);
		if ("P".equalsIgnoreCase(svc_type)) {
			return layout("data_send");
		} else {
			return layout("data_recv");
		}
	}

	// 연계서비스 > 인터페이스 입력
	@PostMapping("data/{pageType}.json")
	public ResponseEntity<String> save(@PathVariable("pageType") String pageType,
			@RequestParam Map<String, Object> params) {
		if ("reg".equalsIgnoreCase(pageType)) {
			if ("P".equalsIgnoreCase(String.valueOf(params.get("svc_type")))) {
				return service.insertPubInterface(params);
			} else {
				return service.insertSubInterface(params);
			}
		} else {
			if ("P".equalsIgnoreCase(String.valueOf(params.get("svc_type")))) {
				return service.updatePubInterface(params);
			} else {
				return service.updateSubInterface(params);
			}
		}
	}

	// 연계서비스 > 인터페이스 데이터출력
	@GetMapping("data.json")
	public ResponseEntity<String> getData(@RequestParam Map<String, Object> params) {
		if ("P".equalsIgnoreCase(String.valueOf(params.get("svc_type")))) {
			return service.selectPubInterface(params);
		} else {
			return service.selectSubInterface(params);
		}
	}
	
	// 연계서비스 > 연계 인터페이스 삭제 (pk:svc_lnk_id,svc_id,ds_nm)
	@PostMapping("/IfDelProc")
	public ResponseEntity<String> ifDelProc(@RequestParam Map<String, Object> params) {
		return service.delInterface(params);
	}
}
