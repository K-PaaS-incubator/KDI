package org.kPaas.kdi.main.res.tpi.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.tpi.service.TransPathService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/res/tpi")
@Controller
public class TransPathController extends KdiGridController {

	@Autowired
	private TransPathService service;

	TransPathController() {
		super("res/tpi");
	}

	@Override
	protected KdiGridService getService() {
		return service;
	}
}
