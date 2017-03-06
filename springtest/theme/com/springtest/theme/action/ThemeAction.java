package com.springtest.theme.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springtest.theme.service.ThemeService;

@Controller
@RequestMapping("themeaction")
public class ThemeAction {
	@Autowired
	@Qualifier("themeservice")
	private ThemeService themeservice;
	
	public String addtheme(){
		return "";
	}
	
}
