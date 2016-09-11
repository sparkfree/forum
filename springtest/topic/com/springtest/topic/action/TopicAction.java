package com.springtest.topic.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
}
