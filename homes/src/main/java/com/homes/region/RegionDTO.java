package com.homes.region;

public class RegionDTO {
	private int region_idx;
	private String region_name;
	private int parent_idx;
	private int lev;
	
	public RegionDTO() {
		// TODO Auto-generated constructor stub
	}
	
	public RegionDTO(int region_idx, String region_name, int parent_idx, int lev) {
		this.region_idx = region_idx;
		this.region_name = region_name;
		this.parent_idx = parent_idx;
		this.lev = lev;
	}

	public int getRegion_idx() {
		return region_idx;
	}
	public void setRegion_idx(int region_idx) {
		this.region_idx = region_idx;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
	public int getParent_idx() {
		return parent_idx;
	}
	public void setParent_idx(int parent_idx) {
		this.parent_idx = parent_idx;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	
	
	
}
