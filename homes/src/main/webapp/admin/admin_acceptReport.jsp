<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String reportIdParam = request.getParameter("report_id");
    String commentIdParam = request.getParameter("comment_id");

    boolean success = false;

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

        conn.setAutoCommit(false);

        // 동일한 comment_id에 해당하는 모든 리뷰 삭제
        String deleteCommentsSql = "DELETE FROM reviews WHERE IDX = ?";
        pstmt = conn.prepareStatement(deleteCommentsSql);
        pstmt.setInt(1, commentId);
        int deletedRows = pstmt.executeUpdate();
        pstmt.close();

        if (deletedRows > 0) {

            // 동일한 comment_id에 해당하는 모든 신고 내역 삭제
            String deleteReportsSql = "DELETE FROM reports WHERE comment_id = ?";
            pstmt = conn.prepareStatement(deleteReportsSql);
            pstmt.setInt(1, commentId);
            pstmt.executeUpdate();

            conn.commit();
            success = true;
        } else {
            conn.rollback();
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
        out.println("<script>alert('처리 중 오류가 발생했습니다. 신고 처리에 실패했습니다.'); location.href='admin_reportlist.jsp';</script>");
    }
%>
