package com.homes.report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.homes.db.HomesDB;

public class ReportDAO {
    private DataSource dataSource;

    public ReportDAO() {
        try {
            Context initContext = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            dataSource = (DataSource)envContext.lookup("jdbc/myoracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void insertReport(ReportDTO report) throws SQLException {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dataSource.getConnection();
            String sql = "INSERT INTO reports (idx, comment_id, room_idx, report_reason, report_date) VALUES (report_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, report.getCommentId());
            pstmt.setInt(2, report.getRoomIdx());
            pstmt.setString(3, report.getReportReason());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    public List<ReportDTO> getAllReports() {
        List<ReportDTO> reports = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = dataSource.getConnection();
            String sql = "SELECT idx, comment_id, room_idx, report_reason, TO_CHAR(report_date, 'YYYY-MM-DD HH24:MI:SS') as report_date FROM reports";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                ReportDTO report = new ReportDTO();
                report.setId(rs.getInt("idx"));
                report.setCommentId(rs.getInt("comment_id"));
                report.setRoomIdx(rs.getInt("room_idx"));
                report.setReportReason(rs.getString("report_reason"));
                report.setReportDate(rs.getString("report_date"));
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }

        return reports;
    }

    // 신고 수락: 댓글 삭제 및 신고 내역 삭제
    public boolean acceptReport(int reportId, int commentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dataSource.getConnection();
            conn.setAutoCommit(false);  // 트랜잭션 시작

            // 리뷰(댓글) 삭제
            String deleteCommentSql = "DELETE FROM reviews WHERE IDX = ?";
            pstmt = conn.prepareStatement(deleteCommentSql);
            pstmt.setInt(1, commentId);  // commentId 값 바인딩
            int deletedRows = pstmt.executeUpdate();  // 실행 후 삭제된 행 수 확인
            pstmt.close();

            if (deletedRows == 0) {
                // 리뷰 삭제 실패 시 오류 처리
                System.out.println("리뷰 삭제 실패: 해당 리뷰가 존재하지 않거나 이미 삭제되었습니다.");
                conn.rollback();
                return false;
            }

            // 신고 내역 삭제
            String deleteReportSql = "DELETE FROM reports WHERE idx = ?";
            pstmt = conn.prepareStatement(deleteReportSql);
            pstmt.setInt(1, reportId);  // reportId 값 바인딩
            pstmt.executeUpdate();

            conn.commit();  // 트랜잭션 커밋
            return true;
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException se) { se.printStackTrace(); }
            System.out.println("Exception occurred: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }

    // 신고 거절: 신고 내역만 삭제
    public boolean rejectReport(int reportId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = dataSource.getConnection();

            // 신고 내역 삭제
            String deleteReportSql = "DELETE FROM reports WHERE idx = ?";
            pstmt = conn.prepareStatement(deleteReportSql);
            pstmt.setInt(1, reportId);  // reportId 값 바인딩
            pstmt.executeUpdate();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    }
    // 특정 숙소의 모든 신고를 가져오는 메서드
    public List<ReportDTO> getReportsByRoomIdx(int roomIdx) {
        List<ReportDTO> reports = new ArrayList<>();
        String sql = "SELECT * FROM reports WHERE room_idx = ?";

        try (Connection conn = HomesDB.getConn();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomIdx);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                ReportDTO report = new ReportDTO();
                report.setId(rs.getInt("idx"));
                report.setRoomIdx(rs.getInt("room_idx"));
                report.setCommentId(rs.getInt("comment_id"));
                report.setReportReason(rs.getString("report_reason"));
                reports.add(report);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return reports;
    }
}



