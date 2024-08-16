package com.homes.refund;

import java.sql.*;

public class refundDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public String checkCanRefund(int r_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = " select state from reservation_test where reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, r_idx);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				return rs.getString("state");
			}
			
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "ERROR";
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
	
	public int updateResStateToCancled(int reserve_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = " update reservation_test set state = '예약취소' where reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			int count = ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
