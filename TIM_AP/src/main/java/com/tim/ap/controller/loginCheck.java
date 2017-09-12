package com.tim.ap.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Controller
@RequestMapping("/loginCheck")
public class loginCheck extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session  = request.getSession();
		System.out.println("로그인 체크!");
		if(session.getAttribute("id") == null) {
			response.sendRedirect(request.getContextPath()+"/member/loginform");
			return false;
		}
		return true;
	}
}
