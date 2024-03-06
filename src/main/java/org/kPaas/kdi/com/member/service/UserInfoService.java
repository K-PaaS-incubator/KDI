package org.kPaas.kdi.com.member.service;

import org.kPaas.kdi.com.member.vo.MemberVo;
import org.springframework.http.ResponseEntity;

public interface UserInfoService {

	public MemberVo getUsrInfo(String usr_id);

	/**
	 * @return true : 중복 아이디<br>
	 *         false : 사용가능한 아이디
	 */
	public boolean isDuplicateUserId(String usr_id);

	public ResponseEntity<String> signupUser(MemberVo usr_vo);
}
