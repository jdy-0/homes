package com.homes.host;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class ScheduleDAO {

	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public ArrayList<ScheduleDTO> showAllSchdule(int room_idx){

        try {
            conn = com.homes.db.HomesDB.getConn(); // 데이터베이스 연결
            String sql = " SELECT * FROM UNAVAILABLE_SCHEDULE WHERE room_idx = ? "; // 관리자의 비밀번호를 조회하는 SQL 쿼리
            ps = conn.prepareStatement(sql);
            ps.setInt(1, room_idx); // 아이디 바인딩
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
	
}
