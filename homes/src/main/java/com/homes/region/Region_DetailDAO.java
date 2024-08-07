package com.homes.region;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Region_DetailDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	/**지역 사진 가져오기(클릭순)*/
	public ArrayList<String> getRegionImg() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select img from region_detail order by click desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<String> img= new ArrayList<>();
			while(rs.next()) {
				img.add(rs.getString("img"));
				System.out.println(rs.getString("img"));
			}
			
			return img;
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
	
	/**검색된 숙소 클릭 수 올리기*/
	public void countUpdate(int region_idx) {
		String sql = "update region_detail set click = click+1 where region_idx = ?";
		try {
			conn=com.homes.db.HomesDB.getConn();
			ps=conn.prepareStatement(sql);
			ps.setInt(1, region_idx);
			ps.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**지역 대분류 수 구하기(지역의 대분류는 반드시 region_detail에 존재해야됨)*/
	public int regionDetailCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from region_detail";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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
	
	
}