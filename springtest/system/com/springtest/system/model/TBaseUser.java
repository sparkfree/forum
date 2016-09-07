package com.springtest.system.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 用户表 t_base_user
 */
@Entity
@Table(name = "T_BASE_USER")
public class TBaseUser implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 5597266500546717506L;
	
	private String userid;//主键ID
	private String username;//用户名
	private String account;//账户
	private String password;//密码
	private String phonenumber;//电话号码
	private String email;//邮箱
	private String address;//地址


	// Constructors
	/** default constructor */
	public TBaseUser() {
	}

	/** minimal constructor */
	public TBaseUser(String userid) {
		this.userid = userid;
	}

	/** full constructor */
	public TBaseUser(String userid, String username, String account,String password,String phonenumber,String email,String address) {
		this.userid = userid;
		this.username = username;
		this.account = account;
		this.password = password;
		this.phonenumber=phonenumber;
		this.email=email;
		this.address=address;
	}

	// Property accessors
	@Id
	@Column(name = "USERID", unique = true, nullable = false, length = 30)
	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "USERNAME", length = 50)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "ACCOUNT", length = 30)
	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	@Column(name = "PASSWORD", length = 30)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	@Column(name="PHONENUMBER",length=30)
	public String getPhonenumber() {
		return phonenumber;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	@Column(name="EMAIL",length=30)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	@Column(name="ADDRESS",length=50)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
}