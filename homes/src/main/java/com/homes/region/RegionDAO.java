package com.homes.region;

import java.sql.*;
import java.util.*;


public class RegionDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	/**지역 이름 가져오기*/
	public  ArrayList<RegionDTO> getRegion() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from region r "
					+ "join region_detail rd on r.region_idx=rd.region_idx "
					+ "where r.lev=1 "
					+ "order by r.region_idx asc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<RegionDTO> region= new ArrayList<>();
			while(rs.next()) {
				int region_idx=rs.getInt("region_idx");
				String region_name=rs.getString("region_name");
				int parent_idx=rs.getInt("parent_idx");
				int lev=rs.getInt("lev");
				RegionDTO dto = new RegionDTO(region_idx, region_name, parent_idx, lev);
				region.add(dto);
			}
			
			return region;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**지역 이름 가져오기(클릭순)*/
	public  ArrayList<RegionDTO> getRegionClick() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select r.* from region r "
					+ "join region_detail rd on r.region_idx=rd.region_idx "
					+ "where r.lev=1 "
					+ "order by rd.click desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<RegionDTO> region= new ArrayList<>();
			while(rs.next()) {
				int region_idx=rs.getInt("region_idx");
				String region_name=rs.getString("region_name");
				int parent_idx=rs.getInt("parent_idx");
				int lev=rs.getInt("lev");
				RegionDTO dto = new RegionDTO(region_idx, region_name, parent_idx, lev);
				region.add(dto);
			}
			
			return region;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	//hostinsert에서 해당 지역에 해당하는 region_idx값 가져오기
	/*
	 * public String[] getRegion_info(int Region_idx){ try {
	 * conn=com.homes.db.HomesDB.getConn(); String sql="SELECT " +
	 * "r1.region_name AS selected_region_name," +
	 * "r2.region_name AS parent_region_name" + "FROM region r1" +
	 * "LEFT JOIN region r2 ON r1.parent_idx = r2.region_idx" +
	 * "WHERE r1.region_idx = ?;"; ps=conn.prepareStatement(sql); ps.setInt(1,
	 * Region_idx); rs=ps.executeQuery(); String[] str= new String[1];
	 * 
	 * while(rs.next()) {
	 * 
	 * str[0]=rs.getString("region_name"); str[1]=rs.getString("region_name"); }
	 * 
	 * return str; } catch (Exception e) { e.printStackTrace(); return null; }
	 * finally { try { if(rs!=null) rs.close(); if(ps!=null) ps.close();
	 * if(conn!=null) conn.close(); } catch (Exception e2) { e2.printStackTrace(); }
	 * } }
	 */
}
