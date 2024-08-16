package com.homes.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.homes.db.HomesDB;

public class ReviewDAO {

    /**
     * 새로운 리뷰를 데이터베이스에 추가하는 메서드
     */
	   // 리뷰 추가 메서드 (MEMBER_ID 추가)
    public void insertReview(ReviewDTO review) {
        String sql = "INSERT INTO reviews (IDX, ROOM_IDX, RATE, MEMBER_ID, CONTENT) VALUES (Reviews_SEQ.NEXTVAL, ?, ?, ?, ?)";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, review.getRoomIdx());
            pstmt.setInt(2, review.getRate());
            pstmt.setString(3, review.getMemberId()); // MEMBER_ID 추가
            pstmt.setString(4, review.getContent());

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 특정 숙소의 모든 리뷰 가져오기 (MEMBER_ID 추가)
    public List<ReviewDTO> getReviewsByRoomIdx(int roomIdx) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT idx, room_idx, rate, member_id, content FROM reviews WHERE room_idx = ? ORDER BY idx DESC"; 

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdx(rs.getInt("idx"));
                review.setRoomIdx(rs.getInt("room_idx"));
                review.setRate(rs.getInt("rate"));
                review.setMemberId(rs.getString("member_id")); // MEMBER_ID 추가
                review.setContent(rs.getString("content"));
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public List<ReviewDTO> getReviewsByRoomIdxWithPaging(int roomIdx, int pageNum, int pageSize) throws Exception {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT ROWNUM rnum, a.* FROM (SELECT idx, room_idx, rate, content FROM reviews WHERE room_idx = ? ORDER BY idx DESC) a WHERE ROWNUM <= ?) WHERE rnum > ?";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            int startRow = (pageNum - 1) * pageSize + 1;
            int endRow = pageNum * pageSize;

            pstmt.setInt(1, roomIdx);
            pstmt.setInt(2, endRow);
            pstmt.setInt(3, startRow - 1);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdx(rs.getInt("idx"));
                review.setRoomIdx(rs.getInt("room_idx"));
                review.setRate(rs.getInt("rate"));
                review.setContent(rs.getString("content"));
                reviews.add(review);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }
    /**
     * 특정 숙소의 전체 리뷰 개수를 가져오는 메서드

     */
    public int getReviewCountByRoomIdx(int roomIdx) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM reviews WHERE room_idx = ?";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    /**
     * 모든 숙소(Room)의 ID를 가져오는 메서드
     * 
     * @return 모든 숙소의 ID를 담고 있는 리스트
     */
    public List<Integer> getAllRoomIds() {
        List<Integer> roomIds = new ArrayList<>();
        String sql = "SELECT ROOM_IDX FROM Room"; // Room 테이블에서 모든 ROOM_IDX 가져오기

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                roomIds.add(rs.getInt("ROOM_IDX"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roomIds;
    }
    public boolean isValidRoomIdx(int roomIdx) {
        String sql = "SELECT COUNT(*) FROM Room WHERE ROOM_IDX = ?";
        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public String submitReview(int roomIdx, String reviewContent, int rate, String userName) {
        if (userName != null && roomIdx > 0 && rate > 0 && reviewContent != null && !reviewContent.trim().isEmpty()) {
            if (!isValidRoomIdx(roomIdx)) {
                return "errorPage.jsp?message=Invalid%20room%20ID";
            }

            ReviewDTO review = new ReviewDTO();
            review.setRoomIdx(roomIdx);
            review.setRate(rate);
            review.setContent(reviewContent);

            String memberId = convertUserNameToMemberId(userName);
            review.setMemberId(memberId);

            try (Connection conn = HomesDB.getConn()) {
                conn.setAutoCommit(false);
                insertReview(review);
                conn.commit();
                return "review.jsp?room_idx=" + roomIdx;
            } catch (SQLException e) {
                e.printStackTrace();
                return "errorPage.jsp?message=Failed%20to%20submit%20review";
            } catch (Exception e) {  // 여기에 추가된 catch 블록으로 Exception을 잡음
                e.printStackTrace();
                return "errorPage.jsp?message=Failed%20to%20submit%20review";
            }
        } else {
            return "errorPage.jsp?message=Invalid%20review%20submission";
        }
    }


    // userName을 memberId로 변환하는 메서드 (필요시)
    private String convertUserNameToMemberId(String userName) {
        // 회원 테이블에서 userName에 해당하는 memberId를 조회하는 로직 추가
        // 예를 들어, SELECT member_id FROM members WHERE user_name = ?
        // 간단히 반환한다고 가정할 경우:
        return userName; // 필요에 따라 실제 변환 로직 구현
    }
    public double getAverageRateByRoomIdx(int roomIdx) throws Exception {
        double averageRate = 0.0;
        String sql = "SELECT AVG(rate) AS avgRate FROM reviews WHERE room_idx = ?";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                averageRate = rs.getDouble("avgRate");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return averageRate;
    }


}
