package org.kPaas.kdi.main.link.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.main.link.service.LinkDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkDetailController extends AbstractController {
	public LinkDetailController() {
		super("linkService");
	}

	@Autowired
	LinkDetailService service;
	
	
	//연계서비스 등록 두번째화면 - 연계서비스항목
	@GetMapping("/linkDetail")
	public String linkDetail() {
		return layout("linkDetail");
	}
	 
	//연계서비스 항목 설정 시작
	@GetMapping("/getLinkService")
	public String getLinkService(Model model,@RequestParam("svc_nm") String svc_nm) {
		model.addAttribute("getLinkService", service.getLinkService(svc_nm));	
		model.addAttribute("connectLinkDs",service.connectLinkDs(svc_nm));
		return layout("linkDetail");
	}
	
	
	
	

}
