package org.kPaas.kdi.com.member.controller;

import java.security.Principal;

import org.json.JSONObject;
import org.kPaas.kdi.com.abs.AbstractController;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.kPaas.kdi.com.member.vo.MemberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

// @PreAuthorize("permitAll()") // 기본값이 permitAll()임으로 생략
@Controller
@RequestMapping("member")
public class MemberController extends AbstractController {

	public MemberController() {
		super("loginLayout", "member");
	}

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private UserInfoService service;

	@GetMapping("login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "exception", required = false) String exception, Model model) {
		model.addAttribute("error", error);
		model.addAttribute("exception", exception);

		return layout("login");
	}

	@GetMapping("signUp")
	public String signUp() {
		return layout("signUp");
	}

	@PostMapping("signUp")
	public ResponseEntity<String> signupUser(MemberVo user_vo) {
		// 사용자ID 암호화
		user_vo.setUsr_pw(passwordEncoder.encode(user_vo.getUsr_pw()));
		return service.signupUser(user_vo);
	}

	/**
	 * 아이디 중복체크
	 * 
	 * @param usr_id
	 */
	@PostMapping("idCheck")
	public ResponseEntity<String> idCheck(@RequestParam(name = "usr_id") String usr_id) {
		if (service.isDuplicateUserId(usr_id)) {
			return ResponseEntity.ok()
					.body(new JSONObject().put("state", false).put("msg", "사용할 수 없는 사용자ID").toString());
		}
		return ResponseEntity.ok(new JSONObject().put("state", true).put("msg", "사용할 수 있는 사용자ID").toString());
	}

	@GetMapping("forgotPw")
	public String forgotPw() {
		return layout("forgotPw");
	}

	/**
	 * 사용자 관리메뉴에서 로그인한 회원정보 조회
	 */
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자(관리자X)
	@GetMapping("userInfo")
	public String userInfo(Principal principal, Model model) {
		model.addAttribute("userInfo", service.getUsrInfo(principal.getName()));
		return layout(DEFAULT_LAYOUT, "userInfo");
	}

}
