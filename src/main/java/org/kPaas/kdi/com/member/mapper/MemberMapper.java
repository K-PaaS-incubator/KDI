package org.kPaas.kdi.com.member.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.member.dto.MemberVo;

@Mapper
public interface MemberMapper {
	
	
	//로그인 사용자 조회	
	public MemberVo getUser_Info(@Param("usr_id")String usr_id);
	
	//아이디중복검사
	public Integer getSameIdCheck(@Param("usr_id")String usr_id);
		
	//회원가입
	public void signupUser(MemberVo usr_vo);

	public void createTable();
}
