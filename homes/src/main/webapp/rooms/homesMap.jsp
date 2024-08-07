<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 위치</title>
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
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    .location-header, .rules-header {
        font-size: 18px;
        margin-bottom: 10px;
    }
    .map-container {
        width: 100%;
        height: 400px;
        background-image: url('path_to_map_image.jpg'); /* 여기에 지도의 이미지 경로를 지정 */
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        position: relative;
        border: 1px solid #ddd;
        border-radius: 10px;
        margin-bottom: 20px;
        overflow: hidden;
    }
    .map-marker {
        width: 40px;
        height: 40px;
        background-image: url('path_to_marker_icon.png'); /* 마커 아이콘 경로 */
        background-size: cover;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -100%);
    }
    .zoom-controls {
        text-align: center;
        margin-bottom: 20px;
    }
    .zoom-controls button {
        padding: 10px;
        font-size: 18px;
        margin: 5px;
        cursor: pointer;
        border: none;
        background-color: #007BFF;
        color: white;
        border-radius: 5px;
    }
    .zoom-controls button:hover {
        background-color: #0056b3;
    }
    .rules {
        margin-top: 20px;
    }
</style>
</head>
<body>
    <div class="container">
        <div class="location-header">
            <h2>숙소 위치</h2>
            <p>부산광역시 ____동</p>
        </div>
        <div class="zoom-controls">
            <button id="zoom-in">확대</button>
            <button id="zoom-out">축소</button>
        </div>
        <div class="map-container" id="map-container">
            <div class="map-marker"></div> <!-- 마커 표시 -->
        </div>
        <div class="rules-header">
            <h2>숙소 이용 규칙</h2>
        </div>
        <div class="rules">
            <p>체크인 시간: 오후 2시 ~</p>
            <p>체크아웃 시간: 오전 11시까지</p>
            <p>게스트 정원: 2인</p>
        </div>
    </div>

    <script>
        // 지도 확대/축소 기능
        var zoomLevel = 1;
        var mapContainer = document.getElementById('map-container');

        document.getElementById('zoom-in').addEventListener('click', function() {
            zoomLevel += 0.1;
            mapContainer.style.backgroundSize = (zoomLevel * 100) + '%';
        });

        document.getElementById('zoom-out').addEventListener('click', function() {
            if (zoomLevel > 0.5) { // 최소 확대 제한
                zoomLevel -= 0.1;
                mapContainer.style.backgroundSize = (zoomLevel * 100) + '%';
            }
        });
    </script>
</body>
</html>
