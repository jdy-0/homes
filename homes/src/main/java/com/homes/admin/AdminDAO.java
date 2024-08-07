package com.homes.admin;

import java.sql.*;
import java.util.*;
import com.homes.guest.GuestDTO;

/**
 * AdminDAO 클래스는 데이터베이스와 상호작용하여 관리자(admin) 정보를 처리합니다.
 * 이 클래스는 관리자의 로그인 검증, 정보 조회 등을 수행하는 메서드를 제공합니다.
 */
public class AdminDAO {
    
    /**
     * 데이터베이스 연결을 반환하는 메서드
     * 
     * @return Connection 데이터베이스 연결 객체
     * @throws SQLException 데이터베이스 연결 시 발생할 수 있는 예외
     */
    private Connection getConnection() throws SQLException {
        // 데이터베이스 연결 코드
        // 여기에 JDBC 드라이버, URL, 유저네임, 패스워드를 설정하는 로직이 필요합니다.
        // 예시:
        // return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        return null; // 실제 구현 필요
    }

    /**
     * 관리자의 로그인 자격을 확인하는 메서드
     * 
     * @param id 로그인 시 입력된 아이디
     * @param pwd 로그인 시 입력된 비밀번호
     * @return 로그인 결과 (1: 로그인 성공, 0: 비밀번호 불일치, -1: 아이디 없음, -2: 예외 발생)
     */
    public int loginCheck(String id, String pwd) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection(); // 데이터베이스 연결
            String sql = "SELECT pwd FROM admin WHERE id = ?"; // 관리자의 비밀번호를 조회하는 SQL 쿼리
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id); // 아이디 바인딩
            rs = pstmt.executeQuery();

            if (rs.next()) { // 아이디가 존재하는 경우
                String dbPwd = rs.getString("pwd");
                if (dbPwd.equals(pwd)) {
                    return 1; // 비밀번호가 일치하면 로그인 성공
                } else {
                    return 0; // 비밀번호 불일치
                }
            } else {
                return -1; // 아이디가 존재하지 않음
            }
        } catch (Exception e) {
            e.printStackTrace();
            return -2; // 예외 발생
        } finally {
            // 자원 해제 (메모리 누수 방지)
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }

    /**
     * 관리자의 정보를 조회하는 메서드
     * 
     * @param id 관리자의 아이디
     * @return AdminDTO 관리자의 정보를 담고 있는 객체
     */
    public AdminDTO getAdminInfo(String id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        AdminDTO admin = null;

        try {
            conn = getConnection(); // 데이터베이스 연결
            String sql = "SELECT * FROM admin WHERE id = ?"; // 관리자의 모든 정보를 조회하는 SQL 쿼리
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id); // 아이디 바인딩
            rs = pstmt.executeQuery();

            if (rs.next()) { // 결과가 존재하는 경우
                admin = new AdminDTO(); // AdminDTO 객체 생성
                admin.setIdx(rs.getInt("idx"));
                admin.setId(rs.getString("id"));
                admin.setPwd(rs.getString("pwd"));
                admin.setName(rs.getString("name"));
                admin.setDept(rs.getString("dept"));
                admin.setEmail(rs.getString("email"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 해제
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }

        return admin; // 관리자의 정보가 담긴 DTO 객체 반환
    }

    /**
     * 모든 게스트 정보를 가져오는 메서드
     * 
     * @return List<GuestDTO> 게스트 정보를 담고 있는 리스트
     */
    public List<GuestDTO> getAllGuests() {
        List<GuestDTO> guests = new ArrayList<>();
        String sql = "SELECT * FROM guest"; // 게스트 테이블에서 모든 데이터를 조회하는 SQL 쿼리
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                GuestDTO guest = new GuestDTO();
                guest.setIdx(rs.getInt("idx"));
                guest.setId(rs.getString("id"));
                guest.setPwd(rs.getString("pwd"));
                guest.setName(rs.getString("name"));
                guest.setNickname(rs.getString("nickname"));
                guest.setBday(rs.getString("bday"));
                guest.setEmail(rs.getString("email"));
                guest.setTel(rs.getString("tel"));
                guest.setJoindate(rs.getDate("joindate"));
                guests.add(guest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return guests;
    }

    // 여기에 추가적인 관리자 관련 CRUD 메서드를 구현할 수 있습니다.
    // 예를 들어, 관리자를 추가, 삭제, 업데이트하는 메서드 등을 추가할 수 있습니다.
}
