package org.kPaas.kdi.com.member.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kPaas.kdi.com.member.vo.MemberVo;

@Mapper
public interface MemberMapper {
	
	public void createTable();

	// 로그인 사용자 조회
	public MemberVo getUser_Info(@Param("usrId") String usrId);

	// 아이디중복검사
	public Integer getSameIdCheck(@Param("usrId") String usrId);

	// 회원가입
	public void signupUser(MemberVo usr_vo);

}
