package com.springtest.theme.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 话题表
 * @author lsk
 *
 */
@Entity
@Table(name = "t_base_theme")
public class TBaseTheme implements java.io.Serializable{
	private String id;
	private String theme;
	private Integer watch;//关注
	private String puserid;//发布者id
	private String pnickname;//发布者昵称
	
	public TBaseTheme(){
		
	}
	
	public TBaseTheme(String id){
		this.id=id;
	}
	
	public TBaseTheme(String id,String theme,Integer watch,String puserid,String pnickname){
		this.id=id;
		this.theme=theme;
		this.watch=watch;
		this.puserid=puserid;
		this.pnickname=pnickname;
	}

	@Id
	@Column(name = "ID", unique = true, nullable = false, length = 30)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	@Column(name = "THEME", length = 30)
	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	@Column(name = "WATCH",precision=22,scale=0)
	public Integer getWatch() {
		return watch;
	}

	public void setWatch(Integer watch) {
		this.watch = watch;
	}

	@Column(name = "PUSERID", length = 30)
	public String getPuserid() {
		return puserid;
	}

	public void setPuserid(String puserid) {
		this.puserid = puserid;
	}

	@Column(name = "PNICKNAME", length = 30)
	public String getPnickname() {
		return pnickname;
	}

	public void setPnickname(String pnickname) {
		this.pnickname = pnickname;
	}
	
}
