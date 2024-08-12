
package com.homes.room;

import java.sql.*;


public class RoomDTO {
	private int room_idx;
	private int host_idx;
	private int region_idx;
	private String room_name;
	private String goodthing;
	private String addr_detail;
	private int price;
	private String map_url;
	private String image;
	
	private int room_min;
	private int room_max;
	
	private java.sql.Date startday;
	private java.sql.Date endday;
	private String reason; 
	private int state;
	
	//review select
	private int rate;
	private String content;
	private String member_id;
	

	public RoomDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public RoomDTO(int room_idx,String member_id, int rate, String content) {
		super();
		this.room_idx = room_idx;
		this.member_id = member_id;
		this.rate = rate;
		this.content = content;
	}

	public RoomDTO(int room_idx, int host_idx, int region_idx, String room_name, String goodthing, String addr_detail,
			int price, String map_url, String image, String state,int room_min,int room_max) {
		this.room_idx = room_idx;
		this.host_idx = host_idx;
		this.region_idx = region_idx;
		this.room_name = room_name;
		this.goodthing = goodthing;
		this.addr_detail = addr_detail;
		this.price = price;
		this.map_url = map_url;
		this.image = image;
		this.room_min= room_min;
		this.room_max= room_max;
	}
	
	
	public RoomDTO(int room_idx, int host_idx, int region_idx, String room_name, String goodthing, String addr_detail,
			int price, String map_url, String image) {
		super();
		this.room_idx = room_idx;
		this.host_idx = host_idx;
		this.region_idx = region_idx;
		this.room_name = room_name;
		this.goodthing = goodthing;
		this.addr_detail = addr_detail;
		this.price = price;
		this.map_url = map_url;
		this.image = image;
	}

	public RoomDTO(int room_idx, int host_idx, int region_idx, String room_name, String goodthing, String addr_detail,
			int price, String map_url, String image,int state) {
		super();
		this.room_idx = room_idx; //방 인덱스
		this.host_idx = host_idx; //호스트 인덱스
		this.region_idx = region_idx; //지역 번호
		this.room_name = room_name; //숙소 이름
		this.goodthing = goodthing; // 편의시설
		this.addr_detail = addr_detail; // 주소
		this.price = price; // 숙소 가격
		this.map_url = map_url; // 주소 좌표
		this.image= image; // 이미지 경로
		this.state= state;//숙소 등록 y/n
	}

	public RoomDTO(String room_name,String image,Date startday, Date endday, String reason) {
		super();
		this.room_name= room_name;
		this.image = image;
		this.startday = startday;
		this.endday = endday;
		this.reason = reason;
	}
	
	public java.sql.Date getStartday() {
		return startday;
	}

	public void setStartday(java.sql.Date startday) {
		this.startday = startday;
	}

	public java.sql.Date getEndday() {
		return endday;
	}

	public void setEndday(java.sql.Date endday) {
		this.endday = endday;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public int getHost_idx() {
		return host_idx;
	}
	public void setHost_idx(int host_idx) {
		this.host_idx = host_idx;
	}
	public int getRegion_idx() {
		return region_idx;
	}
	public void setRegion_idx(int region_idx) {
		this.region_idx = region_idx;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getGoodthing() {
		return goodthing;
	}
	public void setGoodthing(String goodthing) {
		this.goodthing = goodthing;
	}
	public String getAddr_detail() {
		return addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getMap_url() {
		return map_url;
	}
	public void setMap_url(String map_url) {
		this.map_url = map_url;
	}
	public String getImage() {
		return image;
	}
	public void setUrl(String image) {
		this.image = image;
	}
	public int getRoom_min() {
		return room_min;
	}

	public void setRoom_min(int room_min) {
		this.room_min = room_min;
	}

	public int getRoom_max() {
		return room_max;
	}

	public void setRoom_max(int room_max) {
		this.room_max = room_max;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
}