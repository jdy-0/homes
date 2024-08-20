<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<%@ page import="java.util.List" %>  <!-- List 임포트 -->
<jsp:useBean id="reviewDAO" class="com.homes.review.ReviewDAO" scope="request" />
<jsp:useBean id="reviewDTO" class="com.homes.review.ReviewDTO" scope="request" />

<%
    String roomIdxParam = request.getParameter("room_idx");
    if (roomIdxParam != null && !roomIdxParam.isEmpty()) {
        int roomIdx = Integer.parseInt(roomIdxParam);
        
        // 리뷰 데이터를 가져오는 예시
        List<ReviewDTO> reviews = reviewDAO.getReviewsByRoomIdx(roomIdx);
        
        // 이 정보를 페이지에 표시하거나, 추가적인 처리를 할 수 있습니다.
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기 작성 완료</title>
</head>
<body>
    <h2>후기 작성이 완료되었습니다!</h2>
    <p><a href="information.jsp?room_idx=<%= request.getParameter("room_idx") %>">숙소 정보로 돌아가기</a></p>
</body>
</html>
