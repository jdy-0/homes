package com.homes.region;

public class Region_DetailDTO {
	private int region_idx;
	private String img;
	private int click;
	
	public Region_DetailDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public Region_DetailDTO(int region_idx, String img, int click) {
		this.region_idx = region_idx;
		this.img = img;
		this.click = click;
	}

	public int getRegion_idx() {
		return region_idx;
	}
	public void setRegion_idx(int region_idx) {
		this.region_idx = region_idx;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getClick() {
		return click;
	}
	public void setClick(int click) {
		this.click = click;
	}
	
	
}
