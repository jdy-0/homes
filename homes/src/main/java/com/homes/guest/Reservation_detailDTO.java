package com.homes.guest;

import java.sql.Date;

public class Reservation_detailDTO {
	private int reservation_test_idx, reserve_idx, member_idx;
	private java.sql.Date check_in, check_out;
	private String request;
	
	public Reservation_detailDTO() {
		
	}

	public Reservation_detailDTO(int reservation_test_idx, int reserve_idx, int member_idx, Date check_in,
			Date check_out, String request) {
		super();
		this.reservation_test_idx = reservation_test_idx;
		this.reserve_idx = reserve_idx;
		this.member_idx = member_idx;
		this.check_in = check_in;
		this.check_out = check_out;
		this.request = request;
	}

	public int getReservation_test_idx() {
		return reservation_test_idx;
	}

	public void setReservation_test_idx(int reservation_test_idx) {
		this.reservation_test_idx = reservation_test_idx;
	}

	public int getReserve_idx() {
		return reserve_idx;
	}

	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public java.sql.Date getCheck_in() {
		return check_in;
	}

	public void setCheck_in(java.sql.Date check_in) {
		this.check_in = check_in;
	}

	public java.sql.Date getCheck_out() {
		return check_out;
	}

	public void setCheck_out(java.sql.Date check_out) {
		this.check_out = check_out;
	}

	public String getRequest() {
		return request;
	}

	public void setRequest(String request) {
		this.request = request;
	}
}
