package com.homes.msg;

import java.sql.*;

public class msgDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public boolean IdCheck(String id) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			return rs.next(); 
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}
	
}
