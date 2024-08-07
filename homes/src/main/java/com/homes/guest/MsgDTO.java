package com.homes.guest;

import java.sql.*;

public class MsgDTO {
	private int idx;
	private String receiver_id;
	private String sender_id;
	private String title;
	private String content;
	private java.sql.Timestamp send_time;
	private int read_state;
	
	public MsgDTO() {
	
	}
	public MsgDTO(int idx, String receiver_id, String sender_id, String title, String content, java.sql.Timestamp send_time, int read_state) {
		super();
		this.idx = idx;
		this.receiver_id = receiver_id;
		this.sender_id = sender_id;
		this.title = title;
		this.content = content;
		this.send_time = send_time;
		this.read_state = read_state;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getReceiver_id() {
		return receiver_id;
	}
	public void setReceiver_id(String receiver_id) {
		this.receiver_id = receiver_id;
	}
	public String getSender_id() {
		return sender_id;
	}
	public void setSender_id(String sender_id) {
		this.sender_id = sender_id;
	}
	public String getContent() {
		return content;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Timestamp getSend_time() {
		return send_time;
	}
	public void setSend_time(java.sql.Timestamp send_time) {
		this.send_time = send_time;
	}
	public int getRead_state() {
		return read_state;
	}
	public void setRead_state(int read_state) {
		this.read_state = read_state;
	}
	
	
}
