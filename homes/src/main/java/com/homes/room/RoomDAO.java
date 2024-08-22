package com.homes.room;
import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;



import javax.security.auth.message.callback.PrivateKeyCallback.Request;

import com.homes.region.*;

public class RoomDAO {
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	private Statement st;
	
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
                //String map_url = rs.getString("map_url");
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
                //String map_url = rs.getString("map_url");
                String image = rs.getString("image");
                	
                RoomDTO roomDTO = new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, image);
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
            String sql = "INSERT INTO ROOM (ROOM_IDX, HOST_IDX, REGION_IDX, ROOM_NAME, GOODTHING, ADDR_DETAIL, PRICE, IMAGE) "
                    + "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, roomDTO.getHost_idx());
            ps.setInt(2, roomDTO.getRegion_idx());
            ps.setString(3, roomDTO.getRoom_name());
            ps.setString(4, roomDTO.getGoodthing());
            ps.setString(5, roomDTO.getAddr_detail());
            ps.setInt(6, roomDTO.getPrice());
           // ps.setString(7, roomDTO.getMap_url());
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
               // String map_url = rs.getString("map_url");
                String image = rs.getString("image");
                int room_max = rs.getInt("room_max");

                room = new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, image);
                room.setRoom_max(room_max);
                
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
	
	/**검색된 숙소 수 가져오기(조건: 전부)*/
	public int getRoomCount(int p_region_idx, int guest_num, String start_day, String end_day) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="select count(*) "
					+ "from room r "
					+ "join region rg on r.region_idx=rg.region_idx "		
					+ "where (( rg.lev=2 and rg.parent_idx=? ) "				
					+ "or ( rg.lev=1 and rg.region_idx=? )) "			
					+ "and (room_max>=? and room_min<=?) "						
					+ "and r.room_idx not in ( "								
					+ "select u.room_idx "
					+ "from unavailable_schedule u "
					+ "where to_date(?, 'YYYY-MM-DD') between u.start_day and u.end_day "
					+ "or to_date(?, 'YYYY-MM-DD') between u.start_day and u.end_day "
					+ ")";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, p_region_idx);
			ps.setInt(2, p_region_idx);
			ps.setInt(3, guest_num);
			ps.setInt(4, guest_num);
			ps.setString(5, start_day);
			ps.setString(6, end_day);
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
					//String map_url=rs.getString("map_url");
					String image=rs.getString("image");
					
					RoomDTO dto=new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, image);
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
	
	/**검색된 숙소 가져오기(조건: 전부)*/
	public ArrayList<RoomDTO> getRoom(int p_region_idx, int cp, int ls, int guest_num, String start_day, String end_day) {
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
					+ "or ( rg.lev=1 and rg.region_idx=? )) "			
					+ "and (room_max>=? and room_min<=?) "						
					+ "and r.room_idx not in ( "								
					+ "select u.room_idx "
					+ "from unavailable_schedule u "
					+ "where to_date(?, 'YYYY-MM-DD') between u.start_day and u.end_day "
					+ "or to_date(?, 'YYYY-MM-DD') between u.start_day and u.end_day "
					+ ")"
					+ ") a "
					+ "where rnum between ? and ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, p_region_idx);
			ps.setInt(2, p_region_idx);
			ps.setInt(3, guest_num);
			ps.setInt(4, guest_num);
			ps.setString(5, start_day);
			ps.setString(6, end_day);
			ps.setInt(7, start);
			ps.setInt(8, end);
			rs=ps.executeQuery();
			ArrayList<RoomDTO> room= new ArrayList<RoomDTO>();
			if(rs.next()) {
				do {
					int room_idx=rs.getInt("room_idx");
					int host_idx=rs.getInt("host_idx");
					int region_idx=rs.getInt("region_idx");
					String room_name=rs.getString("room_name");
					String goodthing=rs.getString("goodthing");
					String addr_detail=rs.getString("addr_detail");
					int price=rs.getInt("price");
					//String map_url=rs.getString("map_url");
					String image=rs.getString("image");
					
					RoomDTO dto=new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, image);
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
	
	/**전체 숙소 수 가져오기*/
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
			for(int i=0;i<6;i++) {
				rnum[i]=(int)(Math.random()*cnt)+1;
				for(int j=0;j<i;j++) {
					if(rnum[j]==rnum[i]) {
						i--;
						break;
					}
				}
			}
			
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
						//String map_url=rs.getString("map_url");
						String image=rs.getString("image");

						RoomDTO dto=new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price, image);
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
			}
		}
		
	}
	

	
	//형주버전
	public ArrayList<RoomDTO> HomesList(int useridx){
		try {
		conn=com.homes.db.HomesDB.getConn();
		String sql = "SELECT "
	               + "r.room_idx, "
	               + "r.host_idx, "
	               + "r.region_idx, "
	               + "r.room_name, "
	               + "r.goodthing, "
	               + "r.addr_detail, "
	               + "r.price, "
	               + "r.image, "
	               + "r.state, "
	               + "r1.region_name AS selected_region_name, "
	               + "r2.region_name AS parent_region_name "
	               + "FROM ROOM r "
	               + "JOIN region r1 ON r.region_idx = r1.region_idx "
	               + "LEFT JOIN region r2 ON r1.parent_idx = r2.region_idx "
	               + "WHERE r.host_idx = (SELECT idx FROM Homes_Member WHERE idx = ?) "
	               + "AND r.state = 1";

		ps=conn.prepareStatement(sql);
		ps.setInt(1, useridx);
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
			String image= rs.getString("image");
			int state= rs.getInt("state");
			String selectedRegionName = rs.getString("selected_region_name");
            String parentRegionName = rs.getString("parent_region_name");
            if(parentRegionName==null||parentRegionName.isEmpty()) {
            	parentRegionName="";
            }
			RoomDTO dto =new RoomDTO(room_idx, host_idx, region_idx, room_name, goodthing, addr_detail, price,image,state,selectedRegionName,parentRegionName);
			arr.add(dto);
			//System.out.println(arr.get(0).getRoom_name());
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
	public int insertRoom2(int hostIdx,int regionIdx,String roomName,String goodthing,String addrDetail,int price,String img,int roomMin,int roomMax) {
        int result = 0;
        try {
            conn = com.homes.db.HomesDB.getConn();
            String sql = "INSERT INTO ROOM (ROOM_IDX, HOST_IDX, REGION_IDX, ROOM_NAME, GOODTHING, ADDR_DETAIL, PRICE, IMAGE, ROOM_MIN,ROOM_MAX) "
                    + "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, hostIdx);
            ps.setInt(2, regionIdx);
            ps.setString(3, roomName);
            ps.setString(4, goodthing);
            ps.setString(5, addrDetail);
            ps.setInt(6, price);
          //  ps.setString(7, mapUrl);
            ps.setString(7, img);
            ps.setInt(8, roomMin);
            ps.setInt(9, roomMax);

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

	public ArrayList<RoomDTO> Review_select(int idx) {
		
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="SELECT * FROM Reviews where ROOM_IDX = ? ";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			ArrayList<RoomDTO> arr= new ArrayList<RoomDTO>();
			while(rs.next()) {
				int room_idx=idx;
				int rate=rs.getInt("rate");
				String member_id=rs.getString("member_id");
				String content=rs.getString("content");
		
				RoomDTO dto = new RoomDTO(room_idx,member_id, rate ,content);
				arr.add(dto);
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
	
	//로그인 했을때 room테이블에 host_idx가 존재한다면 룸 인덱스, 룸 이름, 룸 state를 가져옴
	public ArrayList<RoomDTO> RoomInfo(int useridx){
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="SELECT * FROM ROOM WHERE HOST_IDX ="
					+ "(SELECT idx FROM Homes_Member WHERE idx = ?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, useridx);
			rs=ps.executeQuery();
			ArrayList<RoomDTO> arr= new ArrayList<RoomDTO>();

			
			while(rs.next()) {
				RoomDTO dto = new RoomDTO(rs.getInt("room_idx"),rs.getInt("host_idx"),rs.getString("room_name"),rs.getInt("state"));
				arr.add(dto);
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
	public ArrayList<String> RoomDetailImg(String roomidx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="select * from room_image where room_idx=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, roomidx);
			rs=ps.executeQuery();
			ArrayList<String> arr= new ArrayList<String>();

			
			while(rs.next()) {
				String photo_url=rs.getString("photo_url");
				arr.add(photo_url);
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
	public int RoomDetailImg_insert(String room_idx,String Room_Path_SqlSet) {
		int result=0;
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="INSERT INTO ROOM_IMAGE (ROOM_IMAGE_IDX, ROOM_IDX, PHOTO_URL)"
					+ "VALUES (ROOM_IMAGE_IDX.NEXTVAL, ?, ?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, room_idx);
			ps.setString(2, Room_Path_SqlSet);
			
			
			result=ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}
	public int RoomDetailImg_delete(String Room_Path_SqlSet) {
		int result=0;
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="delete room_image where photo_url= ? " ;
				

			ps=conn.prepareStatement(sql);
			ps.setString(1, Room_Path_SqlSet);
			
			
			result=ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}
	public int RoomMainImg_update(String setPath,String Room_idx,String Img_Path) {
		int result=0;
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql ="update room set image = ? "
					+ "where room_idx = ? and "
					+ "image= ?";
			
			ps=conn.prepareStatement(sql);
			
			
			ps.setString(1, setPath);
			ps.setString(2, Room_idx);
			ps.setString(3, Img_Path);
			
			
			
			result=ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
}
	
	public int Room_update(RoomDTO rdto) {
		int result=0;
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "UPDATE room " +
                    "SET room_name = ?, goodthing = ?, addr_detail = ?, price = ?, room_min = ?, room_max = ? " +
                    "WHERE room_idx = ?";
			
			ps=conn.prepareStatement(sql);
			
			ps.setString(1, rdto.getRoom_name());
            ps.setString(2, rdto.getGoodthing());
            ps.setString(3, rdto.getAddr_detail());
            ps.setInt(4, rdto.getPrice());
            ps.setInt(5, rdto.getRoom_min());
            ps.setInt(6, rdto.getRoom_max());
            ps.setInt(7, rdto.getRoom_idx());
			
			result=ps.executeUpdate();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}finally {
			try {
				
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
}	
	
	
	
	
	public int CreateRoomTable() {
			st=null;
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String sql = "CREATE TABLE ROOM (" +
                    "ROOM_IDX NUMBER PRIMARY KEY, " +
                    "HOST_IDX NUMBER NOT NULL, " +
                    "REGION_IDX NUMBER NOT NULL, " +
                    "ROOM_NAME VARCHAR2(255), " +
                    "GOODTHING VARCHAR2(255), " +
                    "ADDR_DETAIL VARCHAR2(255), " +
                    "PRICE NUMBER NOT NULL, " +
                    "image VARCHAR2(255), " +
                    "state NUMBER DEFAULT 0, " +
                    "room_min NUMBER DEFAULT 2, " +
                    "room_max NUMBER NOT NULL" +
                    ")";
			
			st=conn.createStatement();
       // Statement 생성
			st.executeUpdate(sql);

       System.out.println("테이블이 성공적으로 생성되었습니다.");
       	return 1;
		} catch (Exception e) {
			return 0;
			
		} finally {
			try {
				if(st!=null)st.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
}
	
	
	public int CreateRoom_ImgTable() {
		st=null;
	try {
		conn=com.homes.db.HomesDB.getConn();
		
		String sql = "CREATE TABLE ROOM_IMAGE (" +
	             "ROOM_IMAGE_IDX NUMBER PRIMARY KEY, " +
	             "ROOM_IDX NUMBER, " +
	             "PHOTO_URL VARCHAR2(255), " +
	             "FOREIGN KEY (ROOM_IDX) REFERENCES ROOM(ROOM_IDX)" +
	             ")"; 
		
		st=conn.createStatement();
   // Statement 생성
		st.executeUpdate(sql);

 
   	return 1;
	} catch (Exception e) {
		return 0;
		
	} finally {
		try {
			if(st!=null)st.close();
			if(conn!=null)conn.close();
		} catch (Exception e2) {}
	}
}
	
	
	public int CreateSeq() {
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String sql1 = "CREATE SEQUENCE ROOM_IMAGE_IDX " +
		              "START WITH 1 " +
		              "INCREMENT BY 1 " +
		              "CACHE 20";
			
			String sql2 = "CREATE SEQUENCE ROOM_SEQ " +
		              "START WITH 1 " +
		              "INCREMENT BY 1 " +
		              "CACHE 20";
			
			st=conn.createStatement();
			st.executeUpdate(sql1);
		    
		    // 두 번째 시퀀스 생성
		    st.executeUpdate(sql2);
	   // Statement 생성
		
	   
	   	return 2;
		} catch (Exception e) {
			return 0;
			
		} finally {
			try {
				if(st!=null)st.close();
				if(conn!=null)conn.close();
			} catch (Exception e2) {}
		}
	}
	
	public int CreateAllRoom(String name) {
		int count = 0;
	    if(name.equals("admin")) {
	    	 try {
	             conn = com.homes.db.HomesDB.getConn();
	             
	             // SQL INSERT 문 정의
	             String sql = "INSERT INTO ROOM (ROOM_IDX, HOST_IDX, REGION_IDX, ROOM_NAME, GOODTHING, ADDR_DETAIL, PRICE, IMAGE, STATE, ROOM_MIN, ROOM_MAX) " +
	                          "VALUES (ROOM_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	             
					/*
					 * String sql1= "insert into homes_member values"+
					 * " (999, 'admin', 'admin', 'admin', 'admin', '1995-06-05',"+
					 * " 'admin@naver.com', '010-0000-0000', sysdate, '/homes/guest/profileimg/default_profile.png', 1)"
					 * ;
					 */

	             // PreparedStatement 객체 생성
	           //  ps = conn.prepareStatement(sql1);
	             ps = conn.prepareStatement(sql);

	             // 데이터 추가
	             //1
	             ps.setInt(1, 999);
	             ps.setInt(2, 11);
	             ps.setString(3, "강릉 프라이빗");
	             ps.setString(4, "프라이빗하고 조용한 숙소");
	             ps.setString(5, "해변 마을 111번지");
	             ps.setInt(6, 170000);
	             ps.setString(7, "/homes/img/강릉 프라이빗 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();
	             
	             ps.setInt(1, 999);
	             ps.setInt(2, 11);
	             ps.setString(3, "강릉 오션뷰");
	             ps.setString(4, "바다가 한눈에 보이는 숙소");
	             ps.setString(5, "해변 마을 112번지");
	             ps.setInt(6, 150000);
	             ps.setString(7, "/homes/img/강릉 오션뷰 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();
	             
	             ps.setInt(1, 999);
	             ps.setInt(2, 10);
	             ps.setString(3, "설악산");
	             ps.setString(4, "설악산의 아름다움을 제공하는 숙소");
	             ps.setString(5, "산악 도시 222번지");
	             ps.setInt(6, 130000);
	             ps.setString(7, "/homes/img/속초 설악산 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 10);
	             ps.setString(3, "속초 바다");
	             ps.setString(4, "바다와 가까운 위치의 숙소");
	             ps.setString(5, "중심 도시 333번지");
	             ps.setInt(6, 210000);
	             ps.setString(7, "/homes/img/속초 바다 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 3);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 13);
	             ps.setString(3, "가평 계곡");
	             ps.setString(4, "조용한 계곡 근처의 숙소");
	             ps.setString(5, "가평군 444번지");
	             ps.setInt(6, 150000);
	             ps.setString(7, "/homes/img/가평 계곡 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 13);
	             ps.setString(3, "가평 글램핑");
	             ps.setString(4, "특별한 캠핑 경험 제공");
	             ps.setString(5, "해변 마을 555번지");
	             ps.setInt(6, 180000);
	             ps.setString(7, "/homes/img/가평 글램핑 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 2);
	             ps.setString(3, "수원 스타필드");
	             ps.setString(4, "쇼핑과 식사를 함께 즐길 수 있는 숙소");
	             ps.setString(5, "수원시 666번지");
	             ps.setInt(6, 140000);
	             ps.setString(7, "/homes/img/수원 스타필드 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 2);
	             ps.setString(3, "수원 행리단길");
	             ps.setString(4, "행리단길의 맛집과 가까운 숙소");
	             ps.setString(5, "수원시 777번지");
	             ps.setInt(6, 120000);
	             ps.setString(7, "/homes/img/수원 행리단길 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 17);
	             ps.setString(3, "경주 불국사");
	             ps.setString(4, "경주 불국사 근처의 숙소");
	             ps.setString(5, "경주시 888번지");
	             ps.setInt(6, 200000);
	             ps.setString(7, "/homes/img/경주 불국사 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 3);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 17);
	             ps.setString(3, "경주 시골");
	             ps.setString(4, "조용한 시골 분위기의 숙소");
	             ps.setString(5, "경주시 999번지");
	             ps.setInt(6, 160000);
	             ps.setString(7, "/homes/img/경주 시골 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 3);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 18);
	             ps.setString(3, "울릉 울릉도");
	             ps.setString(4, "울릉도의 자연을 즐길 수 있는 숙소");
	             ps.setString(5, "울릉군 1010번지");
	             ps.setInt(6, 190000);
	             ps.setString(7, "/homes/img/울릉 울릉도 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 18);
	             ps.setString(3, "울릉 죽암");
	             ps.setString(4, "조용한 죽암 지역의 숙소");
	             ps.setString(5, "울릉군 1111번지");
	             ps.setInt(6, 170000);
	             ps.setString(7, "/homes/img/울릉 죽암 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 25);
	             ps.setString(3, "해운대 광안대교");
	             ps.setString(4, "해운대와 광안대교의 멋진 경관을 제공하는 숙소");
	             ps.setString(5, "해운대구 1212번지");
	             ps.setInt(6, 200000);
	             ps.setString(7, "/homes/img/해운대 광안대교 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 25);
	             ps.setString(3, "해운대 오션뷰");
	             ps.setString(4, "해운대의 오션뷰를 제공하는 숙소");
	             ps.setString(5, "해운대구 1313번지");
	             ps.setInt(6, 210000);
	             ps.setString(7, "/homes/img/해운대 오션뷰 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 24);
	             ps.setString(3, "용산 시티뷰");
	             ps.setString(4, "서울 시내를 조망할 수 있는 숙소");
	             ps.setString(5, "용산구 1414번지");
	             ps.setInt(6, 180000);
	             ps.setString(7, "/homes/img/용산 시티뷰 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 24);
	             ps.setString(3, "용산 해방촌");
	             ps.setString(4, "해방촌 지역의 매력을 제공하는 숙소");
	             ps.setString(5, "용산구 1515번지");
	             ps.setInt(6, 170000);
	             ps.setString(7, "/homes/img/용산 해방촌 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 23);
	             ps.setString(3, "종로 성곽길");
	             ps.setString(4, "종로의 성곽길 근처의 숙소");
	             ps.setString(5, "종로구 1616번지");
	             ps.setInt(6, 190000);
	             ps.setString(7, "/homes/img/종로 성곽길 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 23);
	             ps.setString(3, "종로 한옥");
	             ps.setString(4, "종로의 전통 한옥 숙소");
	             ps.setString(5, "종로구 1717번지");
	             ps.setInt(6, 200000);
	             ps.setString(7, "/homes/img/종로 한옥 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 4);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 14);
	             ps.setString(3, "중구 아파트");
	             ps.setString(4, "중구의 편리한 아파트 숙소");
	             ps.setString(5, "중구 1818번지");
	             ps.setInt(6, 150000);
	             ps.setString(7, "/homes/img/중구 아파트 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 3);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 20);
	             ps.setString(3, "담양 별채");
	             ps.setString(4, "담양의 별채 숙소");
	             ps.setString(5, "담양군 1919번지");
	             ps.setInt(6, 160000);
	             ps.setString(7, "/homes/img/담양 별채 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 19);
	             ps.setString(3, "전주 한옥마을");
	             ps.setString(4, "전주의 전통 한옥 마을 숙소");
	             ps.setString(5, "전주시 2020번지");
	             ps.setInt(6, 170000);
	             ps.setString(7, "/homes/img/전주 한옥마을 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 21);
	             ps.setString(3, "서귀포 귤밭");
	             ps.setString(4, "서귀포의 귤밭 근처 숙소");
	             ps.setString(5, "서귀포시 2121번지");
	             ps.setInt(6, 180000);
	             ps.setString(7, "/homes/img/서귀포 귤밭 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 21);
	             ps.setString(3, "서귀포 독채");
	             ps.setString(4, "서귀포의 독채 숙소");
	             ps.setString(5, "서귀포시 2222번지");
	             ps.setInt(6, 190000);
	             ps.setString(7, "/homes/img/서귀포 독채 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 22);
	             ps.setString(3, "제주 오션뷰");
	             ps.setString(4, "제주의 오션뷰를 제공하는 숙소");
	             ps.setString(5, "제주시 2323번지");
	             ps.setInt(6, 200000);
	             ps.setString(7, "/homes/img/제주 오션뷰 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 15);
	             ps.setString(3, "단양 일출뷰");
	             ps.setString(4, "단양의 일출을 볼 수 있는 숙소");
	             ps.setString(5, "단양군 2424번지");
	             ps.setInt(6, 210000);
	             ps.setString(7, "/homes/img/단양 일출뷰 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();

	             ps.setInt(1, 999);
	             ps.setInt(2, 16);
	             ps.setString(3, "서산 호수뷰");
	             ps.setString(4, "서산의 호수뷰 숙소");
	             ps.setString(5, "서산시 2525번지");
	             ps.setInt(6, 160000);
	             ps.setString(7, "/homes/img/서산 호수뷰 메인.jpg");
	             ps.setInt(8, 1);
	             ps.setInt(9, 2);
	             ps.setInt(10, 2);
	             ps.addBatch();
	             
	             conn.commit();
	             // 배치 실행
	             ps.executeBatch();
	             //count= ps.executeUpdate();
	             return 2;
	             
	             
	    } catch (Exception e) {
	        e.printStackTrace();
	        	return 0;
	    } finally {
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (Exception e2) {
	            e2.printStackTrace();
	        }
	    }
	   }
		return count;
}
	public int CreateRoomDetailImg() {
		//int count = 0;
	try {
		conn=com.homes.db.HomesDB.getConn();
		 String sql = "INSERT INTO ROOM_IMAGE (ROOM_IMAGE_IDX, ROOM_IDX, PHOTO_URL) VALUES (ROOM_IMAGE_IDX.NEXTVAL, ?, ?)";
          
		ps=conn.prepareStatement(sql);
		ps.setInt(1, 5); // ROOM_IDX: 4
        ps.setString(2, "/homes/img/host_img/admin/가평 계곡/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 5); // ROOM_IDX: 4
        ps.setString(2, "/homes/img/host_img/admin/가평 계곡/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 5); // ROOM_IDX: 4
        ps.setString(2, "/homes/img/host_img/admin/가평 계곡/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 5); // ROOM_IDX: 4
        ps.setString(2, "/homes/img/host_img/admin/가평 계곡/숙소사진4.jpg");
        ps.addBatch();
        
        // 가평 글램핑 이미지 삽입
        ps.setInt(1, 6); // ROOM_IDX: 5
        ps.setString(2, "/homes/img/host_img/admin/가평 글램핑/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 6); // ROOM_IDX: 5
        ps.setString(2, "/homes/img/host_img/admin/가평 글램핑/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 6); // ROOM_IDX: 5
        ps.setString(2, "/homes/img/host_img/admin/가평 글램핑/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 6); // ROOM_IDX: 5
        ps.setString(2, "/homes/img/host_img/admin/가평 글램핑/숙소사진4.jpg");
        ps.addBatch();
        
        // 강릉 오션뷰 이미지 삽입
        ps.setInt(1, 2); // ROOM_IDX: 1
        ps.setString(2, "/homes/img/host_img/admin/강릉 오션뷰/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 2); // ROOM_IDX: 1
        ps.setString(2, "/homes/img/host_img/admin/강릉 오션뷰/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 2); // ROOM_IDX: 1
        ps.setString(2, "/homes/img/host_img/admin/강릉 오션뷰/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 2); // ROOM_IDX: 1
        ps.setString(2, "/homes/img/host_img/admin/강릉 오션뷰/숙소사진4.jpg");
        ps.addBatch();
        
        // 강릉 프라이빗 이미지 삽입
        ps.setInt(1, 1); // ROOM_IDX: 2
        ps.setString(2, "/homes/img/host_img/admin/강릉 프라이빗/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 1); // ROOM_IDX: 2
        ps.setString(2, "/homes/img/host_img/admin/강릉 프라이빗/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 1); // ROOM_IDX: 2
        ps.setString(2, "/homes/img/host_img/admin/강릉 프라이빗/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 1); // ROOM_IDX: 2
        ps.setString(2, "/homes/img/host_img/admin/강릉 프라이빗/숙소사진4.jpg");
        ps.addBatch();
        
        // 경주 불국사 이미지 삽입
        ps.setInt(1, 9); // ROOM_IDX: 8
        ps.setString(2, "/homes/img/host_img/admin/경주 불국사/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 9); // ROOM_IDX: 8
        ps.setString(2, "/homes/img/host_img/admin/경주 불국사/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 9); // ROOM_IDX: 8
        ps.setString(2, "/homes/img/host_img/admin/경주 불국사/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 9); // ROOM_IDX: 8
        ps.setString(2, "/homes/img/host_img/admin/경주 불국사/숙소사진4.jpg");
        ps.addBatch();
        
        // 경주 시골 이미지 삽입
        ps.setInt(1, 10); // ROOM_IDX: 9
        ps.setString(2, "/homes/img/host_img/admin/경주 시골/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 10); // ROOM_IDX: 9
        ps.setString(2, "/homes/img/host_img/admin/경주 시골/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 10); // ROOM_IDX: 9
        ps.setString(2, "/homes/img/host_img/admin/경주 시골/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 10); // ROOM_IDX: 9
        ps.setString(2, "/homes/img/host_img/admin/경주 시골/숙소사진4.jpg");
        ps.addBatch();
        
        // 단양 일출뷰 이미지 삽입
        ps.setInt(1, 25); // ROOM_IDX: 24
        ps.setString(2, "/homes/img/host_img/admin/단양 일출뷰/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 25); // ROOM_IDX: 24
        ps.setString(2, "/homes/img/host_img/admin/단양 일출뷰/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 25); // ROOM_IDX: 24
        ps.setString(2, "/homes/img/host_img/admin/단양 일출뷰/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 25); // ROOM_IDX: 24
        ps.setString(2, "/homes/img/host_img/admin/단양 일출뷰/숙소사진4.jpg");
        ps.addBatch();
        
        // 담양 별채 이미지 삽입
        ps.setInt(1, 20); // ROOM_IDX: 19
        ps.setString(2, "/homes/img/host_img/admin/담양 별채/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 20); // ROOM_IDX: 19
        ps.setString(2, "/homes/img/host_img/admin/담양 별채/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 20); // ROOM_IDX: 19
        ps.setString(2, "/homes/img/host_img/admin/담양 별채/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 20); // ROOM_IDX: 19
        ps.setString(2, "/homes/img/host_img/admin/담양 별채/숙소사진4.jpg");
        ps.addBatch();
        
        // 서귀포 귤밭 이미지 삽입
        ps.setInt(1, 22); // ROOM_IDX: 21
        ps.setString(2, "/homes/img/host_img/admin/서귀포 귤밭/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 22); // ROOM_IDX: 21
        ps.setString(2, "/homes/img/host_img/admin/서귀포 귤밭/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 22); // ROOM_IDX: 21
        ps.setString(2, "/homes/img/host_img/admin/서귀포 귤밭/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 22); // ROOM_IDX: 21
        ps.setString(2, "/homes/img/host_img/admin/서귀포 귤밭/숙소사진4.jpg");
        ps.addBatch();
        
        // 서귀포 독채 이미지 삽입
        ps.setInt(1, 23); // ROOM_IDX: 22
        ps.setString(2, "/homes/img/host_img/admin/서귀포 독채/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 23); // ROOM_IDX: 22
        ps.setString(2, "/homes/img/host_img/admin/서귀포 독채/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 23); // ROOM_IDX: 22
        ps.setString(2, "/homes/img/host_img/admin/서귀포 독채/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 23); // ROOM_IDX: 22
        ps.setString(2, "/homes/img/host_img/admin/서귀포 독채/숙소사진4.jpg");
        ps.addBatch();
        
        // 서산 호수뷰 이미지 삽입
        ps.setInt(1, 26); // ROOM_IDX: 25
        ps.setString(2, "/homes/img/host_img/admin/서산 호수뷰/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 26); // ROOM_IDX: 25
        ps.setString(2, "/homes/img/host_img/admin/서산 호수뷰/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 26); // ROOM_IDX: 25
        ps.setString(2, "/homes/img/host_img/admin/서산 호수뷰/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 26); // ROOM_IDX: 25
        ps.setString(2, "/homes/img/host_img/admin/서산 호수뷰/숙소사진4.jpg");
        ps.addBatch();
        
        // 속초 바다 이미지 삽입
        ps.setInt(1, 4); // ROOM_IDX: 3
        ps.setString(2, "/homes/img/host_img/admin/속초 바다/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 4); // ROOM_IDX: 3
        ps.setString(2, "/homes/img/host_img/admin/속초 바다/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 4); // ROOM_IDX: 3
        ps.setString(2, "/homes/img/host_img/admin/속초 바다/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 4); // ROOM_IDX: 3
        ps.setString(2, "/homes/img/host_img/admin/속초 바다/숙소사진4.jpg");
        ps.addBatch();
        
        // 속초 설악산 이미지 삽입
        ps.setInt(1, 3); // ROOM_IDX: 16
        ps.setString(2, "/homes/img/host_img/admin/속초 설악산/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 3); // ROOM_IDX: 16
        ps.setString(2, "/homes/img/host_img/admin/속초 설악산/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 3); // ROOM_IDX: 16
        ps.setString(2, "/homes/img/host_img/admin/속초 설악산/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 3); // ROOM_IDX: 16
        ps.setString(2, "/homes/img/host_img/admin/속초 설악산/숙소사진4.jpg");
        ps.addBatch();
        
        // 수원 스타필드 이미지 삽입
        ps.setInt(1, 7); // ROOM_IDX: 20
        ps.setString(2, "/homes/img/host_img/admin/수원 스타필드/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 7); // ROOM_IDX: 20
        ps.setString(2, "/homes/img/host_img/admin/수원 스타필드/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 7); // ROOM_IDX: 20
        ps.setString(2, "/homes/img/host_img/admin/수원 스타필드/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 7); // ROOM_IDX: 20
        ps.setString(2, "/homes/img/host_img/admin/수원 스타필드/숙소사진4.jpg");
        ps.addBatch();
        
        // 수원 행리단길 이미지 삽입
        ps.setInt(1, 8); // ROOM_IDX: 18
        ps.setString(2, "/homes/img/host_img/admin/수원 행리단길/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 8); // ROOM_IDX: 18
        ps.setString(2, "/homes/img/host_img/admin/수원 행리단길/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 8); // ROOM_IDX: 18
        ps.setString(2, "/homes/img/host_img/admin/수원 행리단길/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 8); // ROOM_IDX: 18
        ps.setString(2, "/homes/img/host_img/admin/수원 행리단길/숙소사진4.jpg");
        ps.addBatch();
        
        // 용산 시티뷰 이미지 삽입
        ps.setInt(1, 15); // ROOM_IDX: 23
        ps.setString(2, "/homes/img/host_img/admin/용산 시티뷰/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 15); // ROOM_IDX: 23
        ps.setString(2, "/homes/img/host_img/admin/용산 시티뷰/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 15); // ROOM_IDX: 23
        ps.setString(2, "/homes/img/host_img/admin/용산 시티뷰/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 15); // ROOM_IDX: 23
        ps.setString(2, "/homes/img/host_img/admin/용산 시티뷰/숙소사진4.jpg");
        ps.addBatch();
        
        // 용산 해방촌 이미지 삽입
        ps.setInt(1, 16); // ROOM_IDX: 17
        ps.setString(2, "/homes/img/host_img/admin/용산 해방촌/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 16); // ROOM_IDX: 17
        ps.setString(2, "/homes/img/host_img/admin/용산 해방촌/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 16); // ROOM_IDX: 17
        ps.setString(2, "/homes/img/host_img/admin/용산 해방촌/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 16); // ROOM_IDX: 17
        ps.setString(2, "/homes/img/host_img/admin/용산 해방촌/숙소사진4.jpg");
        ps.addBatch();
        
        // 울릉 울릉도 이미지 삽입
        ps.setInt(1, 11); // ROOM_IDX: 26
        ps.setString(2, "/homes/img/host_img/admin/울릉 울릉도/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 11); // ROOM_IDX: 26
        ps.setString(2, "/homes/img/host_img/admin/울릉 울릉도/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 11); // ROOM_IDX: 26
        ps.setString(2, "/homes/img/host_img/admin/울릉 울릉도/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 11); // ROOM_IDX: 26
        ps.setString(2, "/homes/img/host_img/admin/울릉 울릉도/숙소사진4.jpg");
        ps.addBatch();
        
        // 울릉 죽암 이미지 삽입
        ps.setInt(1, 12); // ROOM_IDX: 27
        ps.setString(2, "/homes/img/host_img/admin/울릉 죽암/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 12); // ROOM_IDX: 27
        ps.setString(2, "/homes/img/host_img/admin/울릉 죽암/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 12); // ROOM_IDX: 27
        ps.setString(2, "/homes/img/host_img/admin/울릉 죽암/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 12); // ROOM_IDX: 27
        ps.setString(2, "/homes/img/host_img/admin/울릉 죽암/숙소사진4.jpg");
        ps.addBatch();
        
        // 전주 한옥마을 이미지 삽입
        ps.setInt(1, 21); // ROOM_IDX: 28
        ps.setString(2, "/homes/img/host_img/admin/전주 한옥마을/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 21); // ROOM_IDX: 28
        ps.setString(2, "/homes/img/host_img/admin/전주 한옥마을/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 21); // ROOM_IDX: 28
        ps.setString(2, "/homes/img/host_img/admin/전주 한옥마을/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 21); // ROOM_IDX: 28
        ps.setString(2, "/homes/img/host_img/admin/전주 한옥마을/숙소사진4.jpg");
        ps.addBatch();
        
        // 제주도 오션뷰 이미지 삽입
        ps.setInt(1, 24); // ROOM_IDX: 29
        ps.setString(2, "/homes/img/host_img/admin/제주도 오션뷰/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 24); // ROOM_IDX: 29
        ps.setString(2, "/homes/img/host_img/admin/제주도 오션뷰/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 24); // ROOM_IDX: 29
        ps.setString(2, "/homes/img/host_img/admin/제주도 오션뷰/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 24); // ROOM_IDX: 29
        ps.setString(2, "/homes/img/host_img/admin/제주도 오션뷰/숙소사진4.jpg");
        ps.addBatch();
        
        // 종로 성곽길 이미지 삽입
        ps.setInt(1, 17); // ROOM_IDX: 30
        ps.setString(2, "/homes/img/host_img/admin/종로 성곽길/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 17); // ROOM_IDX: 30
        ps.setString(2, "/homes/img/host_img/admin/종로 성곽길/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 17); // ROOM_IDX: 30
        ps.setString(2, "/homes/img/host_img/admin/종로 성곽길/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 17); // ROOM_IDX: 30
        ps.setString(2, "/homes/img/host_img/admin/종로 성곽길/숙소사진4.jpg");
        ps.addBatch();
        
        // 종로 한옥 이미지 삽입
        ps.setInt(1, 18); // ROOM_IDX: 31
        ps.setString(2, "/homes/img/host_img/admin/종로 한옥/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 18); // ROOM_IDX: 31
        ps.setString(2, "/homes/img/host_img/admin/종로 한옥/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 18); // ROOM_IDX: 31
        ps.setString(2, "/homes/img/host_img/admin/종로 한옥/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 18); // ROOM_IDX: 31
        ps.setString(2, "/homes/img/host_img/admin/종로 한옥/숙소사진4.jpg");
        ps.addBatch();
        
        // 중구 아파트 이미지 삽입
        ps.setInt(1, 19); // ROOM_IDX: 32
        ps.setString(2, "/homes/img/host_img/admin/중구 아파트/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 19); // ROOM_IDX: 32
        ps.setString(2, "/homes/img/host_img/admin/중구 아파트/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 19); // ROOM_IDX: 32
        ps.setString(2, "/homes/img/host_img/admin/중구 아파트/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 19); // ROOM_IDX: 32
        ps.setString(2, "/homes/img/host_img/admin/중구 아파트/숙소사진4.jpg");
        ps.addBatch();
        
        // 해운대 광안대교 이미지 삽입
        ps.setInt(1, 13); // ROOM_IDX: 33
        ps.setString(2, "/homes/img/host_img/admin/해운대 광안대교/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 13); // ROOM_IDX: 33
        ps.setString(2, "/homes/img/host_img/admin/해운대 광안대교/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 13); // ROOM_IDX: 33
        ps.setString(2, "/homes/img/host_img/admin/해운대 광안대교/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 13); // ROOM_IDX: 33
        ps.setString(2, "/homes/img/host_img/admin/해운대 광안대교/숙소사진4.jpg");
        ps.addBatch();
        
        // 해운대 오션뷰 미지 삽입
        ps.setInt(1, 14); // ROOM_IDX: 34
        ps.setString(2, "/homes/img/host_img/admin/해운대 오션뷰/숙소사진1.jpg");
        ps.addBatch();
        
        ps.setInt(1, 14); // ROOM_IDX: 34
        ps.setString(2, "/homes/img/host_img/admin/해운대 오션뷰/숙소사진2.jpg");
        ps.addBatch();
        
        ps.setInt(1, 14); // ROOM_IDX: 34
        ps.setString(2, "/homes/img/host_img/admin/해운대 오션뷰/숙소사진3.jpg");
        ps.addBatch();
        
        ps.setInt(1, 14); // ROOM_IDX: 34
        ps.setString(2, "/homes/img/host_img/admin/해운대 오션뷰/숙소사진4.jpg");
        
        ps.addBatch();
        
        
        
        ps.executeBatch();
       //count = ps.executeUpdate();
        conn.commit();

		return 2;
	} catch (Exception e) {
		e.printStackTrace();
		return 0;
	}finally {
		try {
			
			if(ps!=null)ps.close();
			if(conn!=null)conn.close();
		} catch (Exception e2) {}
	}
}
	
}


