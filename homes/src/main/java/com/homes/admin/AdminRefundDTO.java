package com.homes.admin;

import java.sql.Date;

public class AdminRefundDTO {
	private String reserve_idx;
	private String room_name;
	private String nickname;
	private String check_in;
	private String check_out;
	private java.sql.Date payment_date;
	private java.sql.Date refund_date;
	private int price;
	private int amount;
	
	public AdminRefundDTO() {
	}
	
	public AdminRefundDTO(String reserve_idx, String room_name, String nickname, String check_in, String check_out,
			Date payment_date, Date refund_date, int price, int amount) {
		this.reserve_idx = reserve_idx;
		this.room_name = room_name;
		this.nickname = nickname;
		this.check_in = check_in;
		this.check_out = check_out;
		this.payment_date = payment_date;
		this.refund_date = refund_date;
		this.price = price;
		this.amount = amount;
	}



	public String getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(String reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getCheck_in() {
		return check_in;
	}
	public void setCheck_in(String check_in) {
		this.check_in = check_in;
	}
	public String getCheck_out() {
		return check_out;
	}
	public void setCheck_out(String check_out) {
		this.check_out = check_out;
	}
	public java.sql.Date getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(java.sql.Date payment_date) {
		this.payment_date = payment_date;
	}
	public java.sql.Date getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(java.sql.Date refund_date) {
		this.refund_date = refund_date;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}
