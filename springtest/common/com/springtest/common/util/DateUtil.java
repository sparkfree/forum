package com.springtest.common.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/**
 * ʱ�䴦������
 * @author Administrator
 *
 */
public class DateUtil {
	/**
  	 * ����׼��ʽȡ��ʱ��"yyyyMMddhhmmssSSS"
  	 */
  	public static String FormatDateTimemi() {
  		java.sql.Time enter = new java.sql.Time(System.currentTimeMillis());
  		java.sql.Date ent = new java.sql.Date(System.currentTimeMillis());
  		java.util.Date d = Calendar.getInstance().getTime();
  		SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmssSSS");
  		return f.format(d);
  	}
  	/**
  	 * Dateת��String��dateformat��ʽ
  	 * @param date
  	 * @param dateformat
  	 * @return
  	 */
  	public static String formatDate(Date date, String dateformat) {
  		if(date==null)return "";
  		SimpleDateFormat sdf = new SimpleDateFormat(dateformat);
  		return sdf.format(date);

  	}
}
