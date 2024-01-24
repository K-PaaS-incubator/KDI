package org.kPaas.kdi.service.impl;

import javax.annotation.Resource;
import org.kPaas.kdi.dto.User_VO;
import org.kPaas.kdi.mapper.Mapper_KDI;
import org.kPaas.kdi.service.UserInfoService;
import org.springframework.stereotype.Service;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Resource
	private Mapper_KDI mapper;
	
	public User_VO getUsrInfo(String usrId) {
		return mapper.getUser_Info(usrId);
	}
	
	public Integer getSameIdCheck(String usr_id) {
		return mapper.getSameIdCheck(usr_id);
	}
	
	public void signupUser(User_VO usrVo) {
		mapper.signupUser(usrVo);
	}
} 