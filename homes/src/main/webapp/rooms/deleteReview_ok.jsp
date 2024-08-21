<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO" %>
<%
    // 요청의 인코딩을 UTF-8로 설정
    request.setCharacterEncoding("UTF-8");

    // 삭제할 리뷰 ID를 받아옵니다.
    String reviewIdParam = request.getParameter("review_id");
    String roomIdxParam = request.getParameter("room_idx");

    if (reviewIdParam != null && roomIdxParam != null) {
        int reviewId = Integer.parseInt(reviewIdParam);
        int roomIdx = Integer.parseInt(roomIdxParam);

        ReviewDAO reviewDAO = new ReviewDAO();
        boolean isDeleted = reviewDAO.deleteReviewById(reviewId);
        if (isDeleted) {
            response.sendRedirect("information.jsp?room_idx=" + roomIdx);
        } else {
            response.sendRedirect("errorPage.jsp?message=리뷰 삭제에 실패했습니다.");
        }
    } else {
        response.sendRedirect("errorPage.jsp?message=유효하지 않은 리뷰 ID 또는 Room ID입니다.");
    }
%>
