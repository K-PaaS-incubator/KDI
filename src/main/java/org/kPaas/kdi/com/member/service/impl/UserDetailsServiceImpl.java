package org.kPaas.kdi.com.member.service.impl;

import org.kPaas.kdi.com.member.dto.MemberVo;
import org.kPaas.kdi.com.member.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	private UserInfoService service;
	
	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String usr_id) throws UsernameNotFoundException {
		MemberVo userVo = service.getUsrInfo(usr_id);
		
		if (userVo == null) {
			throw new UsernameNotFoundException(usr_id);
		}
		return toUserDetails(userVo);
	}

	private UserDetails toUserDetails(MemberVo userVo) {
		return User.builder().username(userVo.getUsr_id()).password(userVo.getUsr_pw())
				.authorities(new SimpleGrantedAuthority("ROLE_ADMIN")).build();
	}
}
