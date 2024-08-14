<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Reviews for All Rooms</title>
<!-- <style>
    /* 기본 페이지 스타일 설정 */
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f4f4f4;
    }
    .container {
        max-width: 600px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h1 {
        text-align: center;
    }
    .message {
        color: green;
        font-weight: bold;
    }
    .error {
        color: red;
        font-weight: bold;
    }
</style>
</head>
<body>
   <div class="container">
        <h1>Insert Reviews for All Rooms</h1>
        <%
            // ReviewDAO 객체 생성
            ReviewDAO reviewDAO = new ReviewDAO();

            // 모든 숙소의 ID를 가져오는 메서드 호출
            List<Integer> allRoomIds = reviewDAO.getAllRoomIds();

            // 임의의 리뷰 데이터 배열
            String[] reviewTexts = {
                "자동 생성된 후기입니다. 정말 좋은 숙소였습니다!",
                "다시 방문하고 싶은 숙소입니다. 추천합니다.",
                "가격 대비 성능이 좋았습니다. 만족스러웠어요.",
                "편의 시설이 잘 갖춰져 있어 편리했습니다.",
                "청결 상태가 매우 좋았어요. 추천합니다!"
            };
            int[] reviewRates = {5, 4, 4, 5, 5};

            try {
                // 각 숙소에 대해 5개의 리뷰를 생성하고 데이터베이스에 삽입
                for (int roomId : allRoomIds) {
                    for (int i = 0; i < reviewTexts.length; i++) {
                        ReviewDTO review = new ReviewDTO();
                        review.setRoomIdx(roomId); // 숙소 ID 설정
                        review.setContent(reviewTexts[i]); // 리뷰 내용 설정
                        review.setRate(reviewRates[i]); // 별점 설정
                        reviewDAO.insertReview(review); // 리뷰 삽입 메서드 호출
                    }
                }
                out.println("<p class='message'>모든 숙소에 5개의 후기가 성공적으로 생성되었습니다.</p>");
            } catch (Exception e) {
                // 예외 발생 시 에러 메시지 출력
                out.println("<p class='error'>오류가 발생했습니다: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</body>
</html>-->  
