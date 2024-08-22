package com.homes.reservation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // 특정 유저가 특정 숙소에 대한 예약이 있는지 확인하는 메소드
    public List<ReservationDTO> getReservationsByUserIdAndRoomIdx(int member_idx, int room_idx) {
        List<ReservationDTO> reservations = new ArrayList<>();
        try {
            conn = com.homes.db.HomesDB.getConn();  // 데이터베이스 연결
            String sql = "SELECT * FROM reservation WHERE member_idx = ? AND room_idx = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, member_idx);
            ps.setInt(2, room_idx);
            rs = ps.executeQuery();

            while (rs.next()) {
                ReservationDTO reservation = new ReservationDTO();
                reservation.setReserve_idx(rs.getInt("reserve_idx"));
                reservation.setMember_idx(rs.getInt("member_idx"));
                reservation.setRoom_idx(rs.getInt("room_idx"));
                reservation.setState(rs.getString("state"));
                reservation.setReserve_date(rs.getDate("reserve_date"));
                reservation.setPrice(rs.getInt("price"));

                reservations.add(reservation);
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
        return reservations;
    }
}
