package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("link")
@Controller
public class LinkController extends AbstractController {
	public LinkController() {
		super("linkService");
	}

<<<<<<< HEAD
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
=======
>>>>>>> branch 'main' of http://git.biz.ppsystem.co.kr/cloud/kdi.git
	@GetMapping("/linkList")
	public String getPubList() {
		return layout("linkList");
	}

	@GetMapping("/linkCreate")
	public String getCreate() {
		return layout("linkCreate");
	}

}
