package com.springtest.topic.action;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springtest.common.util.DateUtil;
import com.springtest.system.model.TBaseUser;
import com.springtest.topic.model.TBaseComment;
import com.springtest.topic.model.TBaseTopic;
import com.springtest.topic.service.TopicService;

@Controller
@RequestMapping("topicaction")
public class TopicAction {
	@Autowired
	@Qualifier("topicservice")
	private TopicService topicservice;
	//github lovekang lsk950821
	
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
		return this.topicservice.getTopics(page,rows);
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
	public List<TBaseTopic>getMyTopic(HttpSession session){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		return this.topicservice.getMyTopic(user.getUserid());
	}
	
	@RequestMapping(value = "/getHotTopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getHotTopic(){
		return this.topicservice.getHotTopic();
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
		String str=JSONObject.fromObject(topiclist.get(0)).toString();
		String strs=JSONArray.fromObject(topiclist).toString();
		String s="";
		try {
			s=URLDecoder.decode(str,"UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return s;
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (Exception e) {
		}
		out.print(strs);
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
	
}
