package com.homes.guest;

import java.sql.*;
import java.util.ArrayList;

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
			
			insertReservationDetail(r_idx,rdto);
			
			
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
	
	public void insertReservationDetail(int r_idx, ReservationDTO rdto) {
		
		try {
			String sql = " insert into reservation_detail_test values("
					+ " reservation_detail_test_idx.nextval, ?, ?, ?, ?, '') ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, r_idx);
			ps.setInt(2, rdto.getMember_idx());
			ps.setDate(3, rdto.getCheck_in());
			ps.setDate(4, rdto.getCheck_out());
			
			ps.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			
		}
	}
	
	public ArrayList<ReservationDTO> getReserveLists(int room_idx){
		
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT  "
					+ "    r.RESERVE_IDX AS RESERVE_IDX,    "
					+ "    r.MEMBER_IDX AS MEMBER_IDX,      "
					+ "    r.ROOM_IDX, "
					+ "    r.STATE, "
					+ "    r.RESERVE_DATE, "
					+ "    r.PRICE, "
					+ "    rd.RESERVE_DETAIL_IDX, "
					+ "    rd.CHECK_IN, "
					+ "    rd.CHECK_OUT, "
					+ "    rd.REQUEST "
					+ "FROM  "
					+ "    reservation_test r "
					+ "JOIN  "
					+ "    reservation_detail_test rd "
					+ "ON  "
					+ "    r.RESERVE_IDX = rd.RESERVE_IDX "
					+ "AND  "
					+ "    r.MEMBER_IDX = rd.MEMBER_IDX "
					+ "WHERE state = '예약대기중' "
					+ "	   and r.ROOM_IDX = ? "
					+ "	   and check_in>sysdate ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1,room_idx);
	        rs = ps.executeQuery();
	        
	        ArrayList<ReservationDTO> arr = new ArrayList<ReservationDTO>();
			while (rs.next()) {
				int reserveIdx = rs.getInt("RESERVE_IDX");
				int memberIdx = rs.getInt("MEMBER_IDX");
				int roomIdx = rs.getInt("ROOM_IDX");
				String state = rs.getString("STATE");
				Date reserveDate = rs.getDate("RESERVE_DATE");
				int price = rs.getInt("PRICE");
				int reservationDetailIdx = rs.getInt("RESERVE_DETAIL_IDX");
				Date checkIn = rs.getDate("CHECK_IN");
				Date checkOut = rs.getDate("CHECK_OUT");
				String request = rs.getString("REQUEST");

				ReservationDTO rdto = new ReservationDTO(reserveIdx, memberIdx, roomIdx, state, reserveDate,
						price, reservationDetailIdx, checkIn, checkOut, request);
				arr.add(rdto);
			}
			return arr;
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
