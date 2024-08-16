<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 파라미터 값 받아오기
    String reportIdParam = request.getParameter("report_id");
    String commentIdParam = request.getParameter("comment_id");

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

        // 트랜잭션 시작
        conn.setAutoCommit(false);

        // 댓글 삭제
        String deleteCommentSql = "DELETE FROM comments WHERE id = ?";
        pstmt = conn.prepareStatement(deleteCommentSql);
        pstmt.setInt(1, commentId);
        pstmt.executeUpdate();
        pstmt.close();

        // 신고 내역 삭제
        String deleteReportSql = "DELETE FROM reports WHERE id = ?";
        pstmt = conn.prepareStatement(deleteReportSql);
        pstmt.setInt(1, reportId);
        pstmt.executeUpdate();

        // 트랜잭션 커밋
        conn.commit();
        
    } catch (Exception e) {
        // 트랜잭션 롤백
        if (conn != null) try { conn.rollback(); } catch (SQLException se) { se.printStackTrace(); }
        e.printStackTrace();
        out.println("<script>alert('처리 중 오류가 발생했습니다.'); location.href='admin_reportlist.jsp';</script>");
        return;
    } finally {
        // 리소스 해제
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }

    response.sendRedirect("admin_reportlist.jsp");
%>
