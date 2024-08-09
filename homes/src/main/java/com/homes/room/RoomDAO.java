package com.homes.room;

import java.sql.*;
import java.util.*;
import com.homes.region.*;

public class RoomDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public List<RoomDTO> getAllRooms() {
        List<RoomDTO> roomList = new ArrayList<>();
        try {
            conn = com.homes.db.HomesDB.getConn();
            String sql = "SELECT * FROM ROOM";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                int room_idx = rs.getInt("room_idx");
                int host_idx = rs.getInt("host_idx");
                int region_idx = rs.getInt("region_idx");
                String room_name = rs.getString("room_name");
                String goodthing = rs.getString("goodthing");
                String addr_detail = rs.getString("addr_detail");
                int price = rs.getInt("price");
                String map_url = rs.getString("map_url");
                String image = rs.getString("image");

                RoomDTO roomDTO = new RoomDTO();
                roomList.add(roomDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return roomList;
    }

    // 특정 지역의 방을 가져오는 메소드
    public List<RoomDTO> getRoomsByRegion(int regionIdx) {
        List<RoomDTO> roomList = new ArrayList<>();
        try {
            conn = com.homes.db.HomesDB.getConn();
            String sql = "SELECT * FROM ROOM WHERE region_idx = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, regionIdx);
            rs = ps.executeQuery();

            while (rs.next()) {
                int room_idx = rs.getInt("room_idx");
                int host_idx = rs.getInt("host_idx");
                int region_idx = rs.getInt("region_idx");
                String room_name = rs.getString("room_name");
                String goodthing = rs.getString("goodthing");
                String addr_detail = rs.getString("addr_detail");
                int price = rs.getInt("price");
                String map_url = rs.getString("map_url");
                String image = rs.getString("image");
                	
                RoomDTO roomDTO = new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, map_url, image);
                roomList.add(roomDTO);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return roomList;
    }

    // 방을 추가하는 메소드
    public int insertRoom(RoomDTO roomDTO) {
        int result = 0;
        try {
            conn = com.homes.db.HomesDB.getConn();
            String sql = "INSERT INTO ROOM (ROOM_IDX, HOST_IDX, REGION_IDX, ROOM_NAME, GOODTHING, ADDR_DETAIL, PRICE, MAP_URL, IMAGE) "
                    + "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, roomDTO.getHost_idx());
            ps.setInt(2, roomDTO.getRegion_idx());
            ps.setString(3, roomDTO.getRoom_name());
            ps.setString(4, roomDTO.getGoodthing());
            ps.setString(5, roomDTO.getAddr_detail());
            ps.setInt(6, roomDTO.getPrice());
            ps.setString(7, roomDTO.getMap_url());
            ps.setString(8, roomDTO.getImage());

            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }
    public RoomDTO getRoomById(int room_idx) {
        RoomDTO room = null;
        try {
            conn = com.homes.db.HomesDB.getConn();
            String sql = "SELECT * FROM room WHERE room_idx = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, room_idx);
            rs = ps.executeQuery();
            if (rs.next()) {
                int host_idx = rs.getInt("host_idx");
                int region_idx = rs.getInt("region_idx");
                String room_name = rs.getString("room_name");
                String goodthing = rs.getString("goodthing");
                String addr_detail = rs.getString("addr_detail");
                int price = rs.getInt("price");
                String map_url = rs.getString("map_url");
                String image = rs.getString("image");

                room = new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, map_url, image);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return room;
    }



	//다영버전
	
	/**검색된 숙소 수 가져오기(조건: 지역)*/
	public int getRoomCount(int p_region_idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) "
					+ "from room r "
					+ "join region rg on r.region_idx=rg.region_idx "
					+ "where rg.lev=2 "
					+ "and rg.parent_idx=(select region_idx from region where region_idx=? and lev=1)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, p_region_idx);

			ps.setInt(2, p_region_idx);
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
	
	/**검색된 숙소 가져오기(조건: 지역)*/
	public ArrayList<RoomDTO> getRoom(int p_region_idx, int cp, int ls) {
		Region_DetailDAO rddao = new Region_DetailDAO();
		int start=(cp-1)*ls+1;
		int end=cp*ls;
		
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select * from "
					+ "(select rownum as rnum, r.* "
					+ "from room r "
					+ "join region rg on r.region_idx=rg.region_idx "
					+ "where (( rg.lev=2 and rg.parent_idx=? ) "
					+ "or ( rg.lev=1 and rg.region_idx=? ))) a "
					+ "where rnum >=? and rnum <=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, p_region_idx);
			ps.setInt(2, p_region_idx);
			ps.setInt(3, start);
			ps.setInt(4, end);

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
		int[] rnum = new int[6];
		int cnt=roomCount();
		RoomDTO[] room=new RoomDTO[6];
		try {
			//랜덤 숫자 가져오기(idx)
			for(int i=0;i<6;i++) {
				rnum[i]=(int)(Math.random()*cnt)+1;
				for(int j=0;j<i;j++) {
					if(rnum[j]==rnum[i]) {
						i--;
						break;
					}
				}
			}
			//db
			conn=com.homes.db.HomesDB.getConn();
			for(int i=0;i<6;i++) {
				String sql="select * from (select rownum as rnum, r.* from room r) a where rnum="+rnum[i];
				ps=conn.prepareStatement(sql);
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
	public int insertRoom2(RoomDTO roomDTO) {
        int result = 0;
        try {
            conn = com.homes.db.HomesDB.getConn();
            String sql = "INSERT INTO ROOM (ROOM_IDX, HOST_IDX, REGION_IDX, ROOM_NAME, GOODTHING, ADDR_DETAIL, PRICE, MAP_URL, IMAGE, ROOM_MIN,ROOM_MAX) "
                    + "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, roomDTO.getHost_idx());
            ps.setInt(2, roomDTO.getRegion_idx());
            ps.setString(3, roomDTO.getRoom_name());
            ps.setString(4, roomDTO.getGoodthing());
            ps.setString(5, roomDTO.getAddr_detail());
            ps.setInt(6, roomDTO.getPrice());
            ps.setString(7, roomDTO.getMap_url());
            ps.setString(8, roomDTO.getImage());
            ps.setInt(9, roomDTO.getRoom_min());
            ps.setInt(10, roomDTO.getRoom_max());

            result = ps.executeUpdate();
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
    }
	
}
