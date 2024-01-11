package org.kPaas.kdi.service.impl;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	 @Override
	    @Transactional(readOnly = true)
	    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
	        return toUserDetails(email);
	    }

	    private UserDetails toUserDetails(String email) {
	        return User.builder()
	                .username(email)
	                .password("$2a$10$99aMDIR613cYJfBfYO.CR.CPF7kQWHwzgoH/vwew/lrCol72y8eNm")
	                .authorities(new SimpleGrantedAuthority("ROLE_ADMIN"))
	                .build();
	    }
}
