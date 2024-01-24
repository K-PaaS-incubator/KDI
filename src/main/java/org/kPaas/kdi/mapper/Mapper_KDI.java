package org.kPaas.kdi.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.dto.User_VO;

@Mapper
public interface Mapper_KDI {
	
	
	//로그인 사용자 조회	
	public User_VO getUser_Info(String usr_id);
	
	//아이디중복검사
	public Integer getSameIdCheck(String usr_id);
		
	//회원가입
	public void signupUser(User_VO usr_vo);
	
	
	
	

}
