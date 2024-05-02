package org.kPaas.kdi.com.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

@Component
public class CustomAuthSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		String uri = request.getContextPath();

		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);

		String prevPage = (String) request.getSession().getAttribute("prevPage");

		if (prevPage != null) {
			request.getSession().removeAttribute("prevPage");
		}

		if (savedRequest != null) {
			uri = savedRequest.getRedirectUrl();

		} else if (prevPage != null && !prevPage.equals("")) {
			uri = prevPage;
		}

		// 로그인 성공시 페이지
		response.sendRedirect(uri);
	}
}