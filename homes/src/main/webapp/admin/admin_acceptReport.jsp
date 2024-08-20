<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 파라미터 값 받아오기
    String reportIdParam = request.getParameter("report_id");
    String commentIdParam = request.getParameter("comment_id");

    boolean success = false; // 처리 성공 여부를 나타내는 변수

    // 파라미터가 존재하지 않을 경우 예외 처리
    if (reportIdParam == null || commentIdParam == null) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='admin_reportlist.jsp';</script>");
        return;
    }

    int reportId = 0;
    int commentId = 0;

    try {
        reportId = Integer.parseInt(reportIdParam);
        commentId = Integer.parseInt(commentIdParam);
    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 ID 형식입니다.'); location.href='admin_reportlist.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
        conn = ds.getConnection();

        conn.setAutoCommit(false);  // 트랜잭션 시작

        // 댓글 삭제
        String deleteCommentSql = "DELETE FROM reviews WHERE IDX = ?";
        pstmt = conn.prepareStatement(deleteCommentSql);
        pstmt.setInt(1, commentId);
        int deletedRows = pstmt.executeUpdate();  // 삭제된 행 수 확인
        pstmt.close();

        if (deletedRows > 0) {
            // 신고 내역 삭제
            String deleteReportSql = "DELETE FROM reports WHERE id = ?";
            pstmt = conn.prepareStatement(deleteReportSql);
            pstmt.setInt(1, reportId);
            pstmt.executeUpdate();

            conn.commit();  // 트랜잭션 커밋
            success = true;
        } else {
            conn.rollback();  // 삭제가 안 되었을 경우 롤백
        }
    } catch (Exception e) {
        if (conn != null) try { conn.rollback(); } catch (SQLException se) { se.printStackTrace(); }
        System.out.println("Exception occurred: " + e.getMessage());
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }

    // 성공 여부에 따른 사용자 메시지 표시
    if (success) {
        out.println("<script>alert('신고가 성공적으로 처리되었습니다.'); location.href='admin_reportlist.jsp';</script>");
    } else {
        out.println("<script>alert('처리 중 오류가 발생했습니다. 그러나 신고가 처리된 것처럼 처리됩니다.'); location.href='admin_reportlist.jsp';</script>");
    }
%>
