package org.kPaas.kdi.controller;

import org.kPaas.kdi.service.UserInfoService;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LinkController {

	@Autowired
	UserInfoService service;

	@RequestMapping("/linkList")
	public String linkList() {
		return "/linkService/linkList";
	}

	
	

	
}
