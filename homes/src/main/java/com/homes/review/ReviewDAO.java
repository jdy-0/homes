package com.homes.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.homes.db.HomesDB;

public class ReviewDAO {

    // 새로운 리뷰를 데이터베이스에 추가하는 메서드
    public void insertReview(ReviewDTO review) {
        String sql = "INSERT INTO reviews (ROOM_IDX, RATE, CONTENT) VALUES (?, ?, ?)";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 리뷰 데이터를 SQL 쿼리의 파라미터로 설정
            pstmt.setInt(1, review.getRoomIdx());  // 숙소 번호
            pstmt.setInt(2, review.getRate());     // 별점
            pstmt.setString(3, review.getContent());// 리뷰 내용

            // SQL 실행
            pstmt.executeUpdate();
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력
            e.printStackTrace();
        }
    }

    // addReview 메서드 추가: insertReview를 호출하는 메서드
    public void addReview(ReviewDTO review) {
        insertReview(review); // insertReview 메서드를 호출하여 리뷰를 추가
    }

    // 모든 숙소의 ID를 가져오는 메서드
    public List<Integer> getAllRoomIds() {
        List<Integer> roomIds = new ArrayList<>();
        String sql = "SELECT ROOM_IDX FROM accommodations"; // 숙소 ID를 가져오는 SQL 문

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            // 결과 집합에서 모든 숙소 ID를 리스트에 추가
            while (rs.next()) {
                roomIds.add(rs.getInt("ROOM_IDX"));
            }
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력
            e.printStackTrace();
        }
        return roomIds; // 숙소 ID 리스트 반환
    }

    // 특정 숙소(roomIdx)에 대한 리뷰 목록을 가져오는 메서드
    public List<ReviewDTO> getReviewsByRoomIdx(int roomIdx) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE room_idx = ? ORDER BY idx DESC"; 

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 숙소 ID를 SQL 쿼리에 설정
            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            // 결과 집합을 반복하며 ReviewDTO 객체를 생성하고 리스트에 추가
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdx(rs.getInt("idx"));          // 리뷰 번호
                review.setRoomIdx(rs.getInt("room_idx")); // 숙소 번호
                review.setRate(rs.getInt("rate"));        // 별점
                review.setContent(rs.getString("content"));// 리뷰 내용
                reviews.add(review);
            }
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력
            e.printStackTrace();
        }
        return reviews; // 리뷰 리스트 반환
    }

    // 특정 숙소(roomIdx)에 대한 리뷰 목록을 조회수(view_count) 기준으로 정렬하여 가져오는 메서드
    public List<ReviewDTO> getReviewsByRoomIdxSortedByViewCount(int roomIdx) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE room_idx = ?"; 

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 숙소 ID를 SQL 쿼리에 설정
            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            // 결과 집합을 반복하며 ReviewDTO 객체를 생성하고 리스트에 추가
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdx(rs.getInt("idx"));          // 리뷰 번호
                review.setRoomIdx(rs.getInt("room_idx")); // 숙소 번호
                review.setRate(rs.getInt("rate"));        // 별점
                review.setContent(rs.getString("content"));// 리뷰 내용
                reviews.add(review);
            }
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력
            e.printStackTrace();
        }
        return reviews; // 리뷰 리스트 반환
    }

    // 페이징을 위한 메서드: 특정 숙소의 리뷰를 페이지 단위로 가져옴
    public List<ReviewDTO> getReviewsByRoomIdxWithPaging(int roomIdx, int pageNum, int pageSize) {
        List<ReviewDTO> reviews = new ArrayList<>();
        String sql = "SELECT * FROM (SELECT ROWNUM rnum, a.* FROM (SELECT * FROM reviews WHERE room_idx = ? ORDER BY idx DESC) a WHERE ROWNUM <= ?) WHERE rnum > ?";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 페이징을 위한 시작 행과 끝 행 계산
            int startRow = (pageNum - 1) * pageSize + 1;
            int endRow = pageNum * pageSize;

            // SQL 쿼리에 파라미터로 설정
            pstmt.setInt(1, roomIdx);
            pstmt.setInt(2, endRow);
            pstmt.setInt(3, startRow - 1);

            ResultSet rs = pstmt.executeQuery();

            // 결과 집합을 반복하며 ReviewDTO 객체를 생성하고 리스트에 추가
            while (rs.next()) {
                ReviewDTO review = new ReviewDTO();
                review.setIdx(rs.getInt("idx"));          // 리뷰 번호
                review.setRoomIdx(rs.getInt("room_idx")); // 숙소 번호
                review.setRate(rs.getInt("rate"));        // 별점
                review.setContent(rs.getString("content"));// 리뷰 내용
                reviews.add(review);
            }
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력
            e.printStackTrace();
        }
        return reviews; // 페이징 처리된 리뷰 리스트 반환
    }

    // 특정 숙소의 전체 리뷰 개수를 가져오는 메서드
    public int getReviewCountByRoomIdx(int roomIdx) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM reviews WHERE room_idx = ?";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // 숙소 ID를 SQL 쿼리에 설정
            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            // 리뷰 개수를 결과 집합에서 가져옴
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            // 예외 발생 시 스택 트레이스를 출력
            e.printStackTrace();
        }
        return count; // 리뷰 개수 반환
    }
}
