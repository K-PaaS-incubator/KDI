package org.kPaas.kdi.service.impl;

import org.kPaas.kdi.dto.User_VO;
import org.kPaas.kdi.mapper.Mapper_KDI;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	private Mapper_KDI mapper;
	User_VO userVo;
	
	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String usrId) throws UsernameNotFoundException {
		// USER_VO = DB조회(email)
		// if(USER_VO == null)
		// UsernameNotFoundException
		// return toUserDetails(USER_VO)
		userVo.setUsrId(usrId);
		if (userVo == null) {
			System.out.println("여기에러");
			throw new UsernameNotFoundException(usrId);
		}
		//return toUserDetails(user.getUsrId());
		return toUserDetails(usrId);
	}

	private UserDetails toUserDetails(String usrId) {
		System.out.println("제발 여기");
		return User.builder().username(usrId).password("$2a$10$99aMDIR613cYJfBfYO.CR.CPF7kQWHwzgoH/vwew/lrCol72y8eNm")
				.authorities(new SimpleGrantedAuthority("ROLE_ADMIN")).build();
	}
}
