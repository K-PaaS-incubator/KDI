package org.kPaas.kdi.main.res.si.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.si.service.SvcInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/res/si")
@Controller
public class SvcInfoController extends KdiGridController {

	@Autowired
	private SvcInfoService service;

	SvcInfoController() {
		super("res/si");
	}

	@Override
	protected KdiGridService getService() {
		return service;
	}
}
