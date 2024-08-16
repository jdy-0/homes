<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO" %>
<%@ page import="com.homes.review.ReviewDTO" %>
<%
    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 파라미터 값 받기
    String roomIdxParam = request.getParameter("room_idx");
    String reviewContent = request.getParameter("review");
    String rateParam = request.getParameter("rate");

    int roomIdx = 0;  // 변수 선언
    int rate = 0;

    // 파라미터가 null인지 확인하고 기본값 설정
    if (roomIdxParam != null && !roomIdxParam.isEmpty() &&
        reviewContent != null && !reviewContent.trim().isEmpty() &&
        rateParam != null && !rateParam.isEmpty()) {
        
        roomIdx = Integer.parseInt(roomIdxParam);
        rate = Integer.parseInt(rateParam);

        // 기본 사용자 이름 설정
        String userName = "Anonymous";  // 기본값으로 임의의 사용자 이름 설정

        // ReviewDAO 객체 생성
        ReviewDAO reviewDAO = new ReviewDAO();
        // 리뷰 추가 후 리디렉션할 URL 생성
        String redirectUrl = reviewDAO.submitReview(roomIdx, reviewContent, rate, userName);
        // 페이지 리디렉션
        response.sendRedirect(redirectUrl);
    } else {
        // 파라미터가 잘못된 경우 처리
        response.sendRedirect("errorPage.jsp"); // 예시로 에러 페이지로 리디렉션
    }
%>
