<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@ page import="com.homes.db.HomesDB" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>  <!-- 이 줄을 추가 -->

<%
    // 요청의 인코딩을 UTF-8로 설정
    request.setCharacterEncoding("UTF-8");
%>
<%
    String commentIdParam = request.getParameter("comment_id");
    String reportReason = request.getParameter("report_reason");
    String roomIdxParam = request.getParameter("room_idx");

    if (commentIdParam != null && reportReason != null && roomIdxParam != null) {
        int commentId = Integer.parseInt(commentIdParam);
        int roomIdx = Integer.parseInt(roomIdxParam);

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Database connection
            Context initContext = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
            conn = ds.getConnection();

            // SQL query to insert report
            String sql = "INSERT INTO reports (id, comment_id, room_idx, report_reason) VALUES (report_seq.NEXTVAL, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, commentId);
            pstmt.setInt(2, roomIdx);
            pstmt.setString(3, reportReason);
            pstmt.executeUpdate();

            // Redirect back to review.jsp with a success message
            response.sendRedirect("review.jsp?room_idx=" + roomIdx + "&reportSuccess=true");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    } else {
        out.println("Invalid request parameters.");
    }
%>
