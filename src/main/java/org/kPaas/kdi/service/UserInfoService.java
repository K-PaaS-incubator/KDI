package org.kPaas.kdi.service;

import org.kPaas.kdi.dto.User_VO;

public interface UserInfoService {
	
	public User_VO getUsrInfo(String usr_id) ;
	
	public Integer getSameIdCheck(String usr_id);
	
	public void signupUser(User_VO usr_vo) ;
}
