<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.homes.report.ReportDAO" %>
<%@ page import="com.homes.report.ReportDTO" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 내역 관리</title>
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
<link rel="stylesheet" type="text/css" href="../css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="../css/adminLayout.css">
</head>
<body>
<%@ include file="adminheader.jsp"%>
<section>
<article>
<fieldset class="title">
<h2>관리자페이지</h2>
</fieldset>
</article>
<article class="adminContent">
<%@include file="adminSideBar.jsp" %>
<fieldset id="reportList">
<h2>신고 내역 관리</h2>
<%
	ReportDAO reportDAO = new ReportDAO();
	List<ReportDTO> reports = reportDAO.getAllReports();
	
	if(reports == null || reports.size()==0){
		%>
		<h2>신고 내역이 없습니다.</h2>
		<%
	}else{
%>
<table id="reportListTable">
    <tr>
        <th>신고 ID</th>
        <th>댓글 ID</th>
        <th>숙소 ID</th>
        <th>신고 사유</th>
        <th>신고 날짜</th>
        <th>확인</th>
    </tr>
    <%
        

        for (ReportDTO report : reports) {
    %>
    <tr>
        <td><%= report.getId() %></td>
        <td><%= report.getCommentId() %></td>
        <td><%= report.getRoomIdx() %></td>
        <td><%= report.getReportReason() %></td>
        <td><%= report.getReportDate() %></td>
        <td><button type="button" class="rbutton" onclick="showReportModal('<%= report.getId() %>', '<%= report.getCommentId() %>', '<%= report.getRoomIdx() %>', '<%= report.getReportReason() %>')">확인</button></td>
    </tr>
    <%
        }
    %>
</table>
	<%} %>
</fieldset>
</article>
<!-- 신고 확인 모달 -->
<div id="report-modal">
    <form id="report-form" method="post">
        <input type="hidden" id="report-id" name="report_id">
        <input type="hidden" id="comment-id" name="comment_id">
        <input type="hidden" id="room-idx" name="room_idx">
        <p><strong>신고 사유:</strong> <span id="report-reason"></span></p>
        <button type="button" class="rbutton" onclick="acceptReport()">수락</button>
        <button type="button" class="rbutton" onclick="rejectReport()">거절</button>
        <button type="button" class="rbutton" onclick="closeReportModal()">닫기</button>
    </form>
</div>

</section>
</body>
</html>
