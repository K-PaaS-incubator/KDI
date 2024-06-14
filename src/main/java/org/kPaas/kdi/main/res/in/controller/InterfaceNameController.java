package org.kPaas.kdi.main.res.in.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.in.service.InterfaceNameService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("/res/in")
@Controller
public class InterfaceNameController extends KdiGridController {

	@Autowired
	private InterfaceNameService service;

	InterfaceNameController() {
		super("res/in");
	}

	@Override
	protected KdiGridService getService() {
		return service;
	}
}
