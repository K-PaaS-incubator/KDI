package org.kPaas.kdi.main.datasource.controller;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/ds")
@Controller
public class DataSourceController extends AbstractController {
	public DataSourceController() {
		super("dataSourceMg");
	}

	@Autowired
	UserInfoService service;

	@GetMapping()
	public String dsList() {
		return layout("dsList");
	}

	@GetMapping("create")
	public String dsCreate() {
		return layout("dsCreate");
	}

	@GetMapping("edit")
	public String dsEdit() {
		return layout("dsEdit");
	}
}
