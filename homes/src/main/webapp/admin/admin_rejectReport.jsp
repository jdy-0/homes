<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%
    int reportId = Integer.parseInt(request.getParameter("report_id"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Context initContext = new InitialContext();
        Context envContext  = (Context)initContext.lookup("java:/comp/env");
        DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
        conn = ds.getConnection();

        // 신고 내역 삭제 (거절)
        String deleteReportSql = "DELETE FROM reports WHERE id = ?";
        pstmt = conn.prepareStatement(deleteReportSql);
        pstmt.setInt(1, reportId);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }

    response.sendRedirect("admin_reportlist.jsp");
%>
