package org.kPaas.kdi.main.res.link.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.link.service.LinkSvcInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/res/link")
@Controller
public class LinkSvcInfoController extends KdiGridController {
	public LinkSvcInfoController() {
		super("res/link");
	}

	@Autowired
	private LinkSvcInfoService service;
	
	@Override
	protected KdiGridService getService() {
		return service;
	}
}
