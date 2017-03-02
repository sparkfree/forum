package com.springtest.topic.service;

import java.math.BigInteger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springtest.common.dao.GenericDao;
import com.springtest.topic.model.TBaseComment;
import com.springtest.topic.model.TBaseTopic;

@Service("topicservice")
public class TopicService {
	@Autowired
	@Qualifier("genericHibernateDao")
	private GenericDao genericHibernateDao;
	
	public List<TBaseTopic>getTopic(){
		return this.genericHibernateDao.find("from TBaseTopic t order by t.publishdate desc");
	}
	
	@Transactional
	public List<TBaseTopic>getTopics(int page,int rows){
		List list=this.genericHibernateDao.find("from TBaseTopic t order by t.publishdate desc",page,rows);
		return list;
		//return this.genericHibernateDao.find("from TBaseTopic t order by t.publishdate desc", rows, page);
	}
	
	@Transactional
	public Integer gettopicsum(){
		return ((BigInteger)this.genericHibernateDao.getObjectBySQL("select count(id) from t_base_topic")).intValue();
	}
	
	@Transactional
	public void updatehearts(String id,String heart){
		boolean result=this.genericHibernateDao.executSQL("update t_base_topic set heart=? where id=?", new Object[]{heart,id});
	}
	
	public List<TBaseTopic>getMyTopic(String userid){
		return this.genericHibernateDao.find("from TBaseTopic t where t.userid=? order by t.publishdate desc",new Object[]{userid});
	}
	
	@Transactional
	public List<TBaseTopic>getHotTopic(){
		return this.genericHibernateDao.find("from TBaseTopic t order by t.heart desc",0,3);
	}
	
	public List<TBaseComment>getcomments(String id){
		return this.genericHibernateDao.find("from TBaseComment t where t.fkid=?",new Object[]{id});
	}
	
	public boolean addcomment(TBaseComment comm){
		try {
			this.genericHibernateDao.save(comm);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
