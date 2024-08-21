<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.report.ReportDTO, com.homes.report.ReportDAO" %>

<%
    try {
        // 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 파라미터 값 받기
        String commentIdParam = request.getParameter("comment_id");
        String reportReason = request.getParameter("report_reason");
        String roomIdxParam = request.getParameter("room_idx");

        // 디버깅 출력 (확인용)
        System.out.println("Comment ID: " + commentIdParam);
        System.out.println("Report Reason: " + reportReason);
        System.out.println("Room ID: " + roomIdxParam);

        // 파라미터 값 유효성 검사
        if (commentIdParam == null || commentIdParam.isEmpty() || 
            reportReason == null || reportReason.isEmpty() || 
            roomIdxParam == null || roomIdxParam.isEmpty()) {

            response.sendRedirect("errorPage.jsp?message=모든 필드를 입력해 주세요.");
            return;
        }

        int commentId = Integer.parseInt(commentIdParam);
        int roomIdx = Integer.parseInt(roomIdxParam);

        // ReportDTO 객체 생성 및 값 설정
        ReportDTO report = new ReportDTO();
        report.setCommentId(commentId);
        report.setRoomIdx(roomIdx);
        report.setReportReason(reportReason);

        // ReportDAO를 통해 데이터베이스에 저장
        ReportDAO reportDAO = new ReportDAO();
        reportDAO.insertReport(report);

        // 신고 처리 후 원래 페이지로 리디렉션
        response.sendRedirect("information.jsp?room_idx=" + roomIdx + "&reportSuccess=true");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while submitting the report: " + e.getMessage());
    }
%>
