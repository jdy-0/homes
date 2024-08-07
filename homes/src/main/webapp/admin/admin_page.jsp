<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<!-- 외부 스타일 시트 연결 -->
<link rel="stylesheet" type="text/css" href="css/mainLayout.css">

<style>
    /* 사이드바 스타일 설정 */
    #sidebar {
        width: 200px; /* 사이드바 너비 설정 */
        float: left; /* 사이드바를 왼쪽에 배치 */
    }
    
    /* 콘텐츠 영역 스타일 설정 */
    #content {
        margin-left: 210px; /* 사이드바 공간을 확보하기 위해 왼쪽 여백 설정 */
        padding: 20px; /* 콘텐츠 내부 여백 설정 */
        min-height: 600px; /* 화면이 작을 때도 최소 높이 설정 */
    }

    /* 콘텐츠 영역의 제목 스타일 */
    #content h2 {
        font-size: 24px; /* 제목의 폰트 크기 설정 */
        margin-bottom: 20px; /* 제목과 콘텐츠 사이의 여백 설정 */
    }
</style>

<script>
    /**
     * loadContent 함수는 선택한 메뉴에 따라 콘텐츠 영역을 동적으로 변경하는 역할을 합니다.
     *
     * @param {string} contentType - 표시할 콘텐츠 유형 ('dashboard', 'member', 'property', 'reviews', 'qna')
     */
    function loadContent(contentType) {
        // 콘텐츠를 표시할 div 요소를 가져옵니다.
        var contentDiv = document.getElementById('content');
        
        // 선택된 콘텐츠 유형에 따라 다른 내용을 로드합니다.
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
<body onload="loadContent('dashboard')"> <!-- 페이지가 로드될 때 기본적으로 대시보드 내용을 표시합니다. -->

    <!-- 헤더 영역 -->
    <header>
        <h1>관리자 페이지</h1> <!-- 페이지 제목 -->
    </header>

    <!-- 사이드바 영역 -->
    <div id="sidebar">
        <ul>
            <!-- 사이드바 메뉴 항목 -->
            <li><a href="javascript:void(0);" onclick="loadContent('dashboard')">대시보드</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('member')">회원 관리</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('property')">숙소 관리</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('reviews')">후기 관리</a></li>
            <li><a href="javascript:void(0);" onclick="loadContent('qna')">QnA</a></li>
        </ul>
    </div>

    <!-- 콘텐츠 영역 -->
    <div id="content">
        <!-- 이곳에 선택된 메뉴에 따른 내용이 동적으로 표시됩니다. -->
    </div>

    <!-- 푸터 영역 -->
    <footer>
        Copyright © Homes. All Rights Reserved. <!-- 저작권 정보 표시 -->
    </footer>

</body>
</html>
