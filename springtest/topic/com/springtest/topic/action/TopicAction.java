package com.springtest.topic.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springtest.topic.service.TopicService;

@Controller
@RequestMapping("")
public class TopicAction {
	@Autowired
	@Qualifier("topicservice")
	private TopicService topicservice;
	//github lovekang lsk950821
	
	
}
