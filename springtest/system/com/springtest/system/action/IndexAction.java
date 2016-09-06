package com.springtest.system.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexAction {
	@RequestMapping("/index.do")
	public String urlIndex(HttpServletRequest request, HttpSession session) {
		if (session.getAttribute("user") == null) {//
			return "../../login";
		} else {
			return "../../index";
		}
	}
	/**
	 * http://127.0.0.1:8080/springtest/login.do∑√Œ µÿ÷∑
	 * @param request
	 * @return
	 */
	@RequestMapping("/login.do")
	public String urlLogin(HttpServletRequest request) {
		return "../page/system/login";
	}
}
