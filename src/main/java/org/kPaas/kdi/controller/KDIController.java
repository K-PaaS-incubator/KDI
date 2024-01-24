package org.kPaas.kdi.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kPaas.kdi.dto.User_VO;
import org.kPaas.kdi.service.UserInfoService;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class KDIController {

	private static final String EXCAHGE_NAME = "pps.exchange";

	private final String auth = "/api/Auth/";
	private final String noAuth = "/api/noAuth/";
	@Autowired
	UserInfoService service;

	@Autowired
	RabbitTemplate rabbitTemplate;

	@Autowired
	PasswordEncoder passwordEncoder;

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
	
	@RequestMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception, Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		return "login";
	}

	@RequestMapping("/signUp")
	public String signUp() {
		return "signUp";
	}
	
	//아이디 중복체크
	@RequestMapping(noAuth+"idCheck")
	public @ResponseBody int idCheck(String usr_id){
		int result = service.getSameIdCheck(usr_id);
		System.out.println("------------");
			return result;	
		
	}
	
	@PostMapping("/signUpProc")
	public String signupUser(User_VO user_vo) {
		int idCnt = 0;
		idCnt = service.getSameIdCheck(user_vo.getUsr_id());
		if (idCnt > 0) {
			return "signUp";
		} else {
			user_vo.setUsr_pw(passwordEncoder.encode(user_vo.getUsr_pw()));
			service.signupUser(user_vo);
			return "login";
		}
	}

	@RequestMapping("/forgotPw")
	public String forgotPw() {
		return "forgotPw";
	}
}
