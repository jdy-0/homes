package com.homes.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.homes.region.RegionDTO;
import com.homes.region.Region_DetailDTO;
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
	
	/**-----------------------------------------------------------------------------------------------*/
	
	/**지역 대분류 소분류 순으로 출력하기*/
	public  ArrayList<RegionDTO> regionTable() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from region "
					+ "start with parent_idx is null "
					+ "connect by "
					+ "prior region_idx=parent_idx";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<RegionDTO> rt= new ArrayList<>();
			while(rs.next()) {
				int region_idx=rs.getInt("region_idx");
				String region_name=rs.getString("region_name");
				int parent_idx=rs.getInt("parent_idx");
				int lev=rs.getInt("lev");
				RegionDTO dto = new RegionDTO(region_idx, region_name, parent_idx, lev);
				rt.add(dto);
			}
			
			return rt;
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
	
	/**대분류의 지역 이름을 가져오는 메소드*/
	public String getParentName(int parent_idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select region_name from region where region_idx="+parent_idx;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			String parent_name="";
			
			if(rs.next()) {
				parent_name=rs.getString("region_name");
				
			} else {
				parent_name="-";
			}
			
			return parent_name;
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
	
	/**지역 idx로 지역 정보를 가져오는 메소드*/
	public RegionDTO getRegion(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from region where region_idx="+idx;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			RegionDTO dto=null;
			if(rs.next()) {
				int region_idx = rs.getInt("region_idx");
				String region_name = rs.getString("region_name");
				int parent_idx = rs.getInt("parent_idx");
				int lev = rs.getInt("lev");
				dto=new RegionDTO(region_idx, region_name, parent_idx, lev);
				
			}
			return dto;
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
	
	/**지역 수정하는 메소드(대분류)*/
	public int regionUpdateSubmit(int idx, String name) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="update region set region_name=? where region_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, idx);
			
			int count=ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**지역 수정하는 메소드(소분류)*/
	public int regionUpdateSubmit(int idx, String name, int pidx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="update region set region_name=?, parent_idx=? where region_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, pidx);
			ps.setInt(3, idx);
			
			int count=ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**지역사진 수정하는 메소드*/
	public int regionImageUpdate(String imgpath, int ridx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="update region_detail set img=? where region_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, imgpath);
			ps.setInt(2, ridx);
			
			int count=ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	/**지역 대분류 테이블 가져오기*/
	public  ArrayList<Region_DetailDTO> regionDetailTable() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from region_detail";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<Region_DetailDTO> rdt= new ArrayList<>();
			while(rs.next()) {
				int region_idx=rs.getInt("region_idx");
				String img=rs.getString("img");
				int click=rs.getInt("click");
				Region_DetailDTO dto = new Region_DetailDTO(region_idx, img, click);
				rdt.add(dto);
			}
			
			return rdt;
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
