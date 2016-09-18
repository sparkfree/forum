package com.springtest.topic.action;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springtest.system.model.TBaseUser;
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
	
	@RequestMapping(value = "/getmytopic.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TBaseTopic>getMyTopic(HttpSession session){
		TBaseUser user=(TBaseUser)session.getAttribute("user");
		return this.topicservice.getMyTopic(user.getUserid());
	}
	
}
