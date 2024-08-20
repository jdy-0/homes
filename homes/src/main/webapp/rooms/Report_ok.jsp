<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.report.ReportDAO, com.homes.report.ReportDTO" %>
<%@ page import="java.util.List" %>  <!-- List 임포트 -->
<jsp:useBean id="reportDAO" class="com.homes.report.ReportDAO" scope="request" />
<jsp:useBean id="reportDTO" class="com.homes.report.ReportDTO" scope="request" />

<%
    String roomIdxParam = request.getParameter("room_idx");
    if (roomIdxParam != null && !roomIdxParam.isEmpty()) {
        int roomIdx = Integer.parseInt(roomIdxParam);
        
        // 신고 데이터를 가져오는 예시
        List<ReportDTO> reports = reportDAO.getReportsByRoomIdx(roomIdx);
        
        // 이 정보를 페이지에 표시하거나, 추가적인 처리를 할 수 있습니다.
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>신고 완료</title>
</head>
<body>
    <h2>신고가 완료되었습니다!</h2>
    <p><a href="information.jsp?room_idx=<%= request.getParameter("room_idx") %>">숙소 정보로 돌아가기</a></p>
</body>
</html>
