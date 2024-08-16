package com.homes.refund;

import java.sql.Date;

public class refundDTO {

	private int refund_idx;
	private int reserve_idx;
	private int amount;
	private java.sql.Date refund_date;
	private String status;
	
	public refundDTO() {
	}
	
	public refundDTO(int refund_idx, int reserve_idx, int amount, Date refund_date, String status) {
		super();
		this.refund_idx = refund_idx;
		this.reserve_idx = reserve_idx;
		this.amount = amount;
		this.refund_date = refund_date;
		this.status = status;
	}

	public int getRefund_idx() {
		return refund_idx;
	}

	public void setRefund_idx(int refund_idx) {
		this.refund_idx = refund_idx;
	}

	public int getReserve_idx() {
		return reserve_idx;
	}

	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public java.sql.Date getRefund_date() {
		return refund_date;
	}

	public void setRefund_date(java.sql.Date refund_date) {
		this.refund_date = refund_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
