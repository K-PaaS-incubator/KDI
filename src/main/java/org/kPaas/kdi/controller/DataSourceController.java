package org.kPaas.kdi.controller;

import org.kPaas.kdi.service.UserInfoService;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DataSourceController {

	@Autowired
	UserInfoService service;

	@RequestMapping("/dsList")
	public String dsList() {
		return "/dataSourceMg/dsList";
	}

	@RequestMapping("/dsCreate")
	public String dsCreate() {
		return "/dataSourceMg/dsCreate";
	}	
	
	@RequestMapping("/dsEdit")
	public String dsEdit() {
		return "/dataSourceMg/dsEdit";
	}
	
	

	
}
