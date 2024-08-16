<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 내역 관리</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    table, th, td {
        border: 1px solid black;
    }
    th, td {
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    #report-modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        padding: 20px;
        border: 1px solid black;
        width: 400px;
    }
</style>
<script>
    function showReportModal(reportId, commentId, roomIdx, reason) {
        document.getElementById('report-id').value = reportId;
        document.getElementById('comment-id').value = commentId;
        document.getElementById('room-idx').value = roomIdx;
        document.getElementById('report-reason').innerText = reason;
        document.getElementById('report-modal').style.display = 'block';
    }

    function closeReportModal() {
        document.getElementById('report-modal').style.display = 'none';
    }

    function acceptReport() {
        document.getElementById('report-form').action = "admin_acceptReport.jsp";
        document.getElementById('report-form').submit();
    }

    function rejectReport() {
        document.getElementById('report-form').action = "admin_rejectReport.jsp";
        document.getElementById('report-form').submit();
    }

</script>
</head>
<body>

<h2>신고 내역 관리</h2>
<table>
    <tr>
        <th>신고 ID</th>
        <th>댓글 ID</th>
        <th>숙소 ID</th>
        <th>신고 사유</th>
        <th>신고 날짜</th>
        <th>확인</th>
    </tr>
    <%
        // DB에서 신고 내역 불러오기
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Context initContext = new InitialContext();
            Context envContext  = (Context)initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)envContext.lookup("jdbc/myoracle");
            conn = ds.getConnection();

            String sql = "SELECT id, comment_id, room_idx, report_reason, TO_CHAR(report_date, 'YYYY-MM-DD HH24:MI:SS') as report_date FROM reports";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int reportId = rs.getInt("id");
                int commentId = rs.getInt("comment_id");
                int roomIdx = rs.getInt("room_idx");
                String reason = rs.getString("report_reason");
                String reportDate = rs.getString("report_date");
    %>
    <tr>
        <td><%= reportId %></td>
        <td><%= commentId %></td>
        <td><%= roomIdx %></td>
        <td><%= reason %></td>
        <td><%= reportDate %></td>
        <td><button type="button" onclick="showReportModal('<%= reportId %>', '<%= commentId %>', '<%= roomIdx %>', '<%= reason %>')">확인</button></td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    %>
</table>

<!-- 신고 확인 모달 -->
<div id="report-modal">
    <form id="report-form" method="post">
        <input type="hidden" id="report-id" name="report_id">
        <input type="hidden" id="comment-id" name="comment_id">
        <input type="hidden" id="room-idx" name="room_idx">
        <p><strong>신고 사유:</strong> <span id="report-reason"></span></p>
        <button type="button" onclick="acceptReport()">수락</button>
        <button type="button" onclick="rejectReport()">거절</button>
        <button type="button" onclick="closeReportModal()">닫기</button>
    </form>
</div>

</body>
</html>
