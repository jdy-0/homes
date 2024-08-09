package com.homes.guest;

import java.util.*;
import java.sql.*;

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
	//동일인물 이미 있을 때 (이름과 email로 확인)
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
			} catch (Exception e2) {}
		}
	}
	//회원가입 메소드
	public int homesJoin(GuestDTO dto) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			
			String sql="INSERT INTO HOMES_MEMBER VALUES(HOMES_MEMBER_IDX.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, SYSDATE, '/homes/guest/profileimg/default_profile.png', 1)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPwd());
			ps.setString(3, dto.getName());
			ps.setString(4, dto.getNickname());
			String bday_s=dto.getBday();
			java.sql.Date bday=java.sql.Date.valueOf(bday_s);
			ps.setDate(5, bday);
			ps.setString(6, dto.getEmail());
			ps.setString(7, dto.getTel());
			
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
			String sql = "INSERT INTO HOMES_MSG VALUES(HOMES_MSG_IDX.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0)";
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
	
	//메세지 리스트 가져오기 메소드
	public ArrayList<MsgDTO> getMsgList(String id){
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MSG WHERE RECEIVER_ID = ? ORDER BY IDX DESC";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			
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
	
	//안읽은 메세지 확인 메소드
	public boolean checkNonReadMsg(String id) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MSG WHERE RECEIVER_ID=? and READ_STATE = 0";
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
		try {
			//conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MSG SET READ_STATE = 1 WHERE IDX = ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, msgidx);
			
			int count = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
			} catch (Exception e2) {}
		}
	}
	
	//총 이용회수 구하기
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
}
