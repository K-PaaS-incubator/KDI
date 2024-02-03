package org.kPaas.kdi.main.link.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/link")
@Controller
public class LinkController {

	@GetMapping()
	public String getList() {
		return "/linkService/linkList";
	}

	@GetMapping("create")
	public String getCreate() {
		return "/linkService/linkCreate";
	}
}
