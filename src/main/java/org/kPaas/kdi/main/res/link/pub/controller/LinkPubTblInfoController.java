package org.kPaas.kdi.main.res.link.pub.controller;

import org.kPaas.kdi.com.base.KdiGridController;
import org.kPaas.kdi.com.base.KdiGridService;
import org.kPaas.kdi.main.res.link.pub.service.LinkPubInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@PreAuthorize("hasRole('ADMIN')") // 관리자
@RequestMapping("res/link/pub/tbl")
@Controller
public class LinkPubTblInfoController extends KdiGridController {
	public LinkPubTblInfoController() {
		super("res/link/pub");
	}

	@Autowired
	private LinkPubInfoService service;

	@Override
	protected KdiGridService getService() {
		return service;
	}

}
