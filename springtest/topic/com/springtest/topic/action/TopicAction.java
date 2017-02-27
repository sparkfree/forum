package com.springtest.topic.action;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	
	@RequestMapping(value = "/gettopics.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>gettopics(int page,int rows){
		return this.topicservice.getTopics(page,rows);
	}
	
	@RequestMapping(value = "/getmytopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getMyTopic(HttpSession session){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		return this.topicservice.getMyTopic(user.getUserid());
	}
	
	@RequestMapping(value = "/getcomment.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseComment> getcomment(String id){
		return this.topicservice.getcomments(id);
	}
	
	@RequestMapping(value = "/addcomment.do", method = RequestMethod.POST)
	@ResponseBody
	public String addcomment(HttpSession session,String id,String com){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		TBaseComment comment=new TBaseComment();
		comment.setId(DateUtil.FormatDateTimemi());
		comment.setFkid(id);
		comment.setContent(com);
		comment.setTime(new Date());
		comment.setUserid(user.getUserid());
		comment.setUsername(user.getUsername());
	    if(this.topicservice.addcomment(comment)){
	    	return "success";
	    }else{
	    	return "fail";
	    }
	}
}
