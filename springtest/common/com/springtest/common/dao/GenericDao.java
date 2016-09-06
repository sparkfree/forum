package com.springtest.common.dao;

import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.LockMode;

/**
 * ���ݿ�����ӿ�
 * 
 * @author Administrator
 * 
 */
public interface GenericDao {
	// -------------------- �������߲�����ˢ��,����,ǿ�Ƴ�ʼ�� --------------------
	// ����ָ����ʵ��
	public void lock(Object entity, LockMode lockMode);

	// ǿ�Ƴ�ʼ��ָ����ʵ��
	public void initialize(Object proxy);

	// ǿ���������»������ݵ����ݿ⣨������������ύʱ�Ÿ��£�
	public void flush();

	// -------------------- �������������ӡ��޸ġ�ɾ������ --------------------
	// ����������ȡָ�����͵�ʵ�塣���û����Ӧ��ʵ�壬���� null��
	public Object get(String entityClassName, String id) throws Exception;

	public Object get(Class entityClass, String id) throws Exception;

	public Object get(Class entityClass, int id) throws Exception;

	// ��ȡ��һ���(ֻ���ǵ�һ��������򱨴�)��������ͳ�Ƽ�¼�����������ֵ����Сֵ��ƽ���������߷��ؼ�¼��һ����(������get)��������һ����¼�е�ĳ���ֶ�ֵ��
	public Object getObject(String queryString);

	public Object getObject(String queryString, Object values[]);

	// ִ��ԭ��sql������ָ����������
	public List getObjectArrayBySQL(String queryString);

	public List getObjectArrayBySQL(String queryString, Object values[]);

	public List executeQuerySQL(String queryString);

	public List executeQuerySQL(String queryString, Object[] values);

	// ִ��ԭ��sql������ָ��һ������
	public Object getObjectBySQL(String queryString);

	public Object getObjectBySQL(String queryString, Object values[]);

	// ��ȡȫ��ʵ�塣
	public List getAll(String entityClassName);

	// ����ʵ��
	public void update(Object entity);

	// ����ʵ�岢����
	public void updateWithLock(Object entity, LockMode lock);

	// �洢ʵ�嵽���ݿ�
	public void save(Object entity);

	// ���ӻ����ʵ��
	public void saveOrUpdate(Object entity);

	// ���ӻ���¼����е�ȫ��ʵ��
	public void saveOrUpdateAll(Collection entities);

	// ɾ��ָ����ʵ��
	public void delete(Object entity);

	// ������ɾ��ָ����ʵ��
	public void deleteWithLock(Object entity, LockMode lock);

	// ��������ɾ��ָ��ʵ��
	public void deleteByKey(Class ClassName, String id) throws Exception;

	public void deleteByKey(Class ClassName, int id) throws Exception;

	// ��������������ɾ��ָ����ʵ��
	public void deleteByKeyWithLock(Class ClassName, String id, LockMode lock)
			throws Exception;

	public void deleteByKeyWithLock(Class ClassName, int id, LockMode lock)
			throws Exception;

	// ɾ�������е�ȫ��ʵ��
	public void deleteAll(Collection entities);

	// -------------------- HSQL ----------------------------------------------

	// ʹ��HSQL���ֱ�����ӡ����¡�ɾ��ʵ��
	public int bulkUpdate(String queryString);

	// ʹ�ô�������HSQL������ӡ����¡�ɾ��ʵ��
	public int bulkUpdate(String queryString, Object[] values);

	// ʹ��HSQL����������
	public List find(String queryString);

	// ʹ��HSQL���������ݴ���ҳ����
	public List find(String queryString, int pageNow, int pageSize);

	// ʹ��HSQL���������ݴ���ҳ����
	public List find(String queryString, Object values[], int pageNow,
			int pageSize);

	// ʹ��SQL���������ݴ���ҳ����
	public List findSQL(String queryString, int pageNow, int pageSize);

	// ʹ�ô�������HSQL����������
	public List find(String queryString, Object[] values);

	//HQL like ��ѯ���
	public List findlikeSQL(String queryString, Object[] values, int num);

	// in ����ѯ
	public List findinSQL(String queryString, Object[] values);

	// ʹ�ô������Ĳ�����HSQL����������
	public List findByNamedParam(String queryString, String[] paramNames,Object[] values);

	// ʹ��������HSQL����������
	public List findByNamedQuery(String queryName);

	// ʹ�ô�����������HSQL����������
	public List findByNamedQuery(String queryName, Object[] values);

	// ʹ�ô���������������HSQL����������
	public List findByNamedQueryAndNamedParam(String queryName,String[] paramNames, Object[] values);

	// ʹ��HSQL���������ݣ����� Iterator
	public Iterator iterate(String queryString);

	// ʹ�ô�����HSQL���������ݣ����� Iterator
	public Iterator iterate(String queryString, Object[] values);

	// �رռ������ص� Iterator
	public void closeIterator(Iterator it);

	public List executeFindBySQL(String string);

	public List executSQL(String string);

	public void creatable(String sql);

	public boolean executSQL(String sql, Object[] values);

	// ����ָ���ֶ�
	public void updatecloum(String sql, Map<String, String> map);

	//like ����ѯ����
	public Object getObjectlikehql(String queryString, Object[] values, int num);
	
	//like ����ѯ�б�
	public List findlikesql(String queryString, Object[] values, int num,int pageNow, int pageSize);

}
