package org.kPaas.kdi.main.monitoring.controller;

import org.kPaas.kdi.com.member.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MonitoringController {

	@Autowired
	UserInfoService service;

	@GetMapping("/monitorList")
	public String monitorList() {
		return "/monitoring/monitorList";
	}

	

	
}
