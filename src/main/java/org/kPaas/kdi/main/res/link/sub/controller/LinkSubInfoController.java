package org.kPaas.kdi.main.res.link.sub.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.link.sub.service.LinkSubInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("res/link/sub")
@Controller
public class LinkSubInfoController extends KdiGridController {
	public LinkSubInfoController() {
		super("res/link/sub");
	}

	@Autowired
	private LinkSubInfoService service;

	@Override
	protected KdiGridService getService() {
		return service;
	}

}
