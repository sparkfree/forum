package com.springtest.system.service;

import java.util.List;

import javax.servlet.http.HttpSession;

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
	
	/**
	 * user register
	 * @param nickname
	 * @param phone
	 * @param password
	 * @return
	 */
	@Transactional
	public Boolean userregister(HttpSession session,String nickname,String phone,String password){
		try {
			TBaseUser user=new TBaseUser();
			user.setUserid(DateUtil.FormatDateTimemi());
			user.setNickname(nickname);
			user.setPhonenumber(phone);
			user.setPassword(password);
			this.genericHibernateDao.saveOrUpdate(user);
			session.setAttribute("user", user);//将用户信息保存到session中
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * user login
	 * @param nickname
	 * @param password
	 * @return
	 */
	public TBaseUser userlogin(String nickname,String password){
		List<TBaseUser>list=this.genericHibernateDao.find("from TBaseUser t where t.nickname=? and t.password=?", new Object[]{nickname,password});
		if(list!=null&&list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	
	/**
	 * check nickname is exist or not
	 * @param nickname
	 * @return
	 */
	@Transactional
	public Boolean checknickname(String nickname){
		try {
			List<TBaseUser> list=this.genericHibernateDao.find("from TBaseUser t where t.nickname=?",new Object[]{nickname});
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
