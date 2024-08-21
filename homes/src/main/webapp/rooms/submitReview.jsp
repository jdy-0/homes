<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>

<%
    try {
        // 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 파라미터 값 받기
        String memberId = request.getParameter("member_id");
        String reviewContent = request.getParameter("review");
        String rateParam = request.getParameter("rate");
        String roomIdxParam = request.getParameter("room_idx");

        // 디버깅 출력 (확인용)
        System.out.println("Member ID: " + memberId);
        System.out.println("Review Content: " + reviewContent);
        System.out.println("Rate: " + rateParam);
        System.out.println("Room ID: " + roomIdxParam);

        // 파라미터 값 유효성 검사
        if (memberId == null || memberId.isEmpty() || 
            reviewContent == null || reviewContent.isEmpty() || 
            rateParam == null || rateParam.isEmpty() || 
            roomIdxParam == null || roomIdxParam.isEmpty()) {

            response.sendRedirect("errorPage.jsp?message=모든 필드를 입력해 주세요.");
            return;
        }

        int roomIdx = Integer.parseInt(roomIdxParam);
        int rate = Integer.parseInt(rateParam);

        // ReviewDTO 객체 생성 및 값 설정
        ReviewDTO review = new ReviewDTO();
        review.setMemberId(memberId);
        review.setContent(reviewContent);
        review.setRoomIdx(roomIdx);
        review.setRate(rate);

        // ReviewDAO를 통해 데이터베이스에 저장
        ReviewDAO reviewDAO = new ReviewDAO();
        reviewDAO.insertReview(review);

        // 리뷰 추가 후 원래 페이지로 리다이렉트
        response.sendRedirect("information.jsp?room_idx=" + roomIdx);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("An error occurred while submitting the review: " + e.getMessage());
    }
%>
