package org.kPaas.kdi.com.config;

import javax.servlet.http.HttpSession;

import org.kPaas.kdi.com.member.service.impl.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Autowired
	UserDetailsServiceImpl userDetailService;
	
	@Autowired
	AuthenticationFailureHandler customFailureHandler;
	
	@Autowired
	AuthenticationSuccessHandler customSuccessHandler;
	
	@Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	@Override
	public void configure(WebSecurity web){
		web.ignoring().antMatchers("/css/**","/js/**","/img/**");
	}

	@Override
	public void configure(HttpSecurity http) throws Exception {
		http.headers().frameOptions().disable().and()
        .csrf().disable()  
		.authorizeRequests()
		.requestMatchers(PathRequest.toH2Console()).permitAll()
		.antMatchers("/login","/error","/signUp*","/forgotPw","/api/noAuth/*").permitAll()
		.antMatchers("/test").hasAnyRole("ADMIN")
		.anyRequest().authenticated()
		.and()
		.formLogin()
		.loginPage("/login")
		.loginProcessingUrl("/loginProc")
		.permitAll()
		.usernameParameter("usr_id")
        .passwordParameter("usr_pw") 
		.failureHandler(customFailureHandler)
		.successHandler(customSuccessHandler)
        .and()
        .logout()
        .logoutUrl("/logout")   // 로그아웃 처리 URL (= form action url)
        //.logoutSuccessUrl("/login") // 로그아웃 성공 후 targetUrl, 
        // logoutSuccessHandler 가 있다면 효과 없으므로 주석처리.
        .addLogoutHandler((request, response, authentication) -> { 
            // 사실 굳이 내가 세션 무효화하지 않아도 됨. 
            // LogoutFilter가 내부적으로 해줌.
            HttpSession session = request.getSession();
            if (session != null) {
                session.invalidate();
            }
        })  // 로그아웃 핸들러 추가
        .logoutSuccessHandler((request, response, authentication) -> {
            response.sendRedirect("/login");
        });

	}
	
	@Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();

        configuration.addAllowedOrigin("*");
        configuration.addAllowedHeader("*");
        configuration.addAllowedMethod("*");
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
	
	@Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailService)
                .passwordEncoder(passwordEncoder());
    }

}
