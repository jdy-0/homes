package com.homes.guest;

import java.sql.*;
import java.util.ArrayList;

import com.homes.host.ScheduleDTO;

public class ReservationDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public int insertReservation(ReservationDTO rdto) {
		
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
			
			return insertReservationDetail(r_idx,rdto);
			
			
			
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
	
	public int insertReservationDetail(int r_idx, ReservationDTO rdto) {
		
		try {
			String sql = " insert into reservation_detail_test values("
					+ " reservation_detail_test_idx.nextval, ?, ?, ?, ?, ?,?) ";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, r_idx);
			ps.setInt(2, rdto.getMember_idx());
			ps.setDate(3, rdto.getCheck_in());
			ps.setDate(4, rdto.getCheck_out());
			ps.setString(5, rdto.getRequest());
			ps.setInt(6,rdto.getCount());
			
			return ps.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
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
			String sql = " select * "
					+ "FROM   "
					+ "    reservation_test r "
					+ "JOIN   "
					+ "    reservation_detail_test rd "
					+ "ON   "
					+ "    r.RESERVE_IDX = rd.RESERVE_IDX "
					+ "JOIN "
					+ "    homes_member m "
					+ "ON "
					+ "    r.MEMBER_IDX = m.idx "
					+ "WHERE  "
					+ "    r.STATE = '예약대기중' "
					+ "    AND r.ROOM_IDX = ? "
					+ "    AND TRUNC(rd.CHECK_IN) >= TRUNC(SYSDATE) ";
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
				int count = rs.getInt("count");
				ReservationDTO rdto = new ReservationDTO(reserveIdx, memberIdx, roomIdx, state, reserveDate,
						price, reservationDetailIdx, checkIn, checkOut, request,count);
				rdto.setMember_id(rs.getString("id"));
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
	
	public int updateSetResState(ReservationDTO dto) {
		
		try {
			conn = com.homes.db.HomesDB.getConn();
	        conn.setAutoCommit(false);  // 트랜잭션 시작

			String sql = " update reservation_test set state = ? where reserve_idx = ? ";
			ps = conn.prepareStatement(sql);
	        ps.setString(1, dto.getState());
			ps.setInt(2, dto.getReserve_idx());
			int count = ps.executeUpdate();
			
			if(count>0 && dto.getState().equals("예약완료")) {
				int tot_count = insertReserveToSchedule(dto);
				insertPayment(dto);
			} else {
			}
			
	        conn.commit();  // 트랜잭션 커밋
	        return count;

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();

			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
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
	
	public int insertReserveToSchedule(ReservationDTO dto) {
		try {
            String sql = " insert into UNAVAILABLE_SCHEDULE (idx, room_idx, start_day, end_day, reason) "
            		+ " VALUES ('us'||unavailable_schedule_seq.NEXTVAL, ?, ?, ?, '예약됨') "; 
           ps = conn.prepareStatement(sql);
           ps.setInt(1, dto.getRoom_idx());
           ps.setDate(2, dto.getCheck_in());
           ps.setDate(3, dto.getCheck_out());
           
           return ps.executeUpdate();
           
           
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
	}
	
	public void insertPayment(ReservationDTO dto) {
		
		try {
            String sql = " insert into payment (payment_idx, reserve_idx, amount, payment_date, status) "
            		+ " values (payment_seq.nextval, ?, ?, sysdate, '결제완료') "; 
           
           ps = conn.prepareStatement(sql);
           ps.setInt(1, dto.getReserve_idx());
           ps.setInt(2, dto.getPrice());
           
           ps.executeUpdate();
           
        } catch (Exception e) {
            e.printStackTrace();
        }		
	}
	
	public ArrayList<ReservationDTO> getUncommitedRes(int room_idx){

        try {
            conn = com.homes.db.HomesDB.getConn(); 
            String sql = " select * from reservation_test r, reservation_detail_test rd "
            		+ " WHERE r.reserve_idx = rd.reserve_idx and room_idx = ? and state = '예약대기중' "; 
            ps = conn.prepareStatement(sql);
            ps.setInt(1, room_idx); 
            rs = ps.executeQuery();
            
            ArrayList<ReservationDTO> arr = new ArrayList<ReservationDTO>();
            while(rs.next()) {
            	ReservationDTO dto = new ReservationDTO();
            	dto.setCheck_in(rs.getDate("check_in"));
            	dto.setCheck_out(rs.getDate("check_out"));
            			
            	arr.add(dto);
            }
            return arr;
            
            
        } catch (Exception e) {
            e.printStackTrace();
            return null; // 예외 발생
        } finally {
            // 자원 해제 (메모리 누수 방지)
            try {
            	if (rs != null) rs.close(); 
            	if (ps != null) ps.close();
            	if (conn != null) conn.close();
            } catch (Exception e2) {
            	e2.printStackTrace();
            }
        }
	}
	
	public int checkAvailableScheduleForRes(ReservationDTO dto) {
		
		try {
			 conn = com.homes.db.HomesDB.getConn(); 
			 String sql = " SELECT * "
			 		+ "FROM unavailable_schedule "
			 		+ "WHERE  "
			 		+ "    room_idx = ? "
			 		+ "    AND ( "
			 		+ "        (? BETWEEN start_day AND end_day) OR "
			 		+ "        (? BETWEEN start_day AND end_day) OR "
			 		+ "        (? <= start_day AND ? >= end_day) "
			 		+ "    )  "; 
			 ps = conn.prepareStatement(sql);
	         ps.setInt(1, dto.getRoom_idx());
	         ps.setDate(2, dto.getCheck_in());
	         ps.setDate(3, dto.getCheck_out());
	         ps.setDate(4, dto.getCheck_in());
	         ps.setDate(5, dto.getCheck_out());
	         
	         rs = ps.executeQuery();
	         
	         while(rs.next()) {
	             return 1;
	         }
	         
			 return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
            	if (rs != null) rs.close(); 
            	if (ps != null) ps.close();
            	if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	
}
