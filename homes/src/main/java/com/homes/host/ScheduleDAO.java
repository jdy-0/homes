package com.homes.host;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.homes.guest.ReservationDTO;

public class ScheduleDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public ArrayList<ScheduleDTO> showAllSchdule(int room_idx){

        try {
            conn = com.homes.db.HomesDB.getConn(); 
            String sql = " SELECT * FROM UNAVAILABLE_SCHEDULE WHERE room_idx = ? "; 
            ps = conn.prepareStatement(sql);
            ps.setInt(1, room_idx); 
            rs = ps.executeQuery();
            
            ArrayList<ScheduleDTO> arr = new ArrayList<ScheduleDTO>();
            while(rs.next()) {
            	ScheduleDTO dto = new ScheduleDTO
            			(
            				rs.getString("idx"),
            				rs.getInt("room_idx"),
            				rs.getDate("start_day"),
            				rs.getDate("end_day"),
            				rs.getString("reason")
            			);
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
	
	public int[] insertRoomSchedule(ArrayList<String> arr,int room_idx) {
	       try {
	            conn = com.homes.db.HomesDB.getConn(); 
	            String sql = " insert into UNAVAILABLE_SCHEDULE (idx, room_idx, start_day, end_day, reason) "
	            		+ " VALUES ('us'||unavailable_schedule_seq.NEXTVAL, ?, ?, ?, '휴무') "; 
	           ps = conn.prepareStatement(sql);
	           
	           if(arr!=null || arr.size()>0) {
	        	   
	        	   for(String s : arr) {
	        		   String[] s_date = s.split(",");
	        		   String begin = s_date[0];
	        		   String end = s_date[1];
	        		   java.sql.Date d_begin = new Date(Long.parseLong(begin));
	        		   java.sql.Date d_end = new Date(Long.parseLong(end));
	        		   ps.setInt(1, room_idx);  // Set room_idx
	                    ps.setDate(2, d_begin);  // Set start_day
	                    ps.setDate(3, d_end);    // Set end_day
	                    
	                    ps.addBatch();
	        		   
	        	   }
	        	   
	        	   return ps.executeBatch();
	           }
            
	        } catch (Exception e) {
	            e.printStackTrace();
	            return null;
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
		return null;
	}
	
	public int delSelectedRange(long time,int room_idx) {
	       try {
	          conn = com.homes.db.HomesDB.getConn(); 
	          String sql = " delete from UNAVAILABLE_SCHEDULE u "
	            		+ " where u.room_idx = ? And ? BETWEEN START_DAY AND END_DAY "; 
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ps.setInt(1, room_idx);
	          ps.setDate(2, new java.sql.Date(time));
	          int count = ps.executeUpdate();
	          return count;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return -1;
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
		public int delSelectedResRange(long time,int room_idx) {
	       try {
	          conn = com.homes.db.HomesDB.getConn(); 
	          String sql = " delete from UNAVAILABLE_SCHEDULE u "
	            		+ " where u.room_idx = ? And ? BETWEEN START_DAY AND END_DAY "; 
	          PreparedStatement ps = conn.prepareStatement(sql);
	          ps.setInt(1, room_idx);
	          ps.setDate(2, new java.sql.Date(time));
	          int count = ps.executeUpdate();
	          return count;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return -1;
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
		
		public int checkDelSelectedRes(long time,int room_idx) {
			try {
		        conn = com.homes.db.HomesDB.getConn(); 
				String sql = " SELECT r.reserve_idx "
						+ "FROM reservation r "
						+ "JOIN reservation_detail rd ON r.reserve_idx = rd.reserve_idx "
						+ "WHERE r.state = '예약완료' "
						+ "AND r.room_idx = ? "
						+ "AND ? BETWEEN rd.check_in AND rd.check_out ";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, room_idx);
				ps.setDate(2, new Date(time));
				rs = ps.executeQuery();
				if (rs.next()) {
		            return rs.getInt(1); // return the count of matching reservations
		        }
				return 0;
			} catch (Exception e) {
				e.printStackTrace();
				return -1;
			}
		}
	
	
}
