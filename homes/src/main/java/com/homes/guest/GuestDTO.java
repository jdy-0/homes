package com.homes.guest;

import java.sql.Date;

public class GuestDTO {
	private int idx;
	private String id, pwd, name, nickname;
	private String bday;
	private String email, tel;
	private java.sql.Date joindate;
	private String img;
	private int state;
	
	public GuestDTO() {
		
	}

	public GuestDTO(int idx, String id, String pwd, String name, String nickname, String bday, String email, String tel,
			Date joindate, String img, int state) {
		super();
		this.idx = idx;
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.nickname = nickname;
		this.bday = bday;
		this.email = email;
		this.tel = tel;
		this.joindate = joindate;
		this.img = img;
		this.state = state;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getBday() {
		return bday;
	}

	public void setBday(String bday) {
		this.bday = bday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public java.sql.Date getJoindate() {
		return joindate;
	}

	public void setJoindate(java.sql.Date joindate) {
		this.joindate = joindate;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
}
