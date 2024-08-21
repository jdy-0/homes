<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<%
    // 요청의 인코딩을 UTF-8로 설정
    request.setCharacterEncoding("UTF-8");

    // 수정된 리뷰 정보를 받아옵니다.
    String reviewIdParam = request.getParameter("review_id");
    String reviewContent = request.getParameter("review_content");
    String roomIdxParam = request.getParameter("room_idx");
    String rateParam = request.getParameter("rate");

    if (reviewIdParam != null && reviewContent != null && roomIdxParam != null && rateParam != null) {
        int reviewId = Integer.parseInt(reviewIdParam);
        int roomIdx = Integer.parseInt(roomIdxParam);
        int rate = Integer.parseInt(rateParam);

        ReviewDAO reviewDAO = new ReviewDAO();
        ReviewDTO review = reviewDAO.getReviewById(reviewId);
        if (review != null) {
            review.setContent(reviewContent);
            review.setRate(rate); // 별점 업데이트
            boolean isUpdated = reviewDAO.updateReview(review);
            if (isUpdated) {
                response.sendRedirect("information.jsp?room_idx=" + roomIdx);
            } else {
                response.sendRedirect("errorPage.jsp?message=리뷰 수정에 실패했습니다.");
            }
        } else {
            response.sendRedirect("errorPage.jsp?message=리뷰를 찾을 수 없습니다.");
        }
    } else {
        response.sendRedirect("errorPage.jsp?message=리뷰 수정에 필요한 정보가 부족합니다.");
    }
%>
