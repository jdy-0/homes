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
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    .pagination a {
        margin: 0 5px;
        padding: 10px 15px;
        border: 1px solid #ccc;
        color: black;
        text-decoration: none;
    }
    .pagination a.active {
        background-color: #dec022;
        color: white;
        border-color: black;
    }
    .review-form h3 {
        margin-bottom: 10px;
        font-size: 20px;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .review-inputs {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .review-inputs textarea {
        flex-grow: 1;
        height: 100px;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
        font-size: 16px;
        resize: vertical;
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
    }
    .star-rating {
        direction: rtl; /* 별을 왼쪽에서 오른쪽으로 정렬 */
        display: inline-flex;
        font-size: 3rem; /* 별 크기 조절 */
        cursor: pointer; /* 마우스 커서를 포인터로 변경 */
        user-select: none; /* 사용자가 별을 선택할 수 없도록 설정 */
    }

    /* 라디오 버튼 숨기기 */
    .star-rating input[type="radio"] {
        display: none;
    }

    /* 기본 별 색상 설정 */
    .star-rating label {
        color: #ddd; /* 비활성화된 별 색상 */
        transition: color 0.2s ease-in-out; /* 별 색상이 변할 때의 애니메이션 */
    }

    /* 선택된 별과 그 왼쪽에 있는 별들의 색상 변경 */
    .star-rating input[type="radio"]:checked ~ label {
        color: #ffc107; /* 활성화된 별 색상 */
    }

    /* 별 위에 마우스를 올렸을 때 (hover) 색상 변경 */
    .star-rating label:hover,
    .star-rating label:hover ~ label {
        color: #ffc107; /* 별을 호버할 때의 색상 */
    }

    .review-form button {
        margin-top: 10px;
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
        const rateValue = document.querySelector('input[name="rate"]:checked');
        if (reviewText === "") {
            alert("후기를 작성해주세요.");
            return false; // 폼 제출을 막음
        }
        if (!rateValue) {
            alert("별점을 선택해주세요.");
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
                int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
                int pageSize = 10;

                ReviewDAO reviewDAO = new ReviewDAO();

                // 페이징된 리뷰 가져오기
                List<ReviewDTO> reviews = reviewDAO.getReviewsByRoomIdxWithPaging(roomIdx, pageNum, pageSize);
                int totalReviewCount = reviewDAO.getReviewCountByRoomIdx(roomIdx);
                int totalPageCount = (int) Math.ceil(totalReviewCount / (double) pageSize);

                if (reviews != null && !reviews.isEmpty()) {
                    for (ReviewDTO review : reviews) {
            %>
                        <div class="review-item">
                            <p><strong>별점:</strong> <%= review.getRate() %>점</p>
                            <p><%= review.getContent() %></p>
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

        <!-- 페이지 네비게이션 -->
        <div class="pagination">
            <% for (int i = 1; i <= totalPageCount; i++) { %>
                <a href="review.jsp?room_idx=<%= roomIdx %>&page=<%= i %>" class="<%= i == pageNum ? "active" : "" %>"><%= i %></a>
            <% } %>
        </div>

        <!-- 후기 작성 폼 -->
        <div class="review-form">
            <form method="post" action="submitReview.jsp" onsubmit="return validateReviewForm();">
                <div class="review-header">
                    <h3>후기 작성</h3>
                    <div class="star-rating">
                        <input type="radio" id="star5" name="rate" value="5"><label for="star5">★</label>
                        <input type="radio" id="star4" name="rate" value="4"><label for="star4">★</label>
                        <input type="radio" id="star3" name="rate" value="3"><label for="star3">★</label>
                        <input type="radio" id="star2" name="rate" value="2"><label for="star2">★</label>
                        <input type="radio" id="star1" name="rate" value="1"><label for="star1">★</label>
                    </div>
                </div>
                <div class="review-inputs">
                    <textarea name="review" placeholder="후기를 작성하세요..."></textarea>
                </div>
                <input type="hidden" name="room_idx" value="<%= roomIdx %>">
                <button type="submit">후기 제출</button>
            </form>
        </div>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>
