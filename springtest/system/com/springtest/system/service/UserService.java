package com.springtest.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springtest.common.dao.GenericDao;
import com.springtest.common.util.DateUtil;
import com.springtest.system.model.TBaseUser;

@Service("userservice")
public class UserService {
	@Autowired
	@Qualifier("genericHibernateDao")
	private GenericDao genericHibernateDao;
	
	@Transactional
	public Boolean userregister(String nickname,String phone,String password){
		try {
			TBaseUser user=new TBaseUser();
			user.setUserid(DateUtil.FormatDateTimemi());
			user.setAccount(nickname);
			user.setPhonenumber(phone);
			user.setPassword(password);
			this.genericHibernateDao.saveOrUpdate(user);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public TBaseUser userlogin(String nickname,String password){
		List<TBaseUser>list=this.genericHibernateDao.find("from TBaseUser t where t.account=? and t.password=?", new Object[]{nickname,password});
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	
	@Transactional
	public Boolean checknickname(String nickname){
		try {
			List<TBaseUser> list=this.genericHibernateDao.find("from TBaseUser t where t.account=?",new Object[]{nickname});
			if(list!=null&&list.size()>0){
				return true;
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
