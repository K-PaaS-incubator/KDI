package org.kPaas.kdi.com.member.service.impl;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.kPaas.kdi.com.member.dto.MemberVo;
import org.kPaas.kdi.com.member.mapper.MemberMapper;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.kPaas.kdi.com.tool.service.DBCheckService;
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

	public Integer getSameIdCheck(String usr_id) {
		return mapper.getSameIdCheck(usr_id);
	}

	public void signupUser(MemberVo usrVo) {
		mapper.signupUser(usrVo);
	}

	/**
	 * 최초 기동시에 사용자테이블(KDI_USER)의 유무를 확인하고<br>
	 * 해당 테이블이 없으면 사용자테이블을 생성하는 기
	 */
	@PostConstruct
	private void init() {
		if(!dbCheckService.isExists("KDI_USER")) {
			mapper.createTable();
		}
	}
}