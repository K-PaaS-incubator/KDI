package org.kPaas.kdi.com.config;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.ObjectPostProcessor;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 * 2024.02.27<br>
 * WebSecurityConfigurerAdapter Deprecated 대비<br>
 * @Secured, @PreAuthorize, @PostAuthorize 활성화
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity(securedEnabled = true, prePostEnabled = true) // @Secured, @PreAuthorize, @PostAuthorize 활성화
public class SecurityConfig {
	@Autowired
	private AuthenticationFailureHandler customFailureHandler;

	@Autowired
	private AuthenticationSuccessHandler customSuccessHandler;

	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	WebSecurityCustomizer webSecurityCustomizer(ObjectPostProcessor<Object> objectPostProcessor) {
		return webSecurity -> webSecurity.ignoring().antMatchers("/ignore1", "/ignore2");
	}

	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		// cors
		http.cors(cors -> cors.disable());
		// csrf
		http.csrf(csrf -> csrf.disable());
		// x frame 방어설정
		// disable 방어를 해제함으로 외부에서 iframe 접근을 허용함
		// sameOrigin() 동일 도메인 허용
		// h2 console 사용시 disable 보다 sameOrigin 권장
		http.headers(headers -> headers.frameOptions().sameOrigin());

		http.authorizeHttpRequests(//
				authReq -> authReq.requestMatchers(PathRequest.toH2Console()).permitAll() // h2 console ->개발종료시 관리자만!!!
						.anyRequest().permitAll()//
		);

		http.formLogin(login -> login.loginPage("/member/login") //
				.loginProcessingUrl("/member/loginProc") //
				.usernameParameter("usr_id") //
				.passwordParameter("usr_pw") //
				.successHandler(customSuccessHandler) //
				.failureHandler(customFailureHandler) //

		);

		http.logout(logout -> logout.logoutUrl("/member/logout") // 로그아웃 처리 URL (= form action url)
				// .logoutSuccessUrl("/login") // 로그아웃 성공 후 targetUrl,
				// logoutSuccessHandler 가 있다면 효과 없으므로 주석처리.
				.addLogoutHandler((request, response, authentication) -> {
					// 사실 굳이 내가 세션 무효화하지 않아도 됨.
					// LogoutFilter가 내부적으로 해줌.
					HttpSession session = request.getSession();
					if (session != null) {
						session.invalidate();
					}
				}) // 로그아웃 핸들러 추가
				.logoutSuccessHandler((request, response, authentication) -> {
					response.sendRedirect("/member/login");
				})//
		);
		return http.build();
	}

	@Bean
	AuthenticationManager authenticationManager(AuthenticationConfiguration auth) throws Exception {
		// Spring Security 버전업에 따른 userDetailService, passwordEncoder 명시 불필요
		return auth.getAuthenticationManager();
	}

}
