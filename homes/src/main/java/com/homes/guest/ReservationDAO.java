package com.homes.guest;

import java.sql.*;

public class ReservationDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public void insertReservation(ReservationDTO rdto) {
		
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = " select reservation_test_idx.nextval from dual ";
			ps = conn.prepareStatement(sql);
	        rs = ps.executeQuery();

	        int r_idx = -1;
	        if (rs.next()) {
	            r_idx = rs.getInt(1);
	        }			
			
			
			sql = " insert into reservation_test values("
					+ " ?, ?, ?, ?, sysdate, ?) ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, r_idx);
			ps.setInt(2, rdto.getMember_idx());
			ps.setInt(3, rdto.getRoom_idx());
			ps.setString(4, rdto.getState());
			ps.setInt(5, rdto.getPrice());
			
			ps.executeUpdate();
			
			insertReservationDetail(r_idx);
			
			
		} catch (Exception e) {
			e.printStackTrace();
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
	
	public void insertReservationDetail(int rs_id) {
		
		try {
			String sql = " insert into reservation_test values("
					+ " reservation_test_idx.nextval, ?, ?, ?, sysdate, ?) ";
			
			System.out.println("rs_id="+rs_id);
			
			
		} catch (Exception e) {
			e.printStackTrace();
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
