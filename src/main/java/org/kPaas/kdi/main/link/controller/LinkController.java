package org.kPaas.kdi.main.link.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/link")
@Controller
public class LinkController extends AbstractController {
	public LinkController() {
		super("linkService");
	}

	@GetMapping()
	public String getList() {
		return layout("linkList");
	}

	@GetMapping("create")
	public String getCreate() {
		return layout("linkCreate");
	}

}
