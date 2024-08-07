package com.homes.region;

import java.sql.*;
import java.util.*;

public class RegionDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	/**지역 이름 가져오기(클릭순)*/
	public  ArrayList<String> getRegionNames() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select r.region_name from region r "
					+ "join region_detail rd on r.region_idx=rd.region_idx "
					+ "where r.lev=1 "
					+ "order by rd.click desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<String> r_name= new ArrayList<>();
			while(rs.next()) {
				r_name.add(rs.getString("region_name"));
			}
			
			return r_name;
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
	
}
