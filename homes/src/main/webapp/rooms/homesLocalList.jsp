<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 리스트</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
    }
    .filter {
        display: flex;
        justify-content: flex-start;
        margin-bottom: 20px;
    }
    .filter button {
        padding: 10px 20px;
        background-color: #007BFF;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 5px;
        font-size: 16px;
    }
    .filter button:hover {
        background-color: #0056b3;
    }
    .homes-list {
        display: flex;
        flex-wrap: wrap;
        gap: 20px;
    }
    .home-card {
        width: 30%;
        background-color: white;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        position: relative;
        cursor: pointer; /* 이미지 클릭 가능하도록 설정 */
        text-decoration: none; /* 링크에서 텍스트 데코레이션 제거 */
        color: inherit; /* 링크 클릭시 텍스트 색상 유지 */
    }
    .home-card img {
        width: 100%;
        height: auto;
        display: block;
    }
    .home-card h3 {
        font-size: 20px;
        margin: 10px;
    }
    .home-card p {
        font-size: 14px;
        margin: 5px 10px;
        color: #666;
    }
    .home-card .price {
        font-size: 16px;
        font-weight: bold;
        margin: 10px;
    }
    .home-card .favorite {
        position: absolute;
        top: 10px;
        right: 10px;
        cursor: pointer;
    }
    .home-card .favorite img {
        width: 24px;
        height: 24px;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="filter">
            <button>필터</button>
        </div>
        <div class="homes-list">
            <a href="information.jsp?home=부산+아파트&price=152000" class="home-card">
                <img src="img/apartment.jpg" alt="숙소 이미지">
                <div class="favorite">
                    <img src="favorite_icon.png" alt="즐겨찾기">
                </div>
                <h3>부산 아파트</h3>
                <p>오션뷰 / 해운대역 도보 10분</p>
                <p class="price">152,000원/1박</p>
            </a>
            <a href="information.jsp?home=부산+아파트&price=152000" class="home-card">
                <img src="img/farm.jpg" alt="숙소 이미지">
                <div class="favorite">
                    <img src="favorite_icon.png" alt="즐겨찾기">
                </div>
                <h3>부산 아파트</h3>
                <p>오션뷰 / 해운대역 도보 10분</p>
                <p class="price">152,000원/1박</p>
            </a>
            <a href="information.jsp?home=부산+아파트&price=152000" class="home-card">
                <img src="img/hotel.jpg" alt="숙소 이미지">
                <div class="favorite">
                    <img src="favorite_icon.png" alt="즐겨찾기">
                </div>
                <h3>부산 아파트</h3>
                <p>오션뷰 / 해운대역 도보 10분</p>
                <p class="price">152,000원/1박</p>
            </a>
        </div>
    </div>
</body>
</html>
