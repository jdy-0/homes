package com.homes.schedule;

import java.sql.*;
import java.util.ArrayList;

import com.homes.room.RoomDTO;

public class ScheduleDAO {
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public ArrayList<RoomDTO> getScheduleByRoomidx(int roomidx){
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="SELECT * FROM ROOM r JOIN UNAVAILABLE_SCHEDULE us ON r.room_idx = us.room_idx where r.room_idx = ? ";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, roomidx);
			rs=ps.executeQuery();
			ArrayList<RoomDTO> arr= new ArrayList<RoomDTO>();
			
			while(rs.next()) {
				String room_name = rs.getString("room_name");
				String image= rs.getString("image");
				java.sql.Date startday= rs.getDate("START_DAY");
				java.sql.Date endday= rs.getDate("END_DAY");
				String reason= rs.getString("reason");
				RoomDTO dto = new RoomDTO(room_name,image,startday, endday, reason);
				arr.add(dto);
//				// System.out.println(arr.get(0));
			}
			return arr;
			} catch (Exception e) {
				e.printStackTrace();	
				return null;
			}finally {
				try {
					if(rs!=null)rs.close();
					if(ps!=null)ps.close();
					if(conn!=null)conn.close();
				} catch (Exception e2) {}
			}
		}
}
