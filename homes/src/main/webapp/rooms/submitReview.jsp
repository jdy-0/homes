<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<%
    String reviewContent = request.getParameter("review");
    int roomIdx = Integer.parseInt(request.getParameter("room_idx"));
    String userName = (String) session.getAttribute("userName"); // 사용자의 이름 또는 ID

    if (userName != null && !reviewContent.isEmpty()) {
        ReviewDTO review = new ReviewDTO();
        review.setRoomIdx(roomIdx);
        review.setUserName(userName);
        review.setContent(reviewContent);

        ReviewDAO reviewDAO = new ReviewDAO();
        reviewDAO.addReview(review);
    }

    response.sendRedirect("review.jsp?room_idx=" + roomIdx);
%>
