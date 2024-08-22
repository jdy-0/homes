package com.homes.guest;

import java.util.*;
import java.sql.*;
import java.sql.Date;

import javax.naming.*;
import javax.sql.*;

import java.io.*;
import javax.servlet.http.Part;

public class GuestDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	public static final int ERROR = -1;
	public static final int No_Id = 1, No_Pwd = 2, Login_ok = 3;

	// 중복 아이디 검사 메소드
	public boolean IdCheck(String id) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			return rs.next(); // 중복되는 아이디 존재하는 경우 true반환, 없으면 false반환
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 동일인물 이미 있을 때 (email로 확인)
	public boolean checkSameGuest(String email) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE EMAIL=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();

			return rs.next(); // 이메일 있으면 true반환
		} catch (Exception e) {
			e.printStackTrace();
			return true;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 회원가입 메소드
	public int homesJoin(GuestDTO dto) {
		try {
			conn = com.homes.db.HomesDB.getConn();

			String sql = "INSERT INTO HOMES_MEMBER VALUES(HOMES_MEMBER_IDX.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, '/homes/guest/profileimg/default_profile.svg', 1)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getId());
			ps.setString(2, dto.getPwd());
			ps.setString(3, dto.getPwd_hint_q());
			ps.setString(4, dto.getPwd_hint_a());
			ps.setString(5, dto.getName());
			ps.setString(6, dto.getNickname());
			String bday_s = dto.getBday();
			java.sql.Date bday = java.sql.Date.valueOf(bday_s);
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
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 로그인 메소드
	public int loginCheck(String id, String pwd) {
		try {
			conn = com.homes.db.HomesDB.getConn();

			String sql = "SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (!rs.next()) { // 존재하는 아이디 없음
				return No_Id;
			} else { // 존재하는 아이디 있음
				String dbpwd = rs.getString("pwd");
				if (pwd.equals(dbpwd)) { // 아이디, 비밀번호 일치
					return Login_ok;
				} else {
					return No_Pwd;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 로그인한 사용자 정보 가져오기
	public ArrayList<Object> getUserInfo(String id) {
		try {
			conn = com.homes.db.HomesDB.getConn();

			String sql = "SELECT * FROM HOMES_MEMBER WHERE ID=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			rs.next();
			int idx = rs.getInt("idx");
			String name = rs.getString("name");
			String nickname = rs.getString("nickname");
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
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 계정 profile_img src 가져오기
	public String getImgSrc(int idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT IMG FROM HOMES_MEMBER WHERE IDX=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			String img = "";
			if (rs.next()) {
				img = rs.getString("img");

			}
			return img;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}
	
	//프로필이미지 변경 메소드
	public boolean uploadProfileImage(int idx, Part filePart, String uploadDir) {
	    if (filePart == null || filePart.getSize() == 0) {
	        return false; // 파일이 없으면 업로드 X
	    }

	    String fileName = idx + ".jpg"; //파일 이름을 useridx로 저장
	    String filePath = uploadDir + File.separator + fileName;

	    // 이미 해당 사용자의 사진 파일이 있으면 덮어쓰기
	    try (InputStream inputStream = filePart.getInputStream();
	         FileOutputStream outputStream = new FileOutputStream(filePath)) {

	        int read;
	        byte[] bytes = new byte[1024];
	        while ((read = inputStream.read(bytes)) != -1) {
	            outputStream.write(bytes, 0, read);
	        }

	        // 데이터베이스에 이미지 경로 업데이트
	        int count = updateProfileImagePath(idx, "/homes/guest/profileimg/" + fileName);
	        
	        boolean result = count > 0 ? true : false;
	        return result;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	//프로필 이미지 경로 업데이트 메소드
    public int updateProfileImagePath(int idx, String imagePath) {
    	try {
            // 데이터베이스 연결
            conn = com.homes.db.HomesDB.getConn();
            String sql = "UPDATE HOMES_MEMBER SET IMG = ? WHERE IDX = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, imagePath);
            ps.setInt(2, idx);

            int count = ps.executeUpdate();
            return count;

        } catch (Exception e) {
            e.printStackTrace();
            return ERROR; 
        } finally {
            try {
                if(ps != null) ps.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
	// 계정 정보 보기 메소드
	public GuestDTO getUserProfile(String id) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE ID = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			GuestDTO dto = null;

			if (rs.next()) {
				int idx = rs.getInt("idx");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String nickname = rs.getString("nickname");
				java.sql.Date bday = rs.getDate("bday");
				String bday_s = String.valueOf(bday);
				String email = rs.getString("email");
				String tel = rs.getString("tel");
				java.sql.Date joindate = rs.getDate("joindate");
				String img = rs.getString("img");
				int state = rs.getInt("state");

				dto = new GuestDTO(idx, id, pwd, name, nickname, bday_s, email, tel, joindate, img, state);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 아이디찾기
	public String findId(String name, String email) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE NAME = ? AND EMAIL=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				String id = rs.getString("id");
				return id;
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	
	//비밀번호 찾기 -> 힌트와 정답 맞는지 확인하는 메소드
	public boolean findPwd(String id, String pwd_hind_q, String pwd_hint_a) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MEMBER WHERE ID=? AND PWD_HINT_Q=? AND PWD_HINT_A =?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd_hind_q);
			ps.setString(3, pwd_hint_a);
			
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
	
	// 비밀번호 변경을 위한 현재 비밀번호 확인 메소드
	public boolean pwdCheck(String id, String pwd) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT PWD FROM HOMES_MEMBER WHERE ID=? AND PWD=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pwd);
			rs = ps.executeQuery();
			return rs.next();
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null) rs.close();
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {}
		}
	}

	// 비밀번호 변경 메소드
	public int updatePwd(String id, String pwd) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MEMBER SET PWD=? WHERE ID=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, pwd);
			ps.setString(2, id);
			int count = ps.executeUpdate();

			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (ps != null) ps.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 회원 정보 수정 메소드
	public int updateProfile(int idx, String nickname, String email, String tel) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MEMBER SET NICKNAME=?, EMAIL=?, TEL=? WHERE IDX=?";
			ps = conn.prepareStatement(sql);
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
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 메세지 전송 메소드
	public int sendMsg(MsgDTO dto) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "INSERT INTO HOMES_MSG VALUES(HOMES_MSG_IDX.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0, 1, 1)";
			ps = conn.prepareStatement(sql);
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
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 받은 메세지 or 보낸 메세지 리스트 가져오기 메소드 (사용자 id = receiver_id -> 받은 메세지 / 사용자 id =sender_id -> 보낸 메세지)
	public ArrayList<MsgDTO> getMsgList(String id, int page, int size, String receiver_sender, String unread) { 
		try {
			conn = com.homes.db.HomesDB.getConn();

			String read = ("yes".equals(unread)) ? " AND READ_STATE = 0 " : " ";
			String sql = "SELECT * FROM " + "	(SELECT ROW_NUMBER() OVER (ORDER BY IDX DESC) AS RNUM, "
					+ "	IDX, RECEIVER_ID, SENDER_ID, TITLE, CONTENT, SEND_TIME, READ_STATE "
					+ "	FROM HOMES_MSG WHERE " + receiver_sender + "_ID = ? AND " + receiver_sender + "_STATE = 1 "
					+ read + ") WHERE RNUM BETWEEN ? AND ?";

			int endnum = page * size;
			int startnum = endnum - size + 1;

			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2, startnum);
			ps.setInt(3, endnum);

			rs = ps.executeQuery();

			ArrayList<MsgDTO> arr = new ArrayList<MsgDTO>();
			while (rs.next()) {
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
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 보낸메세지, 받은메세지 개수 구하기
	public int getTotalMsgCount(String userid, String receiver_sender) {
		int totalMsg = 0;
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT COUNT(*) FROM HOMES_MSG WHERE " + receiver_sender + "_ID=? AND " + receiver_sender
					+ "_STATE = 1";

			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			rs.next();
			totalMsg = rs.getInt(1);

			return totalMsg;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 나에게 온 메세지 중 읽지 않은 메세지 개수 구하기
	public int countUnreadMsg(String userid) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT COUNT(*) AS UNREAD FROM HOMES_MSG WHERE RECEIVER_ID = ? AND RECEIVER_STATE = 1 AND READ_STATE = 0";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 안읽은 메세지 있는지 확인 메소드
	public boolean checkNonReadMsg(String id) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_MSG WHERE RECEIVER_ID=? and RECEIVER_STATE = 1 and READ_STATE = 0";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 메세지 내용 보기 메소드
	public MsgDTO getMsgContent(int msgidx) {
		try {
			conn = com.homes.db.HomesDB.getConn();

			setMsgRead(msgidx);

			String sql = "SELECT * FROM HOMES_MSG WHERE IDX=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, msgidx);

			rs = ps.executeQuery();

			MsgDTO dto = null;
			if (rs.next()) {
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
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 메세지 상태 읽음으로 변경하는 메소드
	public void setMsgRead(int msgidx) {
		boolean close = false;
		try {
			if (conn.isClosed()) {
				conn = com.homes.db.HomesDB.getConn();
				close = true;
			}

			String sql = "UPDATE HOMES_MSG SET READ_STATE = 1 WHERE IDX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, msgidx);

			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (close) {
					if (rs != null)
						rs.close();
					if (ps != null)
						ps.close();
					if (conn != null)
						conn.close();
				}
			} catch (Exception e2) {
			}
		}
	}

	// 메세지 삭제하기
	public int dltGotMsg(int msgidx, String receiver_sender) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MSG SET " + receiver_sender + "_STATE = 0 WHERE IDX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, msgidx);

			int count = ps.executeUpdate();

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 보낸 메세지 삭제하기
	public int dltSendMsg(int msgidx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "UPDATE HOMES_MSG SET SENDER_STATE = 0 WHERE IDX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, msgidx);

			int count = ps.executeUpdate();

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 총 이용회수와 가입 기간 구하기
	public int[] getCountandPeriod(int idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT (SELECT COUNT(*) FROM RESERVATION WHERE MEMBER_IDX = ? AND STATE = '이용완료') AS USECOUNT, "
					+ "CEIL(SYSDATE-JOINDATE) AS PERIOD FROM HOMES_MEMBER WHERE IDX=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ps.setInt(2, idx);
			rs = ps.executeQuery();
			rs.next();
			int usecount = rs.getInt("usecount");
			int period = rs.getInt("period");

			int[] number = new int[2];
			number[0] = usecount;
			number[1] = period;

			return number;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	public int getCountUse(int idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT COUNT(*) FROM RESERVATION WHERE MEMBER_IDX=? AND STATE='이용완료'";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}

	// 예약 내역 확인
	public ArrayList<ReservationDTO> getReserveHistory(int member_idx, String state) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT RES.RESERVE_IDX, R.IMAGE, R.ROOM_NAME, RES.STATE, RES_DE.CHECK_IN, RES_DE.CHECK_OUT "
					+ "FROM ROOM R, RESERVATION RES, RESERVATION_DETAIL RES_DE "
					+ "WHERE RES.ROOM_IDX = R.ROOM_IDX " + "    AND RES.MEMBER_IDX=? "
					+ "	AND RES.MEMBER_IDX = RES_DE.MEMBER_IDX " + "    AND RES.RESERVE_IDX = RES_DE.RESERVE_IDX "
					+ "	AND RES.STATE = ? "
					+ "ORDER BY res_de.check_in DESC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_idx);
			ps.setString(2, state);
			ArrayList<ReservationDTO> arr = new ArrayList<ReservationDTO>();
			rs = ps.executeQuery();
			while (rs.next()) {
				int reserve_idx = rs.getInt("reserve_idx");
				String image = rs.getString("image");
				String room_name = rs.getString("room_name");
				//String state = rs.getString("state");
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
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}
	
	//예약 상세 페이지에 예약 정보 가져오기
	public HashMap<String, Object> getReserveInfo(int reserve_idx) {
		try {
			conn=com.homes.db.HomesDB.getConn();
			String sql = "SELECT "
					+ "    res.RESERVE_IDX, "
					+ "    res.MEMBER_IDX, "
					+ "    res.ROOM_IDX, "
					+ "    res.STATE, "
					+ "    res.RESERVE_DATE, "
					+ "    res.PRICE as totalprice, "
					+ "    rd.RESERVE_DETAIL_IDX, "
					+ "    rd.CHECK_IN, "
					+ "    rd.CHECK_OUT, "
					+ "    rd.REQUEST, "
					+ "    hm.id as host_id, "
					+ "    hm.NICKNAME as host_nickname, "
					+ "    hm.idx as host_idx, "
					+ "    rm.image as room_img, "
					+ "    rm.price as price, "
					+ "	   rm.room_name "
					+ "FROM reservation res "
					+ "JOIN reservation_detail rd ON res.reserve_idx = rd.reserve_idx "
					+ "JOIN room rm ON res.room_idx = rm.room_idx "
					+ "JOIN homes_member hm ON rm.host_idx = hm.idx "
					+ "WHERE hm.idx = rm.host_idx and res.reserve_idx = ?";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reserve_idx);
			
			rs=ps.executeQuery();
			HashMap<String, Object> hm = new HashMap<String, Object>();
			if(rs.next()) {
				int member_idx = rs.getInt("member_idx");
				int room_idx = rs.getInt("room_idx");
				String state = rs.getString("state");
				java.sql.Date reserve_date = rs.getDate("reserve_date");
				int totalprice = rs.getInt("totalprice");
				int reserve_detail_idx = rs.getInt("reserve_detail_idx");
				java.sql.Date check_in = rs.getDate("check_in");
				java.sql.Date check_out = rs.getDate("check_out");
				String request = rs.getString("request");
				String host_id = rs.getString("host_id");
				String host_nickname = rs.getString("host_nickname");
				int host_idx = rs.getInt("host_idx");
				String room_img = rs.getString("room_img");
				int price = rs.getInt("price");
				String room_name = rs.getString("room_name");
				
				hm.put("reserve_idx", reserve_idx);
				hm.put("member_idx", member_idx);
				hm.put("room_idx", room_idx);
				hm.put("state", state);
				hm.put("reserve_date", reserve_date);
				hm.put("totalprice", totalprice);
				hm.put("reserve_detail_idx", reserve_detail_idx);
				hm.put("check_in", check_in);
				hm.put("check_out", check_out);
				hm.put("request", request);
				hm.put("host_id", host_id);
				hm.put("host_nickname", host_nickname);
				hm.put("host_idx", host_idx);
				hm.put("room_img", room_img);
				hm.put("price", price);
				hm.put("room_name", room_name);
			}
			
			return hm;
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
	
	//내가 찜한 목록 가져오기
	public ArrayList<LikeDTO> getMyLike(String id){
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT hl.idx as idx, r.room_idx, r.room_name, r.image as room_image, r.price, r.host_idx, hm.nickname as host_nickname, rg.region_name "
					+ "FROM room r "
					+ "JOIN region rg ON rg.region_idx = r.region_idx "
					+ "JOIN homes_member hm ON hm.idx = r.host_idx "
					+ "JOIN homes_member hm ON hm.idx = r.host_idx "
					+ "JOIN (SELECT room_idx, idx FROM homes_like WHERE member_idx = (SELECT idx FROM homes_member WHERE id = ? ) "
					+ "		) hl ON r.room_idx = hl.room_idx "
					+ "ORDER BY hl.idx desc";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			ArrayList<LikeDTO> arr = new ArrayList<LikeDTO>();
			while(rs.next()) {
				int idx = rs.getInt("idx");
				int room_idx = rs.getInt("room_idx");
				String room_name = rs.getString("room_name");
				String room_image = rs.getString("room_image");
				int price = rs.getInt("price");
				int host_idx = rs.getInt("host_idx");
				String host_nickname = rs.getString("host_nickname");
				String region_name = rs.getString("region_name");
				
				LikeDTO dto = new LikeDTO(idx, room_idx, room_name, room_image, price, host_idx, host_nickname, region_name);
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
	//찜 목록에 있는지 확인 & 찜 목록 번호 가져오기
	public int like(int member_idx, int room_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_LIKE WHERE MEMBER_IDX = ? AND ROOM_IDX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_idx);
			ps.setInt(2, room_idx);
			rs=ps.executeQuery();
			int like_idx = 0;
			if(rs.next()) {
				like_idx = rs.getInt("idx");
			}
			return like_idx;
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
	//해당 숙소가 찜 목록에 있는지 확인
	public boolean existLike(int member_idx, int room_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT * FROM HOMES_LIKE WHERE MEMBER_IDX=? AND ROOM_IDX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_idx);
			ps.setInt(2, room_idx);
			
			rs=ps.executeQuery();
			return rs.next();
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally{
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
			} catch (Exception e2) {}
		}
	}
	
	//찜 목록에 추가
	public int addLike(int member_idx, int room_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "INSERT INTO HOMES_LIKE VALUES "
					+ "(HOMES_LIKE_IDX.NEXTVAL, ?, ?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_idx);
			ps.setInt(2, room_idx);
			
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
	
	//찜 목록에서 제거
	public int dltLike(int like_idx) {
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "DELETE FROM HOMES_LIKE WHERE IDX = ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, like_idx);
			
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
	
	//내가 쓴 리뷰
	public ArrayList<HashMap<String, Object>> getMyReview(String id){
		try {
			conn = com.homes.db.HomesDB.getConn();
			String sql = "SELECT REVIEWS.*, ROOM.ROOM_NAME, ROOM.IMAGE "
					+ "FROM REVIEWS, ROOM "
					+ "WHERE REVIEWS.ROOM_IDX = ROOM.ROOM_IDX "
					+ "AND REVIEWS.MEMBER_ID = ? "
					+ "ORDER BY IDX DESC";
			ps=conn.prepareStatement(sql);
			ps.setString(1, id);
			
			ArrayList<HashMap<String, Object>> arr = new ArrayList<HashMap<String, Object>>();
			rs=ps.executeQuery();
			while(rs.next()) {
				int review_idx = rs.getInt("idx");
				int room_idx = rs.getInt("room_idx");
				int rate = rs.getInt("rate");
				//member_id
				String content = rs.getString("content");
				String room_name = rs.getString("room_name");
				String room_img = rs.getString("image");
				
				HashMap<String, Object> review = new HashMap<String, Object>();
				review.put("review_idx", review_idx);
				review.put("room_idx", room_idx);
				review.put("rate", rate);
				review.put("content", content);
				review.put("room_name", room_name);
				review.put("room_img", room_img);
				
				arr.add(review);
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
