<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<%
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

        // 로그인된 사용자 세션에서 닉네임 가져오기
        String userName = (String) session.getAttribute("userName");

        if (userName != null) {
            // ReviewDAO 객체 생성
            ReviewDAO reviewDAO = new ReviewDAO();
            // 리뷰 추가 후 리디렉션할 URL 생성
            String redirectUrl = reviewDAO.submitReview(roomIdx, reviewContent, rate, userName);
            // 페이지 리디렉션
            response.sendRedirect(redirectUrl);
        } else {
            // 로그인이 안된 경우 처리
            response.sendRedirect("/homes/guest/login.jsp"); // 로그인 페이지로 리디렉션 예시
        }
    } else {
        // 파라미터가 잘못된 경우 처리
        response.sendRedirect("errorPage.jsp"); // 예시로 에러 페이지로 리디렉션
    }
%>
