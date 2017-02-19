package com.springtest.topic.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.springtest.common.util.JsonDateSerializer;

/**
 * 评论表 t_base_comment
 */
@Entity
@Table(name = "t_base_comment")
public class TBaseComment implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 5597266500546717506L;
	
	private String id;//主键ID
	private String fkid;//外键ID，与话题表关联
	private String content;//评论内容
	private String userid;//用户ID
	private String username;//用户名
	public Date time;//评论时间
	// Constructors
	/** default constructor */
	public TBaseComment() {
	}

	/** minimal constructor */
	public TBaseComment(String id) {
		this.id=id;
	}

	/** full constructor */
	public TBaseComment(String id,String fkid,String content,String userid,String username,Date time) {
		this.id=id;
		this.fkid=fkid;
		this.content=content;
		this.userid = userid;
		this.username=username;
		this.time=time;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false, length = 30)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "FKID", length = 30)
	public String getFkid() {
		return fkid;
	}

	public void setFkid(String fkid) {
		this.fkid = fkid;
	}
	
	
	@Column(name = "CONTENT", length = 50)
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Column(name = "USERID", length = 30)
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	@Column(name = "USERNAME", length = 30)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@JsonSerialize(using=JsonDateSerializer.class)
	@Column(name = "TIME", length = 7)
	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}
}