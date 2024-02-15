package org.kPaas.kdi.com.member.controller;

import java.security.Principal;

import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.member.dto.MemberVo;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
	@PostMapping(noAuth + "idCheck")
	public @ResponseBody int idCheck(String usr_id) {
		int result = service.getSameIdCheck(usr_id);
		return result;

	}
	@PostMapping("/signUpProc")
	//responseEntity는 rest api짤 때 리턴타입이랑 구문 출력이 가능
	/*  ok는 http 200(성공메시지)을 전달하고
		badRequest()는 400에러를 전달하고 body를 이용해서 
		왜 실패한건지 전달하는 구조 */
	public ResponseEntity<String> signupUser(MemberVo user_vo) {
		int idCnt = 0;
		idCnt = service.getSameIdCheck(user_vo.getUsr_id());
		if (idCnt > 0) {
			//return layout("signUp");
			return ResponseEntity.badRequest().body("중복아이디입니다.");
		} else {
			user_vo.setUsr_pw(passwordEncoder.encode(user_vo.getUsr_pw()));
			service.signupUser(user_vo);
			//return layout("login");
			return ResponseEntity.ok("회원가입 완료");
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
