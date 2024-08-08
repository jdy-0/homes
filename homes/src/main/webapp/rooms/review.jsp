리뷰 8월 8일
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.homes.review.ReviewDAO, com.homes.review.ReviewDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 보기 및 작성</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    /* 기본 스타일 설정 */
    body {
        background-color: #e2dccc;
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin: 20px;
    }
    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fafafa;
        border-radius: 10px;
        border: 4px solid black;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .header {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        background-color: #dec022;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
    }
    .back-link a {
        text-decoration: none;
        color: black;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
        padding: 5px 10px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 18px;
        display: inline-block;
        margin-bottom: 20px;
    }
    .back-link a:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
    .review-list {
        margin-bottom: 30px;
    }
    .review-item {
        padding: 15px;
        margin-bottom: 15px;
        background-color: #f0f0f0;
        border-radius: 5px;
        border: 2px solid black;
    }
    .review-item p {
        margin: 5px 0;
        border-bottom: 1px solid #ddd;
        padding-bottom: 5px;
    }
    .review-form h3 {
        margin-bottom: 10px;
        font-size: 20px;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .review-form textarea {
        width: 100%;
        height: 100px;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
        font-size: 16px;
        resize: vertical;
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin-bottom: 10px;
    }
    .review-form button {
        padding: 10px 20px;
        background-color: #dec022;
        color: black;
        border: 2px solid black;
        cursor: pointer;
        border-radius: 5px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 16px;
    }
    .review-form button:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
<script>
    // 자바스크립트를 이용한 폼 유효성 검사
    function validateReviewForm() {
        const reviewText = document.querySelector('textarea[name="review"]').value.trim();
        if (reviewText === "") {
            alert("후기를 작성해주세요.");
            return false; // 폼 제출을 막음
        }
        return true; // 폼 제출을 허용
    }
</script>
</head>
<body>
<%@ include file="/header.jsp"%>
    <main class="container">
        <div class="back-link">
            <a href="information.jsp?room_idx=<%= request.getParameter("room_idx") %>">← 돌아가기</a>
        </div>
        <div class="header">
            후기 보기 및 작성
        </div>
        <div class="review-list">
            <!-- 후기 항목 출력 -->
            <%
                int roomIdx = Integer.parseInt(request.getParameter("room_idx"));
                ReviewDAO reviewDAO = new ReviewDAO();
                List<ReviewDTO> reviews = reviewDAO.getReviewsByRoomIdx(roomIdx);

                if (reviews != null && !reviews.isEmpty()) {
                    for (ReviewDTO review : reviews) {
            %>
                        <div class="review-item">
                            <p><strong>사용자:</strong> <%= review.getUserName() %></p>
                            <p><%= review.getContent() %></p>
                            <p><small><%= review.getCreatedAt() %></small></p>
                        </div>
            <%
                    }
                } else {
            %>
                    <p>아직 후기가 없습니다.</p>
            <%
                }
            %>
        </div>
        <div class="review-form">
            <form method="post" action="submitReview.jsp" onsubmit="return validateReviewForm();">
                <h3>후기 작성</h3>
                <textarea name="review" placeholder="후기를 작성하세요..."></textarea>
                <input type="hidden" name="room_idx" value="<%= roomIdx %>">
                <button type="submit">후기 제출</button>
            </form>
        </div>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>
