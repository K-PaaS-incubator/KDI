package org.kPaas.kdi.com.member.service;

import org.kPaas.kdi.com.member.dto.MemberVo;

public interface UserInfoService {
	
	public MemberVo getUsrInfo(String usr_id) ;
	
	public Integer getSameIdCheck(String usr_id);
	
	public void signupUser(MemberVo usr_vo) ;
}
