package com.springtest.topic.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.springframework.transaction.annotation.Transactional;

import com.springtest.common.util.JsonDateSerializer;

/**
 * 话题表 t_base_topic
 */
@Entity
@Table(name = "t_base_topic")
public class TBaseTopic implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 5597266500546717506L;
	
	private String id;//主键ID
	private String topic;//话题
	private Integer comment;//点赞数
	private Integer heart;//点赞数
	private String image;//图片资源
	private String userid;//用户ID
	private String nickname;//昵称
	private Date publishdate;//发布时间
	private String publishdatestr;
	
	public TBaseTopic() {
		
	}

	/** minimal constructor */
	public TBaseTopic(String id) {
		this.id=id;
	}

	/** full constructor */
	public TBaseTopic(String id,String topic,Integer comment,Integer heart,String image,String userid,String nickname,Date publishdate) {
		this.userid = userid;
		this.topic=topic;
		this.comment=comment;
		this.heart=heart;
		this.image=image;
		this.userid=userid;
		this.nickname=nickname;
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
	
	@Column(name = "COMMENT",precision=22,scale=0)
	public Integer getComment() {
		if(comment==null){
			this.comment=0;
			return comment;
		}else{
			return comment;
		}
	}

	public void setComment(Integer comment) {
		this.comment = comment;
	}

	@Column(name = "HEART",precision=22,scale=0)
	public Integer getHeart() {
		if(this.heart==null){
			this.heart=0;
			return heart;
		}else{
			return heart;
		}
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
	
	@Column(name = "NICKNAME", length = 30)
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@JsonSerialize(using=JsonDateSerializer.class)
	@Column(name = "PUBLISHDATE", length = 7)
	public Date getPublishdate() {
		return publishdate;
	}

	public void setPublishdate(Date publishdate) {
		this.publishdate = publishdate;
	}

	@Transient
	public String getPublishdatestr() {
		return publishdatestr;
	}

	public void setPublishdatestr(String publishdatestr) {
		this.publishdatestr = publishdatestr;
	}
	
	
}