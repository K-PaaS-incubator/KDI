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

	@GetMapping("/linkList")
	public String getPubList() {
		return layout("linkList");
	}

	@GetMapping("/linkCreate")
	public String getCreate() {
		return layout("linkCreate");
	}

}
