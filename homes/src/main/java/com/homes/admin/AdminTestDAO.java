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
			String sql="select * from region_detail order by region_idx asc";
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
	
	/**지역 추가를 위한 nextval 받아오기*/
	public int regionNextval(){
		try {
			String sql="select region_seq.nextval from dual";
			ps = conn.prepareStatement(sql);
			rs=ps.executeQuery();
			int nval=0;
			if(rs.next()) {
				nval=rs.getInt(1);
			}
			return nval;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	/**지역 추가하는 메소드(대분류)*/
	public int regionInsertSubmit(String name) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			int ridx=regionNextval();
			String sql="insert into region (region_idx, region_name, parent_idx, lev) values (?, ?, null, 1)";
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, ridx);
			ps.setString(2, name);
			
			int count=ps.executeUpdate();
			if(count>0) {
				//지역 대분류 사진 no_image로 초기화하는 메소드
				return regionImageInsert(ridx);
			}
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
	
	/**지역 사진 추가하는 메소드(대분류)*/
	public int regionImageInsert(int ridx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="insert into region_detail (region_idx, img, click) values (?, '/homes/img/no_image.jpg', 0)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ridx);
	
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
	
	/**지역 추가하는 메소드(소분류)*/
	public int regionInsertSubmit(String name, int pidx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="insert into region (region_idx, region_name, parent_idx, lev) values (region_seq.nextval, ?, ?, 2)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, pidx);
			
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
	
	/**중복검사 관련 메소드(대분류)*/
	public boolean nameCheck(String name) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select region_name from region where lev=1 and region_name=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			rs=ps.executeQuery();
			
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;		
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
	
	/**중복검사 관련 메소드(소분류)*/
	public boolean nameCheck(int pidx, String name) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select region_name from region where lev=2 and parent_idx=? and region_name=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, pidx);
			ps.setString(2, name);
			rs=ps.executeQuery();
			
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;		
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
	
	
	//host
	/**승인 안 된 room 정보를 가져오는 메소드*/
	public ArrayList<RoomDTO> getRoomState() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from room where state=0";
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
	
	/**숙소 idx로 숙소 정보를 가져오는 메소드*/
	public RoomDTO getRoom(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from room where room_idx="+idx;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			RoomDTO dto=null;
			if(rs.next()) {
				int room_idx=rs.getInt("room_idx");
				int host_idx=rs.getInt("host_idx");
				int region_idx=rs.getInt("region_idx");
				String room_name=rs.getString("room_name");
				String goodthing=rs.getString("goodthing");
				String addr_detail=rs.getString("addr_detail");
				int price=rs.getInt("price");
				String map_url=rs.getString("map_url");
				String image=rs.getString("image");
				int state=rs.getInt("state");
				int room_min=rs.getInt("room_min");
				int room_max=rs.getInt("room_max");
				//선언 잘못되어있어서 아직 못받아옴
				//dto=new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, map_url, image, state, room_min, room_max);
				
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
	
	/**숙소 승인하는 메소드*/
	public int roomStateUpdate(int ridx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="update room set state=1 where room_idx=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ridx);
			
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
}
