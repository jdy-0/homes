<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<!-- 외부 스타일 시트 연결 -->
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">

<style>
    body {
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    header, footer {
        text-align: center;
        background-color: #dec022;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
    }
    header h1 {
        font-size: 32px;
        margin: 0;
    }
    footer {
        margin-top: 20px;
    }
    #sidebar {
        width: 200px;
        float: left;
        padding: 20px;
        background-color: #e2dccc;
        border: 3px solid black;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        min-height: 600px; /* 최소 높이 설정 */
    }
    #sidebar ul {
        list-style-type: none;
        padding: 0;
    }
    #sidebar ul li {
        margin-bottom: 10px;
    }
    #sidebar ul li a {
        text-decoration: none;
        color: black;
        background-color: #dec022;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
        display: block;
        text-align: center;
    }
    #sidebar ul li a:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
    #content {
        margin-left: 230px;
        padding: 20px;
        background-color: #fff;
        border: 3px solid black;
        border-radius: 10px;
        min-height: 600px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    #content h2 {
        font-size: 24px;
        margin-bottom: 20px;
    }
</style>

<script>
    function loadContent(contentType) {
        var contentDiv = document.getElementById('content');
        switch(contentType) {
            case 'dashboard':
                contentDiv.innerHTML = '<h2>대시보드</h2><p>여기에 대시보드 내용을 표시합니다.</p>';
                break;
            case 'member':
                contentDiv.innerHTML = '<h2>회원 관리</h2><p>여기에 회원 관리 내용을 표시합니다.</p>';
                break;
            case 'property':
                contentDiv.innerHTML = '<h2>숙소 관리</h2><p>여기에 숙소 관리 내용을 표시합니다.</p>';
                break;
            case 'reviews':
                contentDiv.innerHTML = '<h2>후기 관리</h2><p>여기에 후기 관리 내용을 표시합니다.</p>';
                break;
            case 'qna':
                contentDiv.innerHTML = '<h2>QnA</h2><p>여기에 QnA 내용을 표시합니다.</p>';
                break;
            default:
                contentDiv.innerHTML = '<h2>관리자 페이지</h2><p>옵션을 선택하여 내용을 표시하세요.</p>';
                break;
        }
    }
</script>
</head>
<body onload="loadContent('dashboard')">

    <!-- 헤더 영역 -->
    <header>
        <h1>관리자 페이지</h1>
    </header>

    <!-- 사이드바 영역 -->
    <div id="sidebar">
        <ul>
            <li><a href="javascript:void(0);" onclick="loadContent('dashboard')">대시보드</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('member')">회원 관리</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('property')">숙소 관리</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('reviews')">후기 관리</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('qna')">QnA</a></li>
        </ul>
    </div>

    <!-- 콘텐츠 영역 -->
    <div id="content">
        <!-- 선택된 메뉴에 따른 내용이 동적으로 표시됩니다. -->
    </div>

    <!-- 푸터 영역 -->
    <footer>
        Copyright © Homes. All Rights Reserved.
    </footer>

</body>
</html>
