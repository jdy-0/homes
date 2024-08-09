package com.homes.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.homes.db.HomesDB;

/**
 * ReviewDAO 클래스는 데이터베이스와 상호작용하여 리뷰 데이터를 관리하는 역할을 합니다.
 */
public class ReviewDAO {

    /**
     * 특정 숙소(roomIdx)에 대한 리뷰 목록을 가져오는 메서드
     * 
     * @param roomIdx 해당 숙소의 ID
     * @return 해당 숙소에 대한 리뷰 리스트(List<ReviewDTO>)
     */
    public List<ReviewDTO> getReviewsByRoomIdx(int roomIdx) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE room_idx = ? ORDER BY created_at DESC";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdx(rs.getInt("idx"));          // 후기 번호
                review.setRoomIdx(rs.getInt("room_idx")); // 숙소 번호
                review.setRate(rs.getInt("rate"));        // 별점
                review.setContent(rs.getString("content"));// 리뷰 내용
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    /**
     * 새로운 리뷰를 데이터베이스에 추가하는 메서드
     * 
     * @param review 저장할 리뷰 데이터를 담고 있는 ReviewDTO 객체
     */
    public void addReview(ReviewDTO review) {
        String sql = "INSERT INTO reviews (idx, room_idx, rate, content) VALUES (Reviews_SEQ.NEXTVAL, ?, ?, ?)";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, review.getRoomIdx());  // 숙소 번호
            pstmt.setInt(2, review.getRate());     // 별점
            pstmt.setString(3, review.getContent());// 리뷰 내용

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
