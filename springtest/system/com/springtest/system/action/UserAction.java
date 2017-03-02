package com.springtest.system.action;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springtest.system.model.TBaseUser;
import com.springtest.system.service.UserService;

@Controller
@RequestMapping("useraction")
public class UserAction {
	@Autowired
	@Qualifier("userservice")
	private UserService userservice;
	
	@RequestMapping(value = "/userregister.do", method = RequestMethod.POST)
	@ResponseBody
	public String userregister(String nickname,String phone,String password){
		boolean result=this.userservice.userregister(nickname, phone, password);
		if(result){
			return "register_success";
		}else{
			return "register_fail";
		}
	}
	
	@RequestMapping(value = "/userlogin.do", method = RequestMethod.POST)
	@ResponseBody
	public String userlogin(HttpSession session,String nickname,String password){
		TBaseUser user=this.userservice.userlogin(nickname, password);
		if(user!=null){
			session.setAttribute("user", user);//将用户信息保存到session中
			return "login_success";
		}else{
			return "login_fail";
		}
	}
	
	
	@RequestMapping(value = "/checknickname.do", method = RequestMethod.POST)
	@ResponseBody
	public String checknickname(String nickname){
		boolean result=this.userservice.checknickname(nickname);
		if(result){
			return "isexist";
		}else{
			return "notexist";
		}
	}
	
}
