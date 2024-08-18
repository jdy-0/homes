package com.homes.guest;

import java.util.*;
import java.sql.*;
import java.sql.Date;

import javax.naming.*;
import javax.sql.*;

public class GuestDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	public static final int ERROR=-1;
	public static final int No_Id=1, No_Pwd=2, Login_ok=3;
	
	//중복 아이디 검사 메소드
	public boolean IdCheck(String id) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			return rs.next();	//중복되는 아이디 존재하는 경우 true반환, 없으면 false반환
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	//동일인물 이미 있을 때 (email로 확인)
	public boolean checkSameGuest(String email) {
		try {		
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE EMAIL=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, email);
			rs=ps.executeQuery();
			
			return rs.next(); //이메일 있으면 true반환
		} catch (Exception e) {
			e.printStackTrace();
			return true;
		}finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	//회원가입 메소드
	public int homesJoin(GuestDTO dto) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String sql="INSERT INTO HOMES_MEMBER VALUES(HOMES_MEMBER_IDX.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, '/homes/guest/profileimg/default_profile.svg', 1)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPwd());
			ps.setString(3, dto.getPwd_hint_q());
			ps.setString(4, dto.getPwd_hint_a());
			ps.setString(5, dto.getName());
			ps.setString(6, dto.getNickname());
			String bday_s=dto.getBday();
			java.sql.Date bday=java.sql.Date.valueOf(bday_s);
			ps.setDate(7, bday);
			ps.setString(8, dto.getEmail());
			ps.setString(9, dto.getTel());
			
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//로그인 메소드
	public int loginCheck(String id, String pwd) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String sql="SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(!rs.next()) {	//존재하는 아이디 없음
				return No_Id;
			}else {	//존재하는 아이디 있음
				String dbpwd=rs.getString("pwd");
				if(pwd.equals(dbpwd)) {	//아이디, 비밀번호 일치
					return Login_ok;
				}else {
					return No_Pwd;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//로그인한 사용자 정보 가져오기
	public ArrayList<Object> getUserInfo(String id){
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String sql="SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			rs.next();
			int idx=rs.getInt("idx");
			String name=rs.getString("name");
			String nickname=rs.getString("nickname");
			ArrayList<Object> user_info = new ArrayList<Object>();
			user_info.add(0, idx);
			user_info.add(1, id);
			user_info.add(2, name);
			user_info.add(3, nickname);
			
			return user_info;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	//계정 profile_img src 가져오기
	public String getImgSrc(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT IMG FROM HOMES_MEMBER WHERE IDX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			String img = "";
			if(rs.next()) {
				img = rs.getString("img");
				
			}		
			return img;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	//계정 정보 보기 메소드
	public GuestDTO getUserProfile(String id){
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="SELECT * FROM HOMES_MEMBER WHERE ID = ?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			
			GuestDTO dto = null;
			
			if(rs.next()) {
				int idx=rs.getInt("idx");
				String pwd=rs.getString("pwd");
				String name=rs.getString("name");
				String nickname = rs.getString("nickname");
				java.sql.Date bday=rs.getDate("bday");
				String bday_s=String.valueOf(bday);
				String email=rs.getString("email");
				String tel=rs.getString("tel");
				java.sql.Date joindate = rs.getDate("joindate");
				String img=rs.getString("img");
				int state = rs.getInt("state");
				
				dto = new GuestDTO(idx, id, pwd, name, nickname, bday_s, email, tel, joindate, img, state);
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
			} catch (Exception e2) {}
		}
	}
	//아이디찾기
	public String findId(String name, String email) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE NAME = ? AND EMAIL=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			rs=ps.executeQuery();
			if(rs.next()) {
				String id = rs.getString("id");
				return id;
			}else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}

	/*
	 * //비밀번호 찾기 public boolean findPwdCheck(String id, String pwd_hint_q, String
	 * pwd_hint_a) { try { conn = com.homes.db.HomesDB.getConn(); String sql =
	 * "SELECT * FROM HOMES_MEMBER WHERE ID=?";
	 * 
	 * } catch (Exception e) { e.printStackTrace();
	 * 
	 * } finally { try {
	 * 
	 * } catch (Exception e2) {} } }
	 */
	//비밀번호 변경을 위한 현재 비밀번호 확인 메소드
	public String pwdCheck(String id) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="SELECT PWD FROM HOMES_MEMBER WHERE ID=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			rs.next();	//이미 로그인 된 후에 사용하는 기능이므로 id는 무조건 존재한다는 전제
			String pwd = rs.getString("pwd");
			
			return pwd;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//비밀번호 변경 메소드
	public int updatePwd(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="UPDATE HOMES_MEMBER SET PWD=? WHERE IDX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			int count = ps.executeUpdate();
			
			return count;
			
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//회원 정보 수정 메소드
	public int updateProfile(int idx, String nickname, String email, String tel) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql="UPDATE HOMES_MEMBER SET NICKNAME=?, EMAIL=?, TEL=? WHERE IDX=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, nickname);
			ps.setString(2, email);
			ps.setString(3, tel);
			ps.setInt(4, idx);
			
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	//메세지 전송 메소드
	public int sendMsg(MsgDTO dto) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "INSERT INTO HOMES_MSG VALUES(HOMES_MSG_IDX.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0, 1, 1)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getReceiver_id());
			ps.setString(2, dto.getSender_id());
			ps.setString(3, dto.getTitle());
			ps.setString(4, dto.getContent());
			
			int count = ps.executeUpdate();
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//받은 메세지 or 보낸 메세지 리스트 가져오기 메소드 (사용자 id = receiver_id -> 받은 메세지 / 사용자 id = sender_id -> 보낸 메세지)
	public ArrayList<MsgDTO> getMsgList(String id, int page, int size, String receiver_sender, String unread){	//receiver_sender 는 화면에서 받은 메세지, 보낸 메세지 선택해서 파라미터로 가져올 예정
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String read = ("yes".equals(unread)) ? " AND READ_STATE = 0 ":" ";
			String sql = "SELECT * FROM "
					+ "	(SELECT ROW_NUMBER() OVER (ORDER BY IDX DESC) AS RNUM, "
					+ "	IDX, RECEIVER_ID, SENDER_ID, TITLE, CONTENT, SEND_TIME, READ_STATE "
					+ "	FROM HOMES_MSG WHERE "+receiver_sender+"_ID = ? AND "+receiver_sender+"_STATE = 1 "
					+read+") WHERE RNUM BETWEEN ? AND ?";

			int endnum = page*size;
			int startnum = endnum - size + 1;
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, startnum);
			ps.setInt(3, endnum);
			
			rs=ps.executeQuery();
			
			ArrayList<MsgDTO> arr = new ArrayList<MsgDTO>();
			while(rs.next()) {
				int idx = rs.getInt("idx");
				String receiver_id = rs.getString("receiver_id");
				String sender_id = rs.getString("sender_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				java.sql.Timestamp send_time = rs.getTimestamp("send_time");
				int read_state = rs.getInt("read_state");
				
				MsgDTO dto = new MsgDTO(idx, receiver_id, sender_id, title, content, send_time, read_state);
				arr.add(dto);
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
			} catch (Exception e2) {}
		}
	}
	
	//보낸메세지, 받은메세지 개수 구하기
	public int getTotalMsgCount(String userid, String receiver_sender) {
		int totalMsg = 0;
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT COUNT(*) FROM HOMES_MSG WHERE "+receiver_sender+"_ID=? AND "+receiver_sender+"_STATE = 1";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			rs.next();
			totalMsg = rs.getInt(1);
			
			return totalMsg;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//나에게 온 메세지 중 읽지 않은 메세지 개수 구하기
	public int countUnreadMsg(String userid) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT COUNT(*) AS UNREAD FROM HOMES_MSG WHERE RECEIVER_ID = ? AND RECEIVER_STATE = 1 AND READ_STATE = 0";
			ps=conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs=ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}

	//안읽은 메세지 있는지 확인 메소드
	public boolean checkNonReadMsg(String id) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MSG WHERE RECEIVER_ID=? and RECEIVER_STATE = 1 and READ_STATE = 0";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
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
			} catch (Exception e2) {}
		}
	}
	
	//메세지 내용 보기 메소드
	public MsgDTO getMsgContent(int msgidx){
		try {
			conn=com.homes.db.HomesDB.getConn();

			setMsgRead(msgidx);

			
			String sql = "SELECT * FROM HOMES_MSG WHERE IDX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, msgidx);
			
			rs = ps.executeQuery();
			
			MsgDTO dto = null;
			if(rs.next()) {
				String receiver_id = rs.getString("receiver_id");
				String sender_id = rs.getString("sender_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				java.sql.Timestamp send_time = rs.getTimestamp("send_time");
				int read_state = rs.getInt("read_state");
				dto = new MsgDTO(msgidx, receiver_id, sender_id, title, content, send_time, read_state);
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
			} catch (Exception e2) {}
		}
	}
	
	//메세지 상태 읽음으로 변경하는 메소드
	public void setMsgRead(int msgidx) {
		boolean close = false;
		try {
				if(conn.isClosed()) {
				conn=com.homes.db.HomesDB.getConn();
				close = true;
			}
			
			String sql = "UPDATE HOMES_MSG SET READ_STATE = 1 WHERE IDX = ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, msgidx);
			
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(close) {
					if(rs!=null) rs.close();
					if(ps!=null) ps.close();
					if(conn!=null) conn.close();
				}
			} catch (Exception e2) {}
		}
	}
	
	//메세지 삭제하기
	public int dltGotMsg(int msgidx, String receiver_sender) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MSG SET "+receiver_sender+"_STATE = 0 WHERE IDX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, msgidx);
			
			int count = ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//보낸 메세지 삭제하기
	public int dltSendMsg(int msgidx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MSG SET SENDER_STATE = 0 WHERE IDX = ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, msgidx);
			
			int count = ps.executeUpdate();
			
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//총 이용회수와 가입 기간 구하기
	public int[] getCountandPeriod(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT (SELECT COUNT(*) FROM RESERVATION_TEST WHERE MEMBER_IDX = ? AND STATE = '이용완료') AS USECOUNT, "
					+ "CEIL(SYSDATE-JOINDATE) AS PERIOD FROM HOMES_MEMBER WHERE IDX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.setInt(2, idx);
			rs=ps.executeQuery();
			rs.next();
			int usecount = rs.getInt("usecount");
			int period = rs.getInt("period");
			
			int [] number = new int[2];
			number[0] = usecount;
			number[1] = period;
			
			return number;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	public int getCountUse(int idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT COUNT(*) FROM RESERVATION_TEST WHERE MEMBER_IDX=? AND STATE='이용완료'";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs=ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//회원별 예약 내역 불러오기 메소드
//	public ArrayList<ReservationDTO> getReserveHistory(int member_idx){
//		try {
//			conn = com.homes.db.HomesDB.getConn();
//			String sql = "SELECT * FROM RESERVATION_TEST WHERE MEMBER_IDX = ?";
//			ps=conn.prepareStatement(sql);
//			ps.setInt(1, member_idx);
//			
//			rs=ps.executeQuery();
//			ArrayList<ReservationDTO> arr = new ArrayList<ReservationDTO>();
//			while(rs.next()) {
//				int reservation_idx = rs.getInt("reservation_idx");
//				int room_idx = rs.getInt("room_idx");
//				String state = rs.getString("state");
//				java.sql.Date reserve_date = rs.getDate("reserve_date");
//				int price = rs.getInt("price");
//				
//				ReservationDTO dto = new ReservationDTO(reservation_idx, member_idx, room_idx, state, reserve_date, price);
//				arr.add(dto);
//			}
//			
//			return arr;
//		} catch (Exception e) {
//			e.printStackTrace();
//			return null;
//		} finally {
//			try {
//				if(rs!=null) rs.close();
//				if(ps!=null) ps.close();
//				if(conn!=null) conn.close();
//			} catch (Exception e2) {}
//		}
//	}
	
	//회원별 예약 상세 내역
	/*
	 * public ArrayList<Reservation_detailDTO> getReserveDetail(int member_idx){ try
	 * { conn = com.homes.db.HomesDB.getConn(); String sql =
	 * "SELECT * FROM RESERVATION_DETAIL_TEST WHERE MEMBER_IDX = ?";
	 * ps=conn.prepareStatement(sql); ps.setInt(1, member_idx);
	 * 
	 * rs=ps.executeQuery(); ArrayList<Reservation_detailDTO> arr = new
	 * ArrayList<Reservation_detailDTO>(); while(rs.next()) { int
	 * reservation_detail_idx = rs.getInt(1); int reserve_idx = rs.getInt(2);
	 * java.sql.Date check_in = rs.getDate("check_in"); java.sql.Date check_out =
	 * rs.getDate("check_out"); String request = rs.getString("request");
	 * 
	 * Reservation_detailDTO dto = new Reservation_detailDTO(reservation_detail_idx,
	 * reserve_idx, member_idx, check_in, check_out, request); arr.add(dto); }
	 * 
	 * return arr; } catch (Exception e) { e.printStackTrace(); return null; }
	 * finally { try { if(rs!=null) rs.close(); if(ps!=null) ps.close();
	 * if(conn!=null) conn.close(); } catch (Exception e2) {} } }
	 */
	
	/*
	 * public ArrayList<ReservationDTO> getReserve(int member_idx){ try {
	 * conn=com.homes.db.HomesDB.getConn(); String sql
	 * ="SELECT RT.RESERVE_IDX, ROOM_IDX, RESERVE_DATE, CHECK_IN, CHECK_OUT, STATE, PRICE "
	 * + "FROM RESERVATION_TEST RT, RESERVATION_DETAIL_TEST RDT " +
	 * "WHERE RT.MEMBER_IDX = ? " + "AND RT.RESERVE_IDX = RDT.RESERVE_IDX";
	 * 
	 * ps=conn.prepareStatement(sql); ps.setInt(1, member_idx);
	 * 
	 * rs=ps.executeQuery(); ArrayList<ReservationDTO> arr = new
	 * ArrayList<ReservationDTO>(); while(rs.next()) { int reserve_idx =
	 * rs.getInt("reserve_idx"); int room_idx = rs.getInt("room_idx"); java.sql.Date
	 * reserve_date = rs.getDate("reserve_date"); java.sql.Date check_in =
	 * rs.getDate("check_in"); java.sql.Date check_out = rs.getDate("check_out");
	 * String state = rs.getString("state"); int price = rs.getInt("price");
	 * 
	 * ReservationDTO dto = new ReservationDTO(reserve_idx, room_idx, reserve_date,
	 * check_in, check_out, state, price);
	 * 
	 * arr.add(dto); } return arr; } catch (Exception e) { e.printStackTrace();
	 * return null; } finally { try { if(rs!=null) rs.close(); if(ps!=null)
	 * ps.close(); if(conn!=null) conn.close(); } catch (Exception e2) {} } }
	 */
	
	//예약 내역 확인
	public ArrayList<ReservationDTO> getReserveHistory(int member_idx){
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT RES.RESERVE_IDX, R.IMAGE, R.ROOM_NAME, RES.STATE, RES_DE.CHECK_IN, RES_DE.CHECK_OUT "
					+ "FROM ROOM R, RESERVATION_TEST RES, RESERVATION_DETAIL_TEST RES_DE "
					+ "WHERE RES.ROOM_IDX = R.ROOM_IDX "
					+ "    AND RES.MEMBER_IDX=? "
					+ "    AND RES.MEMBER_IDX = RES_DE.MEMBER_IDX "
					+ "    AND RES.RESERVE_IDX = RES_DE.RESERVE_IDX "
					+ "ORDER BY RES.RESERVE_IDX DESC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_idx);
			
			ArrayList<ReservationDTO> arr = new ArrayList<ReservationDTO>();
			rs=ps.executeQuery();
			while(rs.next()) {
				int reserve_idx = rs.getInt("reserve_idx");
				String image = rs.getString("image");
				String room_name = rs.getString("room_name");
				String state = rs.getString("state");
				java.sql.Date check_in = rs.getDate("check_in");
				java.sql.Date check_out = rs.getDate("check_out");
				
				ReservationDTO dto = new ReservationDTO(reserve_idx, image, room_name, state, check_in, check_out);
				arr.add(dto);
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
			} catch (Exception e2) {}
		}
	}
}
