<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 보기 및 작성</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff; 
        border: 1px solid #ccc;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    .header {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: left;
    }
    .review-list {
        margin-bottom: 20px;
    }
    .review-item {
        border-bottom: 1px solid #ccc;
        padding-bottom: 10px;
        margin-bottom: 10px;
    }
    .review-item:last-child {
        border-bottom: none;
    }
    .review-form {
        margin-top: 20px;
    }
    .review-form textarea {
        width: 100%;
        height: 100px;
        margin-bottom: 10px;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .review-form button {
        display: block;
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        text-align: center;
        border-radius: 5px;
        font-size: 16px;
    }
    .review-form button:hover {
        background-color: #0056b3;
    }
    .back-link {
        text-align: left;
        margin-bottom: 20px;
    }
    .back-link a {
        color: #007BFF;
        text-decoration: none;
    }
    .back-link a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <main class="container">
        <div class="back-link">
            <a href="index.jsp">← 메인 페이지로 돌아가기</a>
        </div>
        <div class="header">
            후기 보기 및 작성
        </div>
        <div class="review-list">
            <!-- 후기 항목 출력 -->
            <%
                List<String> reviews = (List<String>) session.getAttribute("reviews");
                if (reviews != null && !reviews.isEmpty()) {
                    for (String review : reviews) {
            %>
                        <div class="review-item">
                            <p><strong>사용자:</strong> <%= review %></p>
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
            <form method="post" action="submitReview.jsp">
                <h3>후기 작성</h3>
                <textarea name="review" placeholder="후기를 작성하세요..."></textarea>
                <button type="submit">후기 제출</button>
            </form>
        </div>
    </main>
</body>
</html>
