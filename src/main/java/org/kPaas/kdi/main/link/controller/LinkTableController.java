package org.kPaas.kdi.main.link.controller;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractController;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	//연계서비스 등록 세번째화면 - 연계테이블상세
	@GetMapping("/linkTable")
	public String linkTable() {
		return layout("linkTable");
	}
	
	
	@ResponseBody
	@PostMapping("/linkTableName")
	public String linkTableName(@RequestParam("tbl_nm") String tbl_nm) {
		System.out.println(tbl_nm);
		JSONObject json = new JSONObject();
		json.put("abcd", tbl_nm);
		return json.toString();
	}


}
