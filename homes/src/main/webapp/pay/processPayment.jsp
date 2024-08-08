<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 처리 중...</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    body {
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
        text-align: center;
    }
    .container {
        max-width: 600px;
        margin: 100px auto;
        padding: 20px;
        background-color: #e2dccc;
        border: 4px solid black;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    .message {
        font-size: 24px;
        margin-bottom: 20px;
        font-family: 'SBAggroB', Arial, sans-serif;
        background-color: #dec022;
        padding: 10px;
        border-radius: 5px;
        border: 2px solid black;
    }
    .home-button {
        padding: 10px 20px;
        font-size: 20px;
        background-color: #dec022;
        color: black;
        border: 2px solid black;
        border-radius: 5px;
        cursor: pointer;
        text-decoration: none;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .home-button:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp"%>
    <div class="container">
        <div id="loading-message" class="message">결제 처리 중...</div>
        <div id="completion-message" class="message" style="display:none;">결제가 완료되었습니다.</div>
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
<%@ include file="/footer.jsp"%>
</body>
</html>
