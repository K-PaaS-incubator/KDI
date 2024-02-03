package org.kPaas.kdi.main.datasource.controller;

import org.kPaas.kdi.com.member.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DataSourceController {

	@Autowired
	UserInfoService service;

	@GetMapping("/dsList")
	public String dsList() {
		return "/dataSourceMg/dsList";
	}

	@GetMapping("/dsCreate")
	public String dsCreate() {
		return "/dataSourceMg/dsCreate";
	}	
	
	@GetMapping("/dsEdit")
	public String dsEdit() {
		return "/dataSourceMg/dsEdit";
	}
	
	

	
}
