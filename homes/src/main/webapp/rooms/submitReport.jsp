<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.report.ReportDTO, com.homes.report.ReportDAO" %>

<%
    try {
        request.setCharacterEncoding("UTF-8");

        String commentIdParam = request.getParameter("comment_id");
        String reportReason = request.getParameter("report_reason");
        String roomIdxParam = request.getParameter("room_idx");

        // 파라미터 값 유효성 검사
        if (commentIdParam == null || commentIdParam.isEmpty() || reportReason == null || reportReason.isEmpty() || roomIdxParam == null || roomIdxParam.isEmpty()) {
            response.sendRedirect("errorPage.jsp?message=모든 필드를 입력해 주세요.");
            return;
        }

        int commentId = Integer.parseInt(commentIdParam);
        int roomIdx = Integer.parseInt(roomIdxParam);

        ReportDTO report = new ReportDTO();
        report.setCommentId(commentId);
        report.setRoomIdx(roomIdx);
        report.setReportReason(reportReason);

        ReportDAO reportDAO = new ReportDAO();
        reportDAO.insertReport(report);

        // 디버깅 메시지 출력
        System.out.println("Report inserted successfully.");

        // 신고 처리 후 원래 페이지로 리디렉션
        response.sendRedirect("information.jsp?room_idx=" + roomIdx + "&reportSuccess=true");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while submitting the report: " + e.getMessage());
    }
%>
