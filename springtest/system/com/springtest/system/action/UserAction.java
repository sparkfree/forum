package com.springtest.system.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.springtest.common.util.DateUtil;
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
			return "../../login";//��ת����¼ҳ�棨��Ϊspring-servlet.xml�ļ������õ�·����/WEB-INF/page/��
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
			session.setAttribute("user", user);//���û���Ϣ���浽session��
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
	 * �����û���Ϣ
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
			session.setAttribute("user", user);//��session�е�user��Ϣ����
			return "success";
		}else{
			return "fail";
		}
	}
	
	@RequestMapping(value = "/uploaduserface.do", method = RequestMethod.POST)
	@ResponseBody
	public Map uploadUserFace(HttpServletRequest request,HttpSession session, String userid) {
		Map map=new HashedMap();
		try {
			String filefolderpath = session.getServletContext().getRealPath("");
			filefolderpath += File.separator + "upload" + File.separator+ "userface" + File.separator;
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("UTF-8");
			List fileList = upload.parseRequest(request);
			Iterator it = fileList.iterator();
			String name = null;
			String preName = null;
			String extName = null;
			String filename = null;
			while (it.hasNext()) {
				FileItem item = (FileItem) it.next();
				if (!item.isFormField()) {
					name = item.getName();
					long size = item.getSize();
					String type = item.getContentType();
					if (name == null || name.trim().equals("")) {
						continue;
					}
					// �ļ�����
					if (name.lastIndexOf(".") >= 0) {
						preName = name.substring(0, name.lastIndexOf("."));
					}
					// ��չ����ʽ��
					if (name.lastIndexOf(".") >= 0) {
						extName = name.substring(name.lastIndexOf(".")).toLowerCase();
					}
					if (extName.equals(".bmp") ||extName.equals(".gif") ||extName.equals(".jpg") || extName.equals(".jpeg")) {// ��Image
						filename = userid
								+ DateUtil.formatDate(new Date(),
										"yyyyMMddHHmmssSSS");
						File saveFile = new File(filefolderpath + filename
								+ extName);
						item.write(saveFile);
						TBaseUser user=this.userservice.findUserById(userid);
						user.setUserface(filename+extName);
						this.userservice.updateuser(user);//�����û���Ϣ
						session.setAttribute("user", user);//����session�е��û���Ϣ
						map.put("flag", "success");
						map.put("faceimagepath", filename + extName);
					} else {
						map.put("flag", "typeerror");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("flag", "error");
		}
		return map;
	}
}
