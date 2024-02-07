package org.kPaas.kdi.com.member.controller;

import java.security.Principal;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.member.dto.MemberVo;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController extends AbstractController {

	public MemberController() {
		super("loginLayout", "member");
	}

	private final String auth = "/api/Auth/";
	private final String noAuth = "/api/noAuth/";

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	UserInfoService service;

	@GetMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception, Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);
		
		return layout("login");
	}
	
	@GetMapping("/signUp")
	public String signUp() {
		return layout("signUp");
	}
	
	// 아이디 중복체크
	@GetMapping(noAuth + "idCheck")
	public @ResponseBody int idCheck(String usr_id) {
		int result = service.getSameIdCheck(usr_id);
		return result;

	}

	@PostMapping("/signUpProc")
	public String signupUser(MemberVo user_vo) {
		int idCnt = 0;
		idCnt = service.getSameIdCheck(user_vo.getUsr_id());
		if (idCnt > 0) {
			return layout("signUp");
		} else {
			user_vo.setUsr_pw(passwordEncoder.encode(user_vo.getUsr_pw()));
			service.signupUser(user_vo);
			return layout("login");
		}
	}

	@GetMapping("/forgotPw")
	public String forgotPw() {
		return layout("forgotPw");
	}

	//사용자 관리메뉴에서 로그인한 회원정보 조회
	@GetMapping("/userInfo")
	public String userInfo(Principal principal, Model model) {
		model.addAttribute("userInfo", service.getUsrInfo(principal.getName()));
		return layout(DEFAULT_LAYOUT, "userInfo");
	}

}
