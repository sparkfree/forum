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
	public Integer getmytopicsum(String userid){
		return ((BigInteger)this.genericHibernateDao.getObjectBySQL("select count(id) from t_base_topic where userid='"+userid+"'")).intValue();
	}
	
	/**
	 * 查询评论总数
	 * @param fkid
	 * @return
	 */
	@Transactional
	public Integer getcommentsum(String fkid){
		return ((BigInteger)this.genericHibernateDao.getObjectBySQL("select count(id) from t_base_comment where fkid=?",new Object[]{fkid})).intValue();
	}
	
	@Transactional
	public void updatehearts(String id,String heart){
		boolean result=this.genericHibernateDao.executSQL("update t_base_topic set heart=? where id=?", new Object[]{heart,id});
	}
	
	@Transactional
	public List<TBaseTopic>getMyTopic(String userid,int page,int rows){
		return this.genericHibernateDao.find("from TBaseTopic t where t.userid=? order by t.publishdate desc",new Object[]{userid},page,rows);
	}
	
	@Transactional
	public List<TBaseTopic>getHotTopic(){
		return this.genericHibernateDao.find("from TBaseTopic t order by t.heart desc",0,5);
	}
	
	@Transactional
	public List<TBaseTopic>getRecentTopic(){
		return this.genericHibernateDao.find("from TBaseTopic t order by t.publishdate desc",0,5);
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
	
	@Transactional
	public TBaseTopic getTopicById(String id)throws Exception{
		return (TBaseTopic)this.genericHibernateDao.get(TBaseTopic.class, id);
	}
	
	@Transactional
	public List<TBaseTopic>getAllTopic(){
		return this.genericHibernateDao.find("from TBaseTopic");
	}
	
	@Transactional
	public List<TBaseComment>getcommentbyid(String id,int page,int rows){
		return this.genericHibernateDao.find("from TBaseComment t where t.fkid=?",new Object[]{id},page,rows);
	}
	
	@Transactional
	public void updatecomment(String id){
		int comnum=((BigInteger)this.genericHibernateDao.getObjectBySQL("select count(id) from t_base_comment where fkid=?",new Object[]{id})).intValue();//查询评论数
		this.genericHibernateDao.executSQL("update t_base_topic t set t.comment=? where t.id=?", new Object[]{comnum,id});
	}
	
	@Transactional
	public Boolean addtopic(TBaseTopic topic){
		try {
			this.genericHibernateDao.saveOrUpdate(topic);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional
	public Boolean deletetopic(String tid){
		try {
			this.genericHibernateDao.executSQL("delete from t_base_topic where id=?", new Object[]{tid});
			this.genericHibernateDao.executSQL("delete from t_base_comment where fkid=?", new Object[]{tid});
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
