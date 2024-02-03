package org.kPaas.kdi.controller;

import java.security.Principal;

import org.kPaas.kdi.dto.User_VO;
import org.kPaas.kdi.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
	
	private final String auth = "/api/Auth/";
	private final String noAuth = "/api/noAuth/";
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	UserInfoService service;
	
	@RequestMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception, Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		return "/member/login";
	}

	@RequestMapping("/signUp")
	public String signUp() {
		return "/member/signUp";
	}
	
	//아이디 중복체크
	@RequestMapping(noAuth+"idCheck")
	public @ResponseBody int idCheck(String usr_id){
		int result = service.getSameIdCheck(usr_id);
			return result;	
		
	}
	
	@PostMapping("/signUpProc")
	public String signupUser(User_VO user_vo) {
		int idCnt = 0;
		idCnt = service.getSameIdCheck(user_vo.getUsr_id());
		if (idCnt > 0) {
			return "/member/signUp";
		} else {
			user_vo.setUsr_pw(passwordEncoder.encode(user_vo.getUsr_pw()));
			service.signupUser(user_vo);
			return "/member/login";
		}
	}

	@RequestMapping("/forgotPw")
	public String forgotPw() {
		return "/member/forgotPw";
	}
	
	@RequestMapping("/userInfo")
	public String userInfo(Principal principal, Model model) {
		model.addAttribute("userInfo",service.getUsrInfo(principal.getName()));
		return "/member/userInfo";
	}

}
