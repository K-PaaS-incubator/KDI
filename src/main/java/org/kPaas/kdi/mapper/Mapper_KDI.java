package org.kPaas.kdi.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.kPaas.kdi.dto.User_VO;

@Mapper
public interface Mapper_KDI {
	
	/*
	 * 사용자 조회
	 */	
	public User_VO getUser_Info(String usr_id);
	
	
	

}
