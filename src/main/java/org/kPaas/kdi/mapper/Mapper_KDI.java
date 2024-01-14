package org.kPaas.kdi.mapper;

import org.kPaas.kdi.dto.User_VO;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.security.core.userdetails.UserDetails;

@MapperScan
public interface Mapper_KDI {
	
	/*
	 * 사용자 조회
	 */	
	public User_VO getAllUser_info();
	
	public UserDetails getAllMember_info();
	
	
	

}
