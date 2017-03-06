package com.springtest.theme.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.springtest.common.dao.GenericDao;

@Service("themeservice")
public class ThemeService {
	@Autowired
	@Qualifier("genericHibernateDao")
	private GenericDao genericHibernateDao;
	
	
}
