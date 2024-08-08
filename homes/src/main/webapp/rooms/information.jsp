<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 정보</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<script>
// 로그인 여부를 확인하는 함수
function checkLogin() {
    var isLoggedIn = '<%= session.getAttribute("userid") != null %>'; // 세션에 userid가 있는지 확인
    if (!isLoggedIn) {
        alert("로그인이 필요한 서비스입니다.");
        openLoginPopup(); // 로그인 팝업을 띄우는 함수 호출
    } else {
        document.getElementById('reservationForm').submit(); // 로그인 상태이면 예약 진행
    }
}

// 로그인 팝업을 여는 함수
function openLoginPopup(){
    var option = 'width=600, height=300, resizable=no, top=200, left=470';
    window.open('/homes/guest/login_popup.jsp?redirect=information.jsp?room_idx=<%=request.getParameter("room_idx")%>&checkin=<%=request.getParameter("checkin")%>&checkout=<%=request.getParameter("checkout")%>&guests=<%=request.getParameter("guests")%>', 'login', option);
}
</script>
<style>
    body {
        font-family: 'Ownglyph_meetme-Rg', Arial, sans-serif;
        margin: 20px;
        background-color: #f8f9fa;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background-color: #e2dccc;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border: 4px solid black;
        border-radius: 10px;
        min-height: 800px;
        display: grid;
        grid-template-areas: 
            "top top"
            "left right";
        grid-gap: 20px;
    }
    .top {
        grid-area: top;
    }
    .left {
        grid-area: left;
    }
    .right {
        grid-area: right;
        padding: 20px;
        border: 3px solid black;
        border-radius: 10px;
        background-color: #fff;
    }
    .header {
        margin-bottom: 20px;
    }
    .header h1 {
        font-size: 32px;
        margin: 0;
        background-color: #dec022;
        padding: 10px;
        border-radius: 5px;
        border: 2px solid black;
    }
    .room-images {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
    }
    .room-images img {
        width: 48%;
        border-radius: 10px;
        border: 2px solid black;
    }
    .room-details h2 {
        font-size: 28px;
        margin: 0;
        padding: 10px;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
    }
    .room-details p {
        font-size: 20px;
        margin: 10px 0;
        border-bottom: 2px solid black;
        padding-bottom: 5px;
    }
    .room-details .price {
        font-size: 24px;
        font-weight: bold;
        margin: 20px 0;
        border-bottom: 3px solid black;
        padding-bottom: 5px;
    }
    .room-details .button {
        display: block;
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        text-align: center;
        color: black;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
        text-decoration: none;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 20px;
    }
    .room-details .button:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
    .reservation-box {
        margin-top: 20px;
        padding: 20px;
        border: 3px solid black;
        border-radius: 10px;
        background-color: #e2dccc;
        font-size: 20px;
    }
    .reservation-box .price-info {
        font-size: 24px;
        font-weight: bold;
        border-bottom: 2px solid black;
        padding-bottom: 5px;
    }
    .reservation-box .details {
        margin-top: 10px;
        font-size: 18px;
        border-bottom: 2px solid black;
        padding-bottom: 5px;
    }
    .reviews h3 {
        font-size: 24px;
        padding: 10px;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
        font-family: 'SBAggroB', Arial, sans-serif;
    }
    .reviews a {
        text-decoration: none;
        color: black;
        background-color: #dec022;
        border: 2px solid black;
        border-radius: 5px;
        padding: 5px 10px;
        font-family: 'SBAggroB', Arial, sans-serif;
        font-size: 18px;
    }
    .reviews a:hover {
        background-color: #e2dccc;
        transition: 0.5s;
    }
</style>
</head>
<body>
<%@ include file="/header.jsp"%> <!-- 헤더에서 유저 정보를 가져올 수 있습니다. -->
    <main class="container">
        <div class="top">
            <h1>숙소 정보</h1>
            <div class="room-details">
                <%
                    int roomIdx = Integer.parseInt(request.getParameter("room_idx"));
                    RoomDAO roomDAO = new RoomDAO();
                    RoomDTO room = roomDAO.getRoomById(roomIdx);
                    if (room != null) {
                %>
                <h2><%= room.getRoom_name() %></h2>
                <p><%= room.getGoodthing() %></p>
                <p><%= room.getAddr_detail() %></p>
                <div class="room-images">
                    <img src="<%= room.getImage() %>" alt="메인 숙소 이미지">
                    <img src="<%= room.getImage() %>" alt="서브 숙소 이미지 1">
                    <img src="<%= room.getImage() %>" alt="서브 숙소 이미지 2">
                    <img src="<%= room.getImage() %>" alt="서브 숙소 이미지 3">
                </div>
            </div>
        </div>
        <div class="left">
            <div class="reviews">
                <h3>후기 <a href="review.jsp?room_idx=<%= room.getRoom_idx() %>">(후기)</a></h3>
                <p>별점: ★ </p>
            </div>
        </div>
        <div class="right">
            <p class="price">₩<%= room.getPrice() %> / 박</p>
            <a href="<%= room.getMap_url() %>" class="button map-link">지도 보기</a>
            <div class="reservation-box">
                <div class="price-info">₩<%= room.getPrice() %> / 박</div>
                <div class="details">
                    <p>체크인: <%= request.getParameter("checkin") %></p>
                    <p>체크아웃: <%= request.getParameter("checkout") %></p>
                    <p>인원: <%= request.getParameter("guests") %></p>
                </div>
                <%
                    int serviceFee = (int)(room.getPrice() * 0.1);
                    int totalPrice = room.getPrice() + serviceFee;
                %>
                <p>서비스 수수료: ₩<%= serviceFee %></p>
                <p>총 합계: ₩<%= totalPrice %></p>
                <form id="reservationForm" action="reservationConfirmation.jsp" method="get">
                    <input type="hidden" name="room_idx" value="<%= room.getRoom_idx() %>">
                    <input type="hidden" name="checkin" value="<%= request.getParameter("checkin") %>">
                    <input type="hidden" name="checkout" value="<%= request.getParameter("checkout") %>">
                    <input type="hidden" name="guests" value="<%= request.getParameter("guests") %>">
                    <button type="submit" class="button">예약하기</button>
                </form>
            </div>
            <% } else { %>
                <p>해당 숙소 정보를 찾을 수 없습니다.</p>
            <% } %>
        </div>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>