<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO" %>
<%@ page import="com.homes.review.ReviewDAO" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.util.concurrent.TimeUnit" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    String roomIdxParam = request.getParameter("room_idx");
    RoomDTO room = null;
    double averageRate = 0.0;

    if (roomIdxParam != null && !roomIdxParam.isEmpty()) {
        try {
            int roomIdx = Integer.parseInt(roomIdxParam);
            RoomDAO roomDAO = new RoomDAO();
            room = roomDAO.getRoomById(roomIdx);
            if (room != null) {
                // 평균 평점 계산
                ReviewDAO reviewDAO = new ReviewDAO();
                averageRate = reviewDAO.getAverageRateByRoomIdx(roomIdx);
            } else {
                out.println("<p>해당 숙소 정보를 찾을 수 없습니다.</p>");
            }
        } catch (NumberFormatException e) {
            out.println("<p>유효하지 않은 숙소 ID입니다.</p>");
        }
    } else {
        out.println("<p>유효하지 않은 숙소 ID입니다.</p>");
    }

    String checkInParam = request.getParameter("check_in");
    String checkOutParam = request.getParameter("check_out");

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    long numberOfNights = 1; // 기본값 1박

    try {
        if (checkInParam != null && checkOutParam != null) {
            Date checkInDate = dateFormat.parse(checkInParam);
            Date checkOutDate = dateFormat.parse(checkOutParam);

            long diffInMillies = checkOutDate.getTime() - checkInDate.getTime();
            numberOfNights = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);

            if (numberOfNights < 1) {
                numberOfNights = 1; // 체크아웃이 체크인보다 빠르다면 기본값 1박
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 총 숙박 비용 계산
    long totalCost = room != null ? room.getPrice() * numberOfNights : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>숙소 정보</title>
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
    .details {
        margin-top: 10px;
        font-size: 24px;
        font-weight: bold;
        border-bottom: 2px solid black;
        padding-bottom: 5px;
        text-align: center;
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
<%@ include file="/header.jsp"%>
<main class="container">
    <% if (room != null) { %>
        <div class="top">
            <h1>숙소 정보</h1>
            <div class="room-details">
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
                <div style="display: flex; align-items: center; background-color: #dec022; padding: 10px; border-radius: 5px; border: 2px solid black;">
                    <span style="font-size: 18px; font-family: 'SBAggroB', Arial, sans-serif; margin-right: auto;">
                        (후기) ★ <%= new DecimalFormat("#.0").format(averageRate) %> / 5.0
                    </span>
                    <a href="review.jsp?room_idx=<%= room.getRoom_idx() %>" style="text-decoration: none; color: black; background-color: #dec022; border: 2px solid black; border-radius: 5px; padding: 5px 10px; font-family: 'SBAggroB', Arial, sans-serif; font-size: 18px;">
                        후기 보기
                    </a>
                </div>
            </div>
        </div>
        <div class="right">
            <p class="price">₩<%= room.getPrice() %> / 박</p>
            <div>
				<input type="text" name="check_in" value="<%= (request.getParameter("check_in") != null) ? request.getParameter("check_in") : "" %>" readonly="readonly">
				<input type="text" name="check_out" value="<%= (request.getParameter("check_out") != null) ? request.getParameter("check_out") : "" %>" readonly="readonly">
            	<jsp:include page="information_cal.jsp">
            		<jsp:param value="<%=roomIdxParam %>" name="room"/>
            		<jsp:param value="<%=room.getPrice() %>" name="price"/>
            	</jsp:include>
            	
            </div>
			<label for="checkin">인원수</label> <input type="number" name="guest_num" id="select_guest" min="2" value="<%=(request.getParameter("guest_num")!=null) ?request.getParameter("guest_num"):2 %>" required>
            <a href="<%= room.getMap_url() %>" class="button map-link">지도 보기</a>
            <div class="reservation-box">
                <div class="details">

                    <p>총 합계: ₩<span id="room_total_price"><%= room.getPrice() %></span></p>
                </div>
                <form id="reservationForm" action="reservationConfirmation.jsp" method="get">
                	
                    <input type="hidden" name="room_idx" value="<%= room.getRoom_idx() %>" id="hid_room_idx">
                    <input type="hidden" name="price" value="<%= room.getPrice() %>" id="hid_room_price">
                    <input type="hidden" name="total_price" value="0" id="hid_room_total_price">
                    <input type="hidden" name="check_in" value="<%= request.getParameter("check_in") %>" id="hid_check_in">
                    <input type="hidden" name="check_out" value="<%= request.getParameter("check_out") %>" id="hid_check_out">
                    <input type="hidden" name="guest_num" value="<%= request.getParameter("guest_num") %>" id="hid_guest_num">
                    <button type="submit" class="button" onclick="setInputValuesTohidden()">예약하기</button>

                </form>
            </div>
        </div>
    <% } else { %>
        <p>해당 숙소 정보를 찾을 수 없습니다.</p>
    <% } %>
</main>
<%@ include file="/footer.jsp"%>
</body>
</html>
<script>
function setInputValuesTohidden(){
	var ch_in = document.querySelector('input[name="check_in"]');
	var ch_out = document.querySelector('input[name="check_out"]');
	var gst_n = document.querySelector('input[name="guest_num"]');
	var room_total_price = document.querySelector('#room_total_price');
	
	
	document.querySelector('#hid_check_in').value = ch_in.value;
	document.querySelector('#hid_check_out').value = ch_out.value;
	document.querySelector('#hid_guest_num').value = gst_n.value;
	document.querySelector('#hid_room_total_price').value = room_total_price.innerText;
	

}


</script>
</html>
