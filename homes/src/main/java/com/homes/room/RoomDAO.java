package com.homes.room;

import java.sql.*;
import java.util.*;
import com.homes.region.*;

public class RoomDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//다영버전
	
	/**검색된 숙소 가져오기(조건: 지역)*/
	public ArrayList<RoomDTO> getRoom(int p_region_idx) {
		Region_DetailDAO rddao = new Region_DetailDAO();
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * "
					+ "from room r "
					+ "join region rg on r.region_idx=rg.region_idx "
					+ "where rg.lev=2 "
					+ "and rg.parent_idx=(select region_idx from region where region_idx=? and lev=1)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, p_region_idx);
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
				
				rddao.countUpdate(p_region_idx);
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
	
	/**숙소 수 가져오기*/
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
	
	/**랜덤 숙소 가져오기*/
	public RoomDTO[] roomRandom() {
		int[] idx = new int[6];
		int cnt=roomCount();
		RoomDTO[] room=new RoomDTO[6];
		try {
			//랜덤 숫자 가져오기(idx)
			for(int i=0;i<6;i++) {
				idx[i]=(int)(Math.random()*cnt)+1;
				for(int j=0;j<i;j++) {
					if(idx[j]==idx[i]) {
						i--;
						break;
					}
				}
			}
			
			//db
			conn=com.homes.db.HomesDB.getConn();
			for(int i=0;i<6;i++) {
				String sql="select * from room where room_idx="+idx[i];
				ps=conn.prepareStatement(sql);
				System.out.println(sql);
				rs=ps.executeQuery();
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
						room[i]=dto;
					}while(rs.next());
				}
			}
			return room;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
	}
	

	
	//형주버전
	public ArrayList<RoomDTO> HomesList(String userid){
		try {
		conn=com.homes.db.HomesDB.getConn();
		String sql="SELECT * FROM ROOM WHERE HOST_IDX = (SELECT idx FROM Homes_Member WHERE id = ?) and STATE = 1 ";
		ps=conn.prepareStatement(sql);
		ps.setString(1, userid);
		rs=ps.executeQuery();
		ArrayList<RoomDTO> arr= new ArrayList<RoomDTO>();
		
		while(rs.next()) {
			int room_idx = rs.getInt("room_idx");
			int host_idx= rs.getInt("host_idx");
			int region_idx= rs.getInt("region_idx");
			String room_name=rs.getString("room_name");
			String goodthing= rs.getString("goodthing");
			String addr_detail= rs.getString("addr_detail");
			int price= rs.getInt("price");
			String map_url=rs.getString("map_url");
			String image= rs.getString("image");
			int state= rs.getInt("state");
			RoomDTO dto =new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, map_url,image,state);
			arr.add(dto);
			System.out.println(arr.get(0).getRoom_name());
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
	
	public ArrayList<RoomDTO> RoomSchedule(int roomidx){
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="SELECT * FROM ROOM r JOIN UNAVAILABLE_SCHEDULE us ON r.room_idx = us.room_idx where host_idx= ? ";
			
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
				System.out.println(arr.get(0));
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
	public int RoomCheck(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="SELECT * FROM ROOM where hostidx = ? ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}
}
