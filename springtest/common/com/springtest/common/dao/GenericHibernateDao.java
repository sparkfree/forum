package com.springtest.common.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.metadata.ClassMetadata;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

/**
 * 数据库操作接口实现类
 * 
 * @author Administrator
 * 
 */
@Repository("genericHibernateDao")
public class GenericHibernateDao extends HibernateDaoSupport implements GenericDao {

	// 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	public void flush() {
		this.getHibernateTemplate().flush();
	}

	// 加锁指定的实体
	public void lock(Object entity, LockMode lock) {
		this.getHibernateTemplate().lock(entity, lock);
	}

	// 强制初始化指定的实体
	public void initialize(Object proxy) {
		this.getHibernateTemplate().initialize(proxy);
	}

	//实体类名，主键id 根据主键获取实体。如果没有相应的实体，返回null
	public Object get(String entityClassName, String id) throws Exception {
		Class entityClass = Class.forName(entityClassName);// 反射
		SessionFactory sessionFactory = this.getHibernateTemplate().getSessionFactory();
		ClassMetadata meta = sessionFactory.getClassMetadata(entityClass);
		String pkName = meta.getIdentifierPropertyName();
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from " + entityClassName + " where "
				+ pkName + "=?");
		query.setParameter(0, id);//参数
		Object entity = query.uniqueResult();
		return entity;
	}
	//实体类，主键id	根据String主键获取实体。如果没有相应的实体，返回null
	public Object get(Class entityClass, String id) throws Exception {
		SessionFactory sessionFactory = this.getHibernateTemplate().getSessionFactory();
		ClassMetadata meta = sessionFactory.getClassMetadata(entityClass);
		String pkName = meta.getIdentifierPropertyName();
		String entityClassName = meta.getEntityName();
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from " + entityClassName + " where "
				+ pkName + "=?");
		query.setParameter(0, id);
		Object entity = query.uniqueResult();
		return entity;
	}
	//实体类，主键id	根据int主键获取实体。如果没有相应的实体，返回null
	public Object get(Class entityClass, int id) throws Exception {
		SessionFactory sessionFactory = this.getHibernateTemplate()
				.getSessionFactory();
		ClassMetadata meta = sessionFactory.getClassMetadata(entityClass);
		String pkName = meta.getIdentifierPropertyName();
		String entityClassName = meta.getEntityName();
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from " + entityClassName + " where "
				+ pkName + "=?");
		query.setParameter(0, id);
		Object entity = query.uniqueResult();
		return entity;
	}

	// 获取单一结果(只能是单一结果，否则报错)，可以是统计记录数量，求最大值，最小值，平均数；或者返回记录单一对象(建议用get)，甚至是一条记录中的某个字段值。
	public Object getObject(String queryString) {
		Session session = this.getHibernateTemplate().getSessionFactory()
				.getCurrentSession();
		Object object = session.createQuery(queryString).uniqueResult();
		return object;
	}

	 //带参数		 获取单一结果(只能是单一结果，否则报错)，可以是统计记录数量，求最大值，最小值，平均数；或者返回记录单一对象(建议用get)，甚至是一条记录中的某个字段值。
    public Object getObject(String queryString,Object values[]){
    	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    	Query query=session.createQuery(queryString); 
    	for(int i=0;i<values.length;i++){
    		query.setParameter(i, values[i]);
    	}
    	Object object = query.uniqueResult();
		return object;
    }
    
    //执行原生sql，返回指定几个属性
    public List getObjectArrayBySQL(String queryString){
    	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    	return session.createSQLQuery(queryString).list(); 
    }
    
    //带参数	执行原生sql，返回指定几个属性
    public List getObjectArrayBySQL(String queryString,Object values[]){
    	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    	Query query=session.createSQLQuery(queryString); 
    	for(int i=0;i<values.length;i++){
    		query.setParameter(i, values[i]);
    	}
    	return  query.list();
    }
    
    // 执行原生sql，返回指定一个属性
    public Object getObjectBySQL(String queryString){
    	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    	return session.createSQLQuery(queryString).uniqueResult(); 
    }
    
    //带参数	 执行原生sql，返回指定一个属性
    public Object getObjectBySQL(String queryString,Object values[]){
    	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    	Query query=session.createSQLQuery(queryString); 
    	for(int i=0;i<values.length;i++){
    		query.setParameter(i, values[i]);
    	}
    	Object object = query.uniqueResult();
		return object;
    }
    
    // 获取全部实体。
    public List getAll(String entityClassName) {
    	return this.getHibernateTemplate().find("from "+entityClassName);
	}
    
    // 更新实体
    public void update(Object entity) {
    	this.getHibernateTemplate().update(entity);
	}
    
    // 更新实体并加锁
    public void updateWithLock(Object entity, LockMode lock) {
    	this.getHibernateTemplate().update(entity, lock);
        this.flush(); // 立即刷新，否则锁不会生效。
	}
    
    // 存储实体到数据库
    public void save(Object entity) {
    	this.getHibernateTemplate().save(entity);
	}
    
    // 增加或更新实体
    public void saveOrUpdate(Object entity) {
    	this.getHibernateTemplate().saveOrUpdate(entity);
	}
    
    // 增加或更新集合中的全部实体
    public void saveOrUpdateAll(Collection entities) {
    	this.getHibernateTemplate().saveOrUpdateAll(entities);
	}
    
    // 删除指定的实体
    public void delete(Object entity) {
    	this.getHibernateTemplate().delete(entity);
    }
    
    // 加锁并删除指定的实体
    public void deleteWithLock(Object entity, LockMode lock) {
    	this.getHibernateTemplate().delete(entity, lock);
        this.flush(); // 立即刷新，否则锁不会生效。
    }
    
    // 根据主键删除指定实体	string主键
    public void deleteByKey(Class ClassName, String id) throws Exception {
        this.delete(this.get(ClassName,id));
    }
    //根据主键删除指定实体		int主键
    public void deleteByKey(Class ClassName, int id) throws Exception {
        this.delete(this.get(ClassName,id));
    }       
    
    // 根据主键加锁并删除指定的实体
    public void deleteByKeyWithLock(Class ClassName, String id, LockMode lock) throws Exception {
    	this.deleteWithLock(this.get(ClassName, id), lock);
	}
    public void deleteByKeyWithLock(Class ClassName, int id, LockMode lock) throws Exception {
    	this.deleteWithLock(this.get(ClassName, id), lock);
	}  
    
    // 删除集合中的全部实体
    public void deleteAll(Collection entities) {
    	this.getHibernateTemplate().deleteAll(entities);
    }
    
    // -------------------- HSQL ----------------------------------------------

    // 使用HSQL语句直接增加、更新、删除实体
    public int bulkUpdate(String queryString) {
        return this.getHibernateTemplate().bulkUpdate(queryString);
    }

    // 使用带参数的HSQL语句增加、更新、删除实体
    public int bulkUpdate(String queryString, Object[] values) {
        return this.getHibernateTemplate().bulkUpdate(queryString, values);
    }
    
    // 使用HSQL语句检索数据
    public List find(String queryString) {
        return this.getHibernateTemplate().find(queryString);
    }
    //使用带参数的HSQL语句检索数据
    public List find(String queryString, Object[] values) {
        return this.getHibernateTemplate().find(queryString, values);
    }
    
    
    // 使用HSQL语句检索数据带分页参数
    public List find(String queryString, int pageNow, int pageSize){
    	Session session=this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query=session.createQuery(queryString);
		int firstResult=(pageNow-1)*pageSize;
		query.setFirstResult(firstResult);
		query.setMaxResults(pageSize);
		List list=query.list();
   		return list;
    }
    
    // 使用HSQL语句检索数据带分页参数
    public List find(String queryString, Object values[], int pageNow, int pageSize){
    	Session session=this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query=session.createQuery(queryString);
		for(int i=0;i<values.length;i++){
    		query.setParameter(i, values[i]);
    	}
		int firstResult=(pageNow-1)*pageSize;
		query.setFirstResult(firstResult);
		query.setMaxResults(pageSize);
		List list=query.list();
		return list;
    }
    
    // 使用SQL语句检索数据带分页参数
    public List findSQL(String queryString, int pageNow, int pageSize){
    	Session session=this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query=session.createSQLQuery(queryString);
		int firstResult=(pageNow-1)*pageSize;
		query.setFirstResult(firstResult);
		query.setMaxResults(pageSize);
		List list=query.list();
		return list;
    }
    
    public List findlikeSQL(String queryString, Object[] values,int num){
    	Session session=this.getHibernateTemplate().getSessionFactory().getCurrentSession();
       	Query query=session.createQuery(queryString);
		int i = values.length;
		for(int q=0;q<i;q++){
			if(q<=num-1){
				query.setParameter(q,"%"+values[q]+"%");
			}else{
				query.setParameter(q,values[q]);
			}
		}
		List list = query.list();
		return list;
    }
    
    public List findinSQL(String queryString, Object[] values){
    	Session session=this.getHibernateTemplate().getSessionFactory().getCurrentSession();
       	Query query=session.createQuery(queryString);
       	query.setParameterList("alist",values);
		List list = query.list();
		return list;
    }
    
    // 使用带命名的参数的HSQL语句检索数据
    public List findByNamedParam(String queryString, String[] paramNames, Object[] values) {
        return getHibernateTemplate().findByNamedParam(queryString, paramNames,values);
    }

    // 使用命名的HSQL语句检索数据
    public List findByNamedQuery(String queryName) {
        return getHibernateTemplate().findByNamedQuery(queryName);
    }

    // 使用带参数的命名HSQL语句检索数据
    public List findByNamedQuery(String queryName, Object[] values) {
        return getHibernateTemplate().findByNamedQuery(queryName, values);
    }

    // 使用带命名参数的命名HSQL语句检索数据
    public List findByNamedQueryAndNamedParam(String queryName, String[] paramNames, Object[] values) {
        return getHibernateTemplate().findByNamedQueryAndNamedParam(queryName, paramNames, values);
    }
    
    // 使用HSQL语句检索数据，返回 Iterator
    public Iterator iterate(String queryString) {
        return getHibernateTemplate().iterate(queryString);
    }
    
    // 使用带参数HSQL语句检索数据，返回 Iterator
    public Iterator iterate(String queryString, Object[] values) {
        return getHibernateTemplate().iterate(queryString, values);
    }
    
    // 关闭检索返回的 Iterator
    public void closeIterator(Iterator it) {
        getHibernateTemplate().closeIterator(it);
    }
    
    // 执行原生sql，返回指定几个属性
    public List executeQuerySQL(String sql){
    	Session session=this.getHibernateTemplate().getSessionFactory().openSession();	  	
    	Connection conn = session.connection();//获取connection
    	PreparedStatement ps = null;
    	ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List list = new ArrayList();
		ResultSetMetaData md;
		try {
		md = rs.getMetaData();
		int columnCount = md.getColumnCount(); // Map rowData;
		String date="";
		while (rs.next()) { // rowData = new HashMap(columnCount);
			Map rowData = new HashMap();
			for (int i = 1; i <= columnCount; i++) {
				if(rs.getObject(i)==null){
					rowData.put(md.getColumnName(i).toLowerCase(), "");
				}else{
					rowData.put(md.getColumnName(i).toLowerCase(), rs.getObject(i));
				}
			}
			list.add(rowData);
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				ps.close();
				conn.close();
				session.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
    }
 // 执行原生sql，返回指定几个属性	带参数
    public List executeQuerySQL(String sql,Object[] values){
    	Session session=this.getHibernateTemplate().getSessionFactory().openSession();	  	
    	Connection conn = session.connection();
    	PreparedStatement ps = null;
    	ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			for(int i=0;i<values.length;i++){
				ps.setObject((i+1),values[i]);
			}
			rs = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List list = new ArrayList();
		ResultSetMetaData md;
		try {
			md = rs.getMetaData();
		int columnCount = md.getColumnCount(); // Map rowData;
		String date="";
		while (rs.next()) { // rowData = new HashMap(columnCount);

			Map rowData = new HashMap();

			for (int i = 1; i <= columnCount; i++) {
				if(rs.getObject(i)==null){
					rowData.put(md.getColumnName(i).toLowerCase(), "");
				}else{
					rowData.put(md.getColumnName(i).toLowerCase(), rs.getObject(i));
				}
			}
			list.add(rowData);
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				ps.close();
				conn.close();
				session.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
    }
    
    // 执行原生sql，返回指定几个属性
    public List executSQL(String sql){
    	Session session=this.getHibernateTemplate().getSessionFactory().openSession();	  	
    	Connection conn = session.connection();
    	PreparedStatement ps = null;
    	ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		List list = new ArrayList();

		ResultSetMetaData md;
		try {
			md = rs.getMetaData();
			int columnCount = md.getColumnCount();
		while (rs.next()) {
			for (int i = 1; i <= columnCount; i++) {
				if(rs.getObject(i)==null){
					list.add("");
				}else{
					list.add(rs.getObject(i));
				}
			}
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				ps.close();
				conn.close();
				session.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
    }
    
    public List executeFindBySQL(String sql){
    	Session session=this.getHibernateTemplate().getSessionFactory().openSession();	  	
    	Connection conn = session.connection();
    	PreparedStatement ps = null;
    	ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		List list = new ArrayList();

		ResultSetMetaData md;
		try {
			md = rs.getMetaData();

		int columnCount = md.getColumnCount(); // Map rowData;

		while (rs.next()) { // rowData = new HashMap(columnCount);

			List rowData = new ArrayList();

			for (int i = 1; i <= columnCount; i++) {
				if(rs.getObject(i)==null){
					rowData.add("");
				}else{
					rowData.add(rs.getObject(i));
				}
			}
			list.add(rowData);
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				ps.close();
				conn.close();
				session.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
        }
    
    //执行原生SQL 修改与删除
    public void creatable(String sql){
    	Session session=this.getHibernateTemplate().getSessionFactory().openSession();	  	
    	Connection conn = session.connection();
    	PreparedStatement ps = null;
    	ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs.close();
				ps.close();
				conn.close();
				session.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
    }
    
    
	public boolean executSQL(String sql, Object[] values) {
		Session session=this.getHibernateTemplate().getSessionFactory().openSession();	  	
    	Connection conn = session.connection();
    	boolean is =false;
    	PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			for(int i=0;i<values.length;i++){
				ps.setObject((i+1),values[i]);
	    	}
			int i = ps.executeUpdate();
			if(i>0) is = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				ps.close();
				conn.close();
				session.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return is;
	}
	
	public void updatecloum(String hql,Map<String, String> map){
		Session session =null;
		Transaction tx =null;
		try{
		 session = this.getHibernateTemplate().getSessionFactory().openSession();
		 tx = session.beginTransaction();
		Query query = session.createQuery(hql);
		 Set<Map.Entry<String,String>> sets=map.entrySet();

		for(Map.Entry<String,String> entry:sets){
			query.setString((String)entry.getKey(),(String)entry.getValue());
		}
		query.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			tx.commit();
			session.close();
		}
	}
	
	public Object getObjectlikehql(String queryString, Object[] values,int num){
    	Session session = this.getHibernateTemplate().getSessionFactory().getCurrentSession();
    	Query query=session.createQuery(queryString); 
		int i = values.length;
		for(int q=0;q<i;q++){
			if(q<=num-1){
				query.setParameter(q,"%"+values[q]+"%");
			}else{
				query.setParameter(q,values[q]);
			}
		}
		Object object = query.uniqueResult();
		return object;
	}
	
	public List findlikesql(String queryString, Object[] values, int num, int pageNow,int pageSize){
    	Session session=this.getHibernateTemplate().getSessionFactory().getCurrentSession();
		Query query=session.createQuery(queryString);
		int i = values.length;
		for(int q=0;q<i;q++){
			if(q<=num-1){
				query.setParameter(q,"%"+values[q]+"%");
			}else{
				query.setParameter(q,values[q]);
			}
		}
		int firstResult=(pageNow-1)*pageSize;
		query.setFirstResult(firstResult);
		query.setMaxResults(pageSize);
		List list=query.list();
		return list;
	}
}
