package com.springtest.common.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
/**
 * 时间处理工具类
 * @author Administrator
 *
 */
public class DateUtil {
	/**
  	 * 按标准格式取得时间"yyyyMMddhhmmssSSS"
  	 */
  	public static String FormatDateTimemi() {
  		java.sql.Time enter = new java.sql.Time(System.currentTimeMillis());
  		java.sql.Date ent = new java.sql.Date(System.currentTimeMillis());
  		java.util.Date d = Calendar.getInstance().getTime();
  		SimpleDateFormat f = new SimpleDateFormat("yyyyMMddHHmmssSSS");
  		return f.format(d);
  	}
  	/**
  	 * Date转换String，dateformat格式
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
