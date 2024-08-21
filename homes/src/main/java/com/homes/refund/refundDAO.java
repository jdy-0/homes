package com.homes.refund;

import java.sql.*;

import com.homes.guest.ReservationDTO;

public class refundDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	// 예약 버튼 switch용
	public String checkCanRefund(int r_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = " select state from reservation where reserve_idx = ? ";
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
	
	public int commitedResToCancle(int reserve_idx) {
		
		try {
			int result = 0;
            conn = com.homes.db.HomesDB.getConn();
            conn.setAutoCommit(false); // 트랜잭션 시작

            result = updateResStateToCanceled(conn, reserve_idx);
            if (result == -1) throw new SQLException("Failed to update reservation state");

            result = updatePaymentStatusToCanceled(conn, reserve_idx);
            if (result == -1) throw new SQLException("Failed to update payment status");

            int refundAmount = changePriceToAmount(conn, reserve_idx);

            result = insertRefund(conn, reserve_idx, refundAmount);
            if (result == -1) throw new SQLException("Failed to insert refund");

            result = deleteSchedule(conn, reserve_idx);
            if (result == -1) throw new SQLException("Failed to delete schedule");

            conn.commit(); // 모든 작업 성공 시 커밋
			
			
			return 1;
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
	
	public int updateResStateToCanceled(int reserve_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = " update reservation set state = '예약취소' where reserve_idx = ? ";
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
	
	public int updateResStateToCanceled(Connection conn, int reserve_idx) throws SQLException {
		try {
			String sql = " update reservation set state = '예약취소' where reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			int count = ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int updatePaymentStatusToCanceled(Connection conn, int reserve_idx) throws SQLException{
		try {
			String sql = " update payment set status = '환불대기중' where reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			int count = ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int changePriceToAmount(Connection conn, int reserve_idx) throws SQLException{
		try {
			String sql = " select * from reservation r, reservation_detail rd "
					+ " where r.reserve_idx  = rd.reserve_idx and r.reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			rs = ps.executeQuery();
			
			int price = 0;
			int amount =0;

			Date check_in = null;
			if(rs.next()) {
				price = rs.getInt("price");
				check_in = rs.getDate("check_in");
			}
			
			if(check_in !=null) {
				
				java.util.Date today = new java.util.Date();
				long betDate = check_in.getTime() - today.getTime();
				
				amount =  (int) Math.abs(betDate/(1000 * 60 * 60 * 24));
			}
			
			 if (amount >= 7) {
		            return (int) (price * 1.0); // 100% 환불
		        } else if (amount >= 5) {
		            return (int) (price * 0.8); // 80% 환불
		        } else if (amount >= 3) {
		            return (int) (price * 0.6); // 60% 환불
		        } else if (amount >= 1) {
		            return (int) (price * 0.4); // 40% 환불
		        } else {
		            return (int) (price * 0.2); // 20% 환불 (예약 당일)
		        }
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int insertRefund(Connection conn, int reserve_idx, int amount) throws SQLException{
		try {
			String sql = " insert into refund values"
					+ " (refund_seq.nextval,?,?,sysdate,'환불대기','') ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			ps.setInt(2, amount);
			int count = ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	
	public int deleteSchedule(Connection conn, int reserve_idx) throws SQLException{
		try {
			String sql = " select * from reservation r, reservation_detail rd "
					+ " where r.reserve_idx=rd.reserve_idx and r.reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			rs = ps.executeQuery();
			Date check_in = null;
			Date check_out = null;
			int room_idx = -1;
			
			if(rs.next()) {
				check_in=rs.getDate("check_in");
				check_out=rs.getDate("check_out");
				room_idx = rs.getInt("room_idx");
			}
			int count = 0;
			if(check_in!=null && check_out!=null) {
				sql =  " delete from unavailable_schedule where start_day = ? and end_day=? and room_idx = ? and reason = '예약됨'";
				ps = conn.prepareStatement(sql);
				ps.setDate(1, check_in);
				ps.setDate(2, check_out);
				ps.setInt(3, room_idx);
				count = ps.executeUpdate();
			}
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}
	


}
