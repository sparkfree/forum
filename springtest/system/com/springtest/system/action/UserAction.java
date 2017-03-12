package com.springtest.system.action;

import javax.servlet.http.HttpServletRequest;
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
	
	/**
	 * my profile
	 * @param request
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/myprofile.do",method=RequestMethod.GET)
	public String urlLogin(HttpServletRequest request,HttpSession session) {
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		if(user==null){
			return "../../login";//跳转至登录页面（因为spring-servlet.xml文件中配置的路径是/WEB-INF/page/）
		}else{
			return "/system/myprofile";
		}
	}
	
	@RequestMapping(value = "/userregister.do", method = RequestMethod.POST)
	@ResponseBody
	public String userregister(HttpSession session,String nickname,String phone,String password){
		boolean result=this.userservice.userregister(session,nickname, phone, password);
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
	
	/**
	 * 更新用户信息
	 * @param userid
	 * @param nickname
	 * @param username
	 * @param phone
	 * @param email
	 * @param hobby
	 * @return
	 */
	@RequestMapping(value = "/updateuser.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateuser(HttpSession session,String userid,String nickname,String username,String phone,String email,String hobby){
		TBaseUser user=this.userservice.findUserById(userid);
		if(user!=null){
			user.setNickname(nickname);
			user.setUsername(username);
			user.setPhonenumber(phone);
			user.setEmail(email);
			user.setHobby(hobby);
		}
		if(this.userservice.updateuser(user)){
			session.setAttribute("user", user);//将session中的user信息更新
			return "success";
		}else{
			return "fail";
		}
	}
	
}
