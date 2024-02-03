package org.kPaas.kdi.controller;

import org.kPaas.kdi.service.UserInfoService;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class KDIController {

	private static final String EXCAHGE_NAME = "pps.exchange";
	
	@Autowired
	RabbitTemplate rabbitTemplate;
	
	@Autowired
	UserInfoService service;

	@PostMapping("pps/queue")
	public @ResponseBody Object ppsPublish(String message) {
		rabbitTemplate.convertAndSend(EXCAHGE_NAME, "pps.routing.#", message);
		return message;
	}

	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping("/main")
	public String test() {
		return "main";
	}
	
	
}
