package org.kPaas.kdi.com.member.service.impl;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.json.JSONObject;
import org.kPaas.kdi.com.member.mapper.MemberMapper;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.kPaas.kdi.com.member.vo.MemberVo;
import org.kPaas.kdi.com.tool.service.DBCheckService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Resource
	private MemberMapper mapper;

	@Resource
	private DBCheckService dbCheckService;

	public MemberVo getUsrInfo(String usrId) {
		return mapper.getUser_Info(usrId);
	}

	/**
	 * @return true : 중복 아이디<br>
	 *         false : 사용가능한 아이디
	 */
	public boolean isDuplicateUserId(String usr_id) {
		Integer result = mapper.getSameIdCheck(usr_id);
		return null == result || 0 != result;
	}

	public ResponseEntity<String> signupUser(MemberVo usrVo) {
		JSONObject result = new JSONObject();
		if (null == usrVo) {
			result.put("state", "회원가입 실패");
			result.put("msg", "입력정보 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		if (null == usrVo.getUsrId()) {
			result.put("state", "회원가입 실패");
			result.put("msg", "사용자ID 확인불가");
			return ResponseEntity.badRequest().body(result.toString());
		}
		if (isDuplicateUserId(usrVo.getUsrId())) {
			result.put("state", "회원가입 실패");
			result.put("msg", "중복 사용자ID");
			return ResponseEntity.badRequest().body(result.toString());
		}
		mapper.signupUser(usrVo);
		result.put("state", "회원가입 성공");
		return ResponseEntity.ok(result.toString());
	}

	/**
	 * 최초 기동시에 사용자테이블(KDI_USER)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 사용자테이블을 생성하는 기
	 */
	@PostConstruct
	private void init() {
		if (!dbCheckService.isExists("KDI_USER")) {
			mapper.createTable();
		}
	}
}