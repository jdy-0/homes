package com.homes.guest;

public class LikeDTO {
	private int idx, member_idx, room_idx, price, host_idx;
	private String room_name, room_image, host_nickname, region_name;
	
	public LikeDTO() {	//기본생성자
		
	}
	
	//좋아요 목록 출력할 때 필요한 생성자
	public LikeDTO(int idx, int room_idx, String room_name, String room_image, int price, int host_idx, String host_nickname, String region_name) {
		super();
		this.idx = idx;
		this.room_idx = room_idx;
		this.room_name = room_name;
		this.room_image = room_image;
		this.price = price;
		this.host_idx = host_idx;
		this.host_nickname = host_nickname;
		this.region_name = region_name;
	}
	//전체 멤버변수를 매개변수로 받는 생성자
	public LikeDTO(int idx, int member_idx, int room_idx, int price, int host_idx, String room_name, String room_image,
			String host_nickname, String region_name) {
		super();
		this.idx = idx;
		this.member_idx = member_idx;
		this.room_idx = room_idx;
		this.price = price;
		this.host_idx = host_idx;
		this.room_name = room_name;
		this.room_image = room_image;
		this.host_nickname = host_nickname;
		this.region_name = region_name;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(int member_idx) {
		this.member_idx = member_idx;
	}

	public int getRoom_idx() {
		return room_idx;
	}

	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getHost_idx() {
		return host_idx;
	}

	public void setHost_idx(int host_idx) {
		this.host_idx = host_idx;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public String getRoom_image() {
		return room_image;
	}

	public void setRoom_image(String room_image) {
		this.room_image = room_image;
	}

	public String getHost_nickname() {
		return host_nickname;
	}

	public void setHost_nickname(String host_nickname) {
		this.host_nickname = host_nickname;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	
}
