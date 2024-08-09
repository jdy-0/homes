package com.homes.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.homes.room.RoomDTO;

public class AdminTestDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	/**guest 정보를 가져오는 메소드*/
	//승인된 guest 수 가져오기
	public int guestCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from homes_member";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	//승인된 guest 수 가져오기
	public int guestCountOk() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from homes_member where state=1";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	/**host 정보를 가져오는 메소드*/
	
	/**region 정보를 가져오는 메소드*/
	//region 수 가져오기
	public int regionCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from region";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	//region 수(대분류) 가져오기
	public int regionDetailCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from region_detail";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	/**reservation 정보를 가져오는 메소드*/
	//reservation 수 가져오기
	public int reserveCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from reservation_test";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	//reservation 수 가져오기-예약대기중
	public int reserveCountYet() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from reservation_test where state='예약대기중'";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	//reservation 수 가져오기-예약완료
	public int reserveCountFinish() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from reservation_test where state='예약완료'";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	
	
	/**review 정보를 가져오는 메소드*/
	//review 수 가져오기
	public int reviewCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from reviews";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	//review가 등록된 숙소 수 가져오기
	public int reviewroomCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from (select distinct room_idx from reviews) a ";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	

	/**room 정보를 가져오는 메소드*/
	public ArrayList<RoomDTO> getRoom() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from room";
			ps=conn.prepareStatement(sql);

			rs=ps.executeQuery();
			ArrayList<RoomDTO> room= new ArrayList<>();
			if(rs.next()) {
				do {
					int room_idx=rs.getInt("room_idx");
					int host_idx=rs.getInt("host_idx");
					int region_idx=rs.getInt("region_idx");
					String room_name=rs.getString("room_name");
					String goodthing=rs.getString("goodthing");
					String addr_detail=rs.getString("addr_detail");
					int price=rs.getInt("price");
					String map_url=rs.getString("map_url");
					String image=rs.getString("image");
					
					RoomDTO dto=new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, map_url, image);
					room.add(dto);
				}while(rs.next());
				
			}
			
			return room;
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
	
	//room 수 가져오기
	public int roomCount() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from room";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
	//승인된 room 수 가져오기
	public int roomCountOk() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) from room where state=1";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int count=0;
			if(rs.next()) {
				count=rs.getInt(1);
			}
			return count;
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
	
}
