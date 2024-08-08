package com.homes.host;

import java.sql.Date;

public class ScheduleDTO {
	
	private String idx;
	private int room_idx;
	private java.sql.Date start_day;
	private java.sql.Date end_day;
	private String reason;
	
	public ScheduleDTO() {
		super();
	}

	public ScheduleDTO(String idx, int room_idx, Date start_day, Date end_day, String reason) {
		super();
		this.idx = idx;
		this.room_idx = room_idx;
		this.start_day = start_day;
		this.end_day = end_day;
		this.reason = reason;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public int getRoom_idx() {
		return room_idx;
	}

	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}

	public java.sql.Date getStart_day() {
		return start_day;
	}

	public void setStart_day(java.sql.Date start_day) {
		this.start_day = start_day;
	}

	public java.sql.Date getEnd_day() {
		return end_day;
	}

	public void setEnd_day(java.sql.Date end_day) {
		this.end_day = end_day;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	
	
	
}
