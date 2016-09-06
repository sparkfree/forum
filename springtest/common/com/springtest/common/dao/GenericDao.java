package com.springtest.common.dao;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.LockMode;

/**
 * 数据库操作接口
 * 
 * @author Administrator
 * 
 */
public interface GenericDao {
	// -------------------- 基本工具操作：刷新,加锁,强制初始化 --------------------
	// 加锁指定的实体
	public void lock(Object entity, LockMode lockMode);

	// 强制初始化指定的实体
	public void initialize(Object proxy);

	// 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	public void flush();

	// -------------------- 基本检索、增加、修改、删除操作 --------------------
	// 根据主键获取指定类型的实体。如果没有相应的实体，返回 null。
	public Object get(String entityClassName, String id) throws Exception;

	public Object get(Class entityClass, String id) throws Exception;

	public Object get(Class entityClass, int id) throws Exception;

	// 获取单一结果(只能是单一结果，否则报错)，可以是统计记录数量，求最大值，最小值，平均数；或者返回记录单一对象(建议用get)，甚至是一条记录中的某个字段值。
	public Object getObject(String queryString);

	public Object getObject(String queryString, Object values[]);

	// 执行原生sql，返回指定几个属性
	public List getObjectArrayBySQL(String queryString);

	public List getObjectArrayBySQL(String queryString, Object values[]);

	public List executeQuerySQL(String queryString);

	public List executeQuerySQL(String queryString, Object[] values);

	// 执行原生sql，返回指定一个属性
	public Object getObjectBySQL(String queryString);

	public Object getObjectBySQL(String queryString, Object values[]);

	// 获取全部实体。
	public List getAll(String entityClassName);

	// 更新实体
	public void update(Object entity);

	// 更新实体并加锁
	public void updateWithLock(Object entity, LockMode lock);

	// 存储实体到数据库
	public void save(Object entity);

	// 增加或更新实体
	public void saveOrUpdate(Object entity);

	// 增加或更新集合中的全部实体
	public void saveOrUpdateAll(Collection entities);

	// 删除指定的实体
	public void delete(Object entity);

	// 加锁并删除指定的实体
	public void deleteWithLock(Object entity, LockMode lock);

	// 根据主键删除指定实体
	public void deleteByKey(Class ClassName, String id) throws Exception;

	public void deleteByKey(Class ClassName, int id) throws Exception;

	// 根据主键加锁并删除指定的实体
	public void deleteByKeyWithLock(Class ClassName, String id, LockMode lock)
			throws Exception;

	public void deleteByKeyWithLock(Class ClassName, int id, LockMode lock)
			throws Exception;

	// 删除集合中的全部实体
	public void deleteAll(Collection entities);

	// -------------------- HSQL ----------------------------------------------

	// 使用HSQL语句直接增加、更新、删除实体
	public int bulkUpdate(String queryString);

	// 使用带参数的HSQL语句增加、更新、删除实体
	public int bulkUpdate(String queryString, Object[] values);

	// 使用HSQL语句检索数据
	public List find(String queryString);

	// 使用HSQL语句检索数据带分页参数
	public List find(String queryString, int pageNow, int pageSize);

	// 使用HSQL语句检索数据带分页参数
	public List find(String queryString, Object values[], int pageNow,
			int pageSize);

	// 使用SQL语句检索数据带分页参数
	public List findSQL(String queryString, int pageNow, int pageSize);

	// 使用带参数的HSQL语句检索数据
	public List find(String queryString, Object[] values);

	//HQL like 查询语句
	public List findlikeSQL(String queryString, Object[] values, int num);

	// in 语句查询
	public List findinSQL(String queryString, Object[] values);

	// 使用带命名的参数的HSQL语句检索数据
	public List findByNamedParam(String queryString, String[] paramNames,Object[] values);

	// 使用命名的HSQL语句检索数据
	public List findByNamedQuery(String queryName);

	// 使用带参数的命名HSQL语句检索数据
	public List findByNamedQuery(String queryName, Object[] values);

	// 使用带命名参数的命名HSQL语句检索数据
	public List findByNamedQueryAndNamedParam(String queryName,String[] paramNames, Object[] values);

	// 使用HSQL语句检索数据，返回 Iterator
	public Iterator iterate(String queryString);

	// 使用带参数HSQL语句检索数据，返回 Iterator
	public Iterator iterate(String queryString, Object[] values);

	// 关闭检索返回的 Iterator
	public void closeIterator(Iterator it);

	public List executeFindBySQL(String string);

	public List executSQL(String string);

	public void creatable(String sql);

	public boolean executSQL(String sql, Object[] values);

	// 更新指定字段
	public void updatecloum(String sql, Map<String, String> map);

	//like 语句查询总数
	public Object getObjectlikehql(String queryString, Object[] values, int num);
	
	//like 语句查询列表
	public List findlikesql(String queryString, Object[] values, int num,int pageNow, int pageSize);

}
