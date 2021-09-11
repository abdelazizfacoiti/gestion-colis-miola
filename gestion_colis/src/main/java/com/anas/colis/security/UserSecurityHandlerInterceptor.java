package com.anas.colis.security;

import java.security.PublicKey;

import javax.naming.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.anas.colis.services.AuthService;
@Service
public class UserSecurityHandlerInterceptor extends HandlerInterceptorAdapter {
	
	private final org.apache.logging.log4j.Logger log = LogManager.getLogger(getClass());

	private static final String AUTH_HEADER_PARAMETER_AUTHERIZATION = "authorization";

	private static final String AUTH_HEADER_PARAMETER_BEARER= "Bearer";
	
	@Autowired
	private AuthService authService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String jwtAuthToken = null;
		PublicKey tokenPublicKey = null;

		log.info("[Inside PRE Handle interceptor][" + request + "]" + "[" + request.getMethod() + "]"
				+ request.getRequestURI());

		try {

			// Get JWT token from header value
			jwtAuthToken = request.getHeader(AUTH_HEADER_PARAMETER_AUTHERIZATION).replace(AUTH_HEADER_PARAMETER_BEARER,"");
			// Fetching AUTH token public key from resource folder
			tokenPublicKey = authService.getAuthPublicKey();
			// Validate JWT token using public key
			return authService.validateJwtToken(jwtAuthToken, tokenPublicKey);

		} catch (Exception e) {
			log.error("Error occured while authenticating request : " + e.getMessage());
		}

		response.setStatus(HttpStatus.UNAUTHORIZED.value());
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		log.info("[Inside POST Handle Interceptor]" + request.getRequestURI());

	}

}