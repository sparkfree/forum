package com.springtest.topic.action;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

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

import com.springtest.common.util.DateUtil;
import com.springtest.system.model.TBaseUser;
import com.springtest.system.service.UserService;
import com.springtest.topic.model.TBaseComment;
import com.springtest.topic.model.TBaseTopic;
import com.springtest.topic.service.TopicService;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

@Controller
@RequestMapping("topicaction")
public class TopicAction {
	@Autowired
	@Qualifier("topicservice")
	private TopicService topicservice;
	//github lovekang lsk950821
	
	@Autowired
	@Qualifier("userservice")
	private UserService userservice;
	
	@RequestMapping(value = "/gettopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getTopic(){
		return this.topicservice.getTopic();
	}
	
	@RequestMapping(value = "/gettopicbyid.do", method = RequestMethod.POST)
	@ResponseBody
	public TBaseTopic gettopicbyid(String id){
		TBaseTopic topic=null;
		try {
			topic=this.topicservice.getTopicById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return topic;
	}
	
	@RequestMapping(value = "/gettopics.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>gettopics(int page,int rows){
		List<TBaseTopic>list=this.topicservice.getTopics(page, rows);
		for (TBaseTopic topic : list) {
			String userid=topic.getUserid();
			TBaseUser user=this.userservice.findUserById(userid);
			topic.setUserface(user.getUserface());
		}
		return list;
	}
	
	@RequestMapping(value = "/gettopicsum.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer gettopicsum(){
		return this.topicservice.gettopicsum();
	}
	
	/**
	 * 查询评论总数
	 * @param fkid
	 * @return
	 */
	@RequestMapping(value = "/getcommentsum.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer getcommentsum(String fkid){
		return this.topicservice.getcommentsum(fkid);
	}
	
	@RequestMapping(value = "/updatehearts.do", method = RequestMethod.POST)
	@ResponseBody
	public void updatehearts(String id,String heart){
		this.topicservice.updatehearts(id,heart);
	}
	
	@RequestMapping(value = "/getmytopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getMyTopic(HttpSession session,int page,int rows){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		return this.topicservice.getMyTopic(user.getUserid(),page,rows);
	}
	
	@RequestMapping(value = "/getmytopicsum.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer getmytopicsum(HttpSession session){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		return this.topicservice.getmytopicsum(user.getUserid());
	}
	
	@RequestMapping(value = "/getHotTopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getHotTopic(){
		List<TBaseTopic>list=this.topicservice.getHotTopic();
		for (TBaseTopic topic : list) {
			String userid=topic.getUserid();
			TBaseUser user=this.userservice.findUserById(userid);
			topic.setUserface(user.getUserface());
		}
		return list;
	}
	
	@RequestMapping(value = "/getRecentTopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getRecentTopic(){
		return this.topicservice.getRecentTopic();
	}
	
	@RequestMapping(value = "/getcomment.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseComment> getcomment(String id){
		return this.topicservice.getcomments(id);
	}
	
	//跳转至topic评论页面
	@RequestMapping(value="/topiccomment.do",method=RequestMethod.GET)
	public String topiccomment(HttpServletRequest request,HttpSession session,String tid){
		request.setAttribute("tid", tid);
		return "/topic/topiccomment";
	}
	
	//跳转至topic评论页面
	@RequestMapping(value="/topicjson.do",method=RequestMethod.GET)
	@ResponseBody	
	public void topicjson(HttpSession session,HttpServletRequest request,HttpServletResponse response){
		List<TBaseTopic>topiclist=this.topicservice.getAllTopic();
		for (TBaseTopic tBaseTopic : topiclist) {
			tBaseTopic.setPublishdatestr(DateUtil.formatDate(tBaseTopic.getPublishdate(), "yyyy-MM-dd HH:mm"));
		}
		JSONArray array=JSONArray.fromObject(topiclist);
		response.setContentType("text/json;charset=utf-8");//设置编码
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (Exception e) {
		}
		out.print(array.toString());
	}
	
	/**
	 * 查询评论
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/getcommentbyid.do",method=RequestMethod.POST)
	@ResponseBody	
	public List<TBaseComment>getcommentbyid(String id,int page,int rows){
		return this.topicservice.getcommentbyid(id,page,rows);
	}
	
	@RequestMapping(value="/addcomment.do",method=RequestMethod.POST)
	@ResponseBody	
	public String addcomment(HttpSession session,String comment,String fkid){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		TBaseComment comm=new TBaseComment();
		comm.setId(DateUtil.FormatDateTimemi());
		comm.setFkid(fkid);
		comm.setUserid(user.getUserid());
		comm.setUsername(user.getNickname());//昵称
		comm.setContent(comment);//评论
		comm.setTime(new Date());
		if(this.topicservice.addcomment(comm)){
			return "success";
		}else{
			return "fail";
		}
	}
	
	@RequestMapping(value="/updatecomment.do",method=RequestMethod.POST)
	@ResponseBody	
	public void updatecomment(String id){
		this.topicservice.updatecomment(id);
	}
	
	@RequestMapping(value="/addtopic.do",method=RequestMethod.POST)
	@ResponseBody	
	public String addtopic(HttpSession session,HttpServletRequest request,String comment){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		TBaseTopic topic=new TBaseTopic();
		String id=DateUtil.FormatDateTimemi();
		topic.setId(id);
		topic.setTopic(comment);
		topic.setComment(0);
		topic.setHeart(0);
		topic.setUserid(user.getUserid());
		topic.setNickname(user.getNickname());
		topic.setPublishdate(new Date());
		if(this.topicservice.addtopic(topic)){
			//上传图片文件
			this.uploadimage(session,request,id);
			return "success";
		}else{
			return "fail";
		}
	}
	
	public boolean uploadimage(HttpSession session,HttpServletRequest request,String topicid){
		boolean result=true;
		try {
			String filefolderpath = session.getServletContext().getRealPath("");
			filefolderpath += File.separator + "upload" + File.separator+ "topicimg" + File.separator;
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
					// 文件名：
					if (name.lastIndexOf(".") >= 0) {
						preName = name.substring(0, name.lastIndexOf("."));
					}
					// 扩展名格式：
					if (name.lastIndexOf(".") >= 0) {
						extName = name.substring(name.lastIndexOf(".")).toLowerCase();
					}
					if (extName.equals(".bmp") ||extName.equals(".gif") ||extName.equals(".jpg") || extName.equals(".jpeg")) {// 是Image
						filename = topicid+ DateUtil.formatDate(new Date(),"yyyyMMddHHmmssSSS");
						File saveFile = new File(filefolderpath + filename+ extName);
						item.write(saveFile);//写入文件
//						TopicImage image=new TopicImage();
//						image.setId(DateUtil.FormatDateTimemi());
//						image.setPrename(preName);
//						image.setExtname(extName);
//						image.setUrl(filename+extName);
//						image.setTopicid(topicid);
//						this.topicservice.addtopicimg(image);
					} else {
						result=false;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			result=false;
		}
		return result;
	}
	private Image img;
	@RequestMapping(value = "/uploadimage.do", method = RequestMethod.POST)
	@ResponseBody
	public String uploadimage(HttpServletRequest request,HttpSession session) {
		Map map=new HashedMap();
		String preName = "";
		String extName = "";
		String filename = "";
		String filefolderpath="";
		String str="";
		try {
			filefolderpath = session.getServletContext().getRealPath("");
			filefolderpath += File.separator + "upload" + File.separator+ "topicimage" + File.separator;
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("UTF-8");
			List fileList = upload.parseRequest(request);
			Iterator it = fileList.iterator();
			String name = null;
			while (it.hasNext()) {
				FileItem item = (FileItem) it.next();
				if (!item.isFormField()) {
					name = item.getName();
					long size = item.getSize();
					String type = item.getContentType();
					if (name == null || name.trim().equals("")) {
						continue;
					}
					// 文件名：
					if (name.lastIndexOf(".") >= 0) {
						preName = name.substring(0, name.lastIndexOf("."));
					}
					// 扩展名格式：
					if (name.lastIndexOf(".") >= 0) {
						extName = name.substring(name.lastIndexOf(".")).toLowerCase();
					}
					if (extName.equals(".bmp") ||extName.equals(".gif") ||extName.equals(".jpg") || extName.equals(".jpeg")) {// 是Image
						filename =DateUtil.formatDate(new Date(),
										"yyyyMMddHHmmssSSS");
						File saveFile = new File(filefolderpath + filename
								+ extName);
						item.write(saveFile);//写入文件
						File file = new File(filefolderpath + filename+ extName);//再次读入文件  
				        img = ImageIO.read(file);      // 构造Image对象  
				        this.resize(200, 200, filefolderpath + filename+ extName);//压缩
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		str="http://hiweshare.com/upload/topicimage/"+filename+extName;
		return "{\"code\": 0,\"msg\": \"\",\"data\": {\"src\": \""+str+"\"}}";
	}
	
	//压缩文件操作
	 public void resize(int w, int h,String filepath) throws IOException {  
	        // SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢  
	        BufferedImage image = new BufferedImage(w, h,BufferedImage.TYPE_INT_RGB );   
	        image.getGraphics().drawImage(img, 0, 0, w, h, null); // 绘制缩小后的图  
	        File destFile = new File(filepath);  
	        FileOutputStream out = new FileOutputStream(destFile); // 输出到文件流  
	        // 可以正常实现bmp、png、gif转jpg  
	        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
	        encoder.encode(image); // JPEG编码  
	        img=null;
	        out.flush();
	        out.close();  
	    }  
	
	@RequestMapping(value="/deletetopic.do",method=RequestMethod.POST)
	@ResponseBody
	public String deletetopic(String tid){
		if(this.topicservice.deletetopic(tid)){
			return "success";
		}else{
			return "fail";
		}
	}
}
