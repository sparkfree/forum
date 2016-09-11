package com.springtest.topic.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.springtest.common.dao.GenericDao;
import com.springtest.topic.model.TBaseTopic;

@Service("topicservice")
public class TopicService {
	@Autowired
	@Qualifier("genericHibernateDao")
	private GenericDao genericHibernateDao;
	
	public List<TBaseTopic>getTopic(){
		return this.genericHibernateDao.find("from TBaseTopic t order by t.publishdate desc");
	}
}
