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

	// 연계 인터페이스 조회
	@GetMapping
	public String getIndex(Model model, @RequestParam("svc_nm") String svc_nm, @RequestParam("ds_nm") String ds_nm,
			@RequestParam("svc_type") String svc_type) {
		model.addAttribute("svc_nm", svc_nm);
		model.addAttribute("ds_nm", ds_nm);
		model.addAttribute("svc_type", svc_type);
		return layout("index");
	}

	@GetMapping("list.json")
	public ResponseEntity<String> getList(@RequestParam Map<String, Object> params) {
		return service.getList(mapToKdiParam(params));
	}

	// 연계 인터페이스 정보
	@GetMapping("data/{pageType}")
	public String getLinkService(Model model, @PathVariable("pageType") String pageType,
			@RequestParam("svc_nm") String svc_nm, @RequestParam("ds_nm") String ds_nm,
			@RequestParam("svc_type") String svc_type,
			@RequestParam(name = "svc_lnk_id", defaultValue = "", required = false) String svc_lnk_id) {
		model.addAttribute("pageType", pageType);// view or reg
		model.addAttribute("svc_nm", svc_nm);
		model.addAttribute("ds_nm", ds_nm);
		model.addAttribute("svc_lnk_id", svc_lnk_id);
		if("P".equalsIgnoreCase(svc_type)) {
			return layout("data_send");
		} else {
			return layout("data_recv");
		}
	}

	@PostMapping("linkTableName")
	public ResponseEntity<String> linkTableName(@RequestParam Map<String, Object> params) {
		return service.insertDetail(params);
	}

//	@PostMapping("linkDetailEdit")
//	public ResponseEntity<String> linkDetailEdit(@RequestParam Map<String, Object> params) {
//		return service.insertDetail(params);
//	}

}
