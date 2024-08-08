package com.homes.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.homes.db.HomesDB;

public class ReviewDAO {

    // 후기 조회
    public List<ReviewDTO> getReviewsByRoomIdx(int roomIdx) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE room_idx = ? ORDER BY created_at DESC";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setId(rs.getInt("id"));
                review.setRoomIdx(rs.getInt("room_idx"));
                review.setUserName(rs.getString("user_name"));
                review.setContent(rs.getString("content"));
                review.setCreatedAt(rs.getTimestamp("created_at"));
                reviews.add(review);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reviews;
    }

    // 후기 저장
    public void addReview(ReviewDTO review) {
        String sql = "INSERT INTO reviews (room_idx, user_name, content) VALUES (?, ?, ?)";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, review.getRoomIdx());
            pstmt.setString(2, review.getUserName());
            pstmt.setString(3, review.getContent());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
