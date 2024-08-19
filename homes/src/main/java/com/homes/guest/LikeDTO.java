package com.homes.guest;

public class LikeDTO {
	private int idx, member_idx, room_idx;
	private String room_name, image, host, region_name;
	
	public LikeDTO() {
		
	}
	
	//나의 좋아요 목록에 필요한 생성자
	public LikeDTO(int room_idx, String room_name, String image, String host, String region_name) {
		super();
		this.room_idx = room_idx;
		this.room_name = room_name;
		this.image = image;
		this.host = host;
		this.region_name = region_name;
	}
	
	public LikeDTO(int idx, int member_idx, int room_idx, String room_name, String image, String host, String region_name) {
		super();
		this.idx = idx;
		this.member_idx = member_idx;
		this.room_idx = room_idx;
		this.room_name = room_name;
		this.image = image;
		this.host = host;
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

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public String getRegion_name() {
		return region_name;
	}

	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	
	
}
