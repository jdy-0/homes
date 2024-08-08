<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 리스트</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
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
        cursor: pointer;
        text-decoration: none;
        color: inherit;
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
<%@ include file="/header.jsp"%>
    <div class="container">
        <div class="filter">
            <button>필터</button>
        </div>
        <div class="homes-list">
            <% 
                RoomDAO roomDAO = new RoomDAO();
                List<RoomDTO> rooms = roomDAO.getAllRooms(); // 모든 방 데이터를 가져옴
                if (rooms != null && !rooms.isEmpty()) {
                    for (RoomDTO room : rooms) {
            %>
            <a href="information.jsp?room_idx=<%= room.getRoom_idx() %>" class="home-card">
                <img src="<%= room.getImage() %>" alt="숙소 이미지">
                <div class="favorite">
                    <img src="favorite_icon.png" alt="즐겨찾기">
                </div>
                <h3><%= room.getRoom_name() %></h3>
                <p><%= room.getGoodthing() %></p>
                <p class="price"><%= room.getPrice() %>원/1박</p>
            </a>
            <% 
                    }
                } else {
            %>
            <p>해당 지역에 대한 숙소 데이터가 없습니다.</p>
            <% 
                }
            %>
        </div>
    </div>
    <%@ include file="/footer.jsp"%>
</body>
</html>
