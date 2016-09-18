package com.springtest.topic.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.springtest.common.util.JsonDateSerializer;

/**
 * 话题表 t_base_topic
 */
@Entity
@Table(name = "T_BASE_TOPIC")
public class TBaseTopic implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 5597266500546717506L;
	
	private String id;//主键ID
	private String topic;//话题
	private Integer heart;//点赞数
	private String image;//图片资源
	private String userid;//用户ID
	private String username;//用户名
	public Date publishdate;//发布时间
	// Constructors
	/** default constructor */
	public TBaseTopic() {
	}

	/** minimal constructor */
	public TBaseTopic(String id) {
		this.id=id;
	}

	/** full constructor */
	public TBaseTopic(String id,String topic,Integer heart,String image,String userid,String username,Date publishdate) {
		this.userid = userid;
		this.topic=topic;
		this.heart=heart;
		this.image=image;
		this.userid=userid;
		this.username=username;
		this.publishdate=publishdate;
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

	@Column(name = "TOPIC", length = 50)
	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}
	
	@Column(name = "HEART",precision=22,scale=0)
	public Integer getHeart() {
		return heart;
	}

	public void setHeart(Integer heart) {
		this.heart = heart;
	}
	@Column(name = "IMAGE", length = 30)
	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
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
	@Column(name = "PUBLISHDATE", length = 7)
	public Date getPublishdate() {
		return publishdate;
	}

	public void setPublishdate(Date publishdate) {
		this.publishdate = publishdate;
	}
	
}