package org.kPaas.kdi.controller;

import java.security.Principal;

import org.kPaas.kdi.dto.User_VO;
import org.kPaas.kdi.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class MemberController {
	
	private final String auth = "/api/Auth/";
	private final String noAuth = "/api/noAuth/";
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	UserInfoService service;
	
	@GetMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception, Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		return "/member/login";
	}

	@GetMapping("/signUp")
	public String signUp() {
		return "/member/signUp";
	}
	
	//아이디 중복체크
	@GetMapping(noAuth+"idCheck")
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

	@GetMapping("/forgotPw")
	public String forgotPw() {
		return "/member/forgotPw";
	}
	
	@GetMapping("/userInfo")
	public String userInfo(Principal principal, Model model) {
		model.addAttribute("userInfo",service.getUsrInfo(principal.getName()));
		return "/member/userInfo";
	}

}
