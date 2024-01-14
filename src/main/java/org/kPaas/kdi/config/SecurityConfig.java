package org.kPaas.kdi.config;

import org.kPaas.kdi.service.impl.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
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
    public PasswordEncoder passwordEncoder() {
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
		.antMatchers("/login","/error").permitAll()
		.antMatchers("/test").hasAnyRole("ADMIN")
		.anyRequest().authenticated()
		.and()
		.formLogin()
		.loginPage("/login")
		.loginProcessingUrl("/loginProc")
		.permitAll()
		.usernameParameter("usrId")
        .passwordParameter("usrPw")
		.defaultSuccessUrl("/test")  
		.failureHandler(customFailureHandler)
		.successHandler(customSuccessHandler);

	}
	
	@Bean
    public CorsConfigurationSource corsConfigurationSource() {
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