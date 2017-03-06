package com.springtest.system.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springtest.common.util.DateUtil;
import com.springtest.system.model.TBaseUser;
import com.springtest.system.service.LoginService;

@Controller
@RequestMapping("")
public class LoginAction {
	@Autowired
	@Qualifier("loginservice")
	private LoginService loginservice;
	//��¼
	@RequestMapping("/userlogin.do")
	public void login(PrintWriter out, HttpServletRequest request,
			HttpServletResponse response, HttpSession session, String account,
			String password) {
		String dispatcherurl = "login.do";
		try {
			TBaseUser user=this.loginservice.findTBaseUser(account, password);
			if(user!=null){
				dispatcherurl = "index.do";
				session.setAttribute("user", user);
			}
			response.sendRedirect(dispatcherurl);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//ע��
	@RequestMapping("/userregister.do")
	public void register(PrintWriter out,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		String nickname=request.getParameter("account");
		String password=request.getParameter("password");
		String phonenumber=request.getParameter("phonenumber");
		TBaseUser user=new TBaseUser();
		user.setUserid(DateUtil.FormatDateTimemi());
		user.setNickname(nickname);//�˻�
		user.setPassword(password);//����
		user.setPhonenumber(phonenumber);//�绰����
		Boolean result=this.loginservice.addTBaseUser(user);
		if(result==true){//ע��ɹ�
			out.print("success");
		}else{//ע��ʧ��
			out.print("fail");
		}
	}
	@RequestMapping(value = "/updatemyinfo.do", method = RequestMethod.POST)
	@ResponseBody
	public TBaseUser updatemyinfo(String userid,String username,String phonenumber,String email,String address){
		TBaseUser user=this.loginservice.findTBaseUser(userid);
		if(user!=null){
			user.setUsername(username);
			user.setPhonenumber(phonenumber);
			user.setEmail(email);
			user.setAddress(address);
			boolean result=this.loginservice.addTBaseUser(user);
			if(result==true){
				return user;
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = "/getmyinfo.do", method = RequestMethod.POST)
	@ResponseBody
	public TBaseUser getmyinfo(String userid){
		TBaseUser user=this.loginservice.findTBaseUser(userid);
		if(user!=null){
			return user;
		}else{
			return null;
		}
	}
	
	//�ϴ��ļ�
	@RequestMapping(value = "/uploadfile.do", method = RequestMethod.POST)
	public void uploadUserFace(PrintWriter out, HttpServletRequest request,HttpSession session) {
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
						filename =DateUtil.formatDate(new Date(),"yyyyMMddHHmmssSSS");
						File saveFile = new File(filefolderpath + filename+ extName);
						item.write(saveFile);
						out.print("{\"flag\":\"success\",\"faceimagepath\":\""+ filename + extName + "\"}");
					} else {
						out.print("{\"flag\":\"typeerror\"}");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.print("{\"flag\":\"error\"}");
		} finally {
			out.flush();
			out.close();
		}
	}
}
