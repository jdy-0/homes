<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 처리 중...</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
        text-align: center;
    }
    .container {
        max-width: 600px;
        margin: 100px auto;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    .message {
        font-size: 24px;
        margin-bottom: 20px;
    }
    .home-button {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
    }
    .home-button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp"%>
    <div class="container">
        <div id="loading-message" class="message">결제 처리 중...</div>
        <div id="completion-message" class="message" style="display:none;">결제가 완료되었습니다.</div>
        <!-- 경로를 절대 경로로 수정 -->
        <a href="/homes/index.jsp" id="home-button" class="home-button" style="display:none;">홈으로</a>
    </div>

    <script>
        // 결제 처리 시뮬레이션
        setTimeout(function() {
            document.getElementById('loading-message').style.display = 'none';
            document.getElementById('completion-message').style.display = 'block';
            document.getElementById('home-button').style.display = 'inline-block';
        }, 3000); // 3초 후 결제 완료 메시지 표시
    </script>
</body>
<%@ include file="/footer.jsp"%>
</html>
