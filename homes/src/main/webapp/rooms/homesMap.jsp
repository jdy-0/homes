<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 위치</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<style>
    body {
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        background-color: #e2dccc;
        border: 4px solid black;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .location-header, .rules-header {
        font-size: 24px;
        margin-bottom: 10px;
        font-family: 'SBAggroB', Arial, sans-serif;
        background-color: #dec022;
        padding: 10px;
        border: 2px solid black;
        border-radius: 5px;
    }
    .map-container {
        width: 100%;
        height: 400px;
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        position: relative;
        border: 2px solid black;
        border-radius: 10px;
        margin-bottom: 20px;
        overflow: hidden;
    }
    .map-marker {
        width: 40px;
        height: 40px;
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
        border: 2px solid black;
        background-color: #dec022;
        color: black;
        border-radius: 5px;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .zoom-controls button:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
    .rules {
        margin-top: 20px;
    }
    .back-link {
        text-align: left;
        margin-bottom: 20px;
    }
    .back-link a {
        color: black;
        text-decoration: none;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
        padding: 5px 10px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 18px;
    }
    .back-link a:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp"%>
    <div class="container">
        <div class="back-link">
            <a href="information.jsp?room_idx=<%= request.getParameter("room_idx") %>">← 뒤로 가기</a>
        </div>
        <%
            int roomIdx = Integer.parseInt(request.getParameter("room_idx"));
            RoomDAO roomDAO = new RoomDAO();
            RoomDTO room = roomDAO.getRoomById(roomIdx);
            String location = room.getAddr_detail(); // 숙소의 위치 정보 가져오기
            String mapImagePath = "/homes/images/maps/" + roomIdx + ".jpg"; // 지도 이미지 경로 (가정)
        %>
        <div class="location-header">
            <h2>숙소 위치</h2>
            <p><%= location %></p>
        </div>
        <div class="zoom-controls">
            <button id="zoom-in">확대</button>
            <button id="zoom-out">축소</button>
        </div>
        <div class="map-container" id="map-container" style="background-image: url('<%= mapImagePath %>');">
            <div class="map-marker"></div> <!-- 마커 표시 -->
        </div>
        <div class="rules-header">
            <h2>숙소 이용 규칙</h2>
        </div>
        <div class="rules">
            <p>체크인 시간: 오후 2시 ~</p>
            <p>체크아웃 시간: 오전 11시까지</p>
            <p>게스트 정원: 인</p>
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
<%@ include file="/footer.jsp"%>
</body>
</html>
