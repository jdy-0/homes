<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.homes.room.RoomDAO, com.homes.room.RoomDTO" %>

<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdto" class="com.homes.room.RoomDTO" scope="session"></jsp:useBean>
<%
    String roomIdxParam = request.getParameter("room_idx");
	int idx= Integer.parseInt(roomIdxParam);
    RoomDTO room = null;
	
    // room_idx가 null이거나 빈 문자열인 경우 기본값 또는 에러 처리
    if (roomIdxParam != null && !roomIdxParam.isEmpty()) {
        try {
            int roomIdx = Integer.parseInt(roomIdxParam);
            RoomDAO roomDAO = new RoomDAO();
            room = roomDAO.getRoomById(roomIdx);
            if (room == null) {
                out.println("해당 숙소 정보를 찾을 수 없습니다.");
            }
        } catch (NumberFormatException e) {
            // room_idx 파라미터가 유효하지 않은 경우 처리
            out.println("유효하지 않은 숙소 ID입니다.");
        }
    } else {
        // room_idx 파라미터가 유효하지 않은 경우 처리
        out.println("유효하지 않은 숙소 ID입니다.");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙소 정보</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/rating.css"> <!-- 추가된 rating.css 링크 -->
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
        grid-area: flex;
    }
    .right {
        grid-area: flex;
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
        width: 25%;
        border-radius: 10px;
        border: 2px solid black;
    }
    .room-main img{
    	width: 650px;
       	height: 450px;
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
    .reviews{
    	
        padding: 20px;
        border: 3px solid black;
        border-radius: 10px;
        background-color: #fff;
    	margin: 10px
    }
    .reviews p{
    	border: none;
    	font-size: 20px;
        margin: 10px 0;
        padding-bottom: 5px;
    }
      .room-input p{
    	border: none;
        background: none;
    } 
     input[type="number"] {
            font-size: 14px; /* 폰트 크기 설정 */
            padding: 2px; /* 입력 필드 내 여백 설정 */
            width: 50px; /* 적절한 너비 설정 */
            box-sizing: border-box; /* 패딩과 테두리를 포함한 너비 설정 */
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
 <style>
    .star-rating {
      display: flex;
    }

    .star {
      appearance: none;
      padding: 1px;
    }

    .star::after {
      content: '☆';
      color: hsl(60, 80%, 45%);
      font-size: 20px;
    }

    .star:hover::after,
    .star:has(~ .star:hover)::after,
    .star:checked::after,
    .star:has(~ .star:checked)::after {
      content: '★';
    }

    .star:hover ~ .star::after {
      content: '☆';
    }
  </style>
</head>
<body>
<%@ include file="/header.jsp"%> <!-- 헤더에서 유저 정보를 가져올 수 있습니다. -->
    <main class="container">
        <div class="top">
            <h1>숙소 정보 수정</h1>
            <div class="room-details">
                <% if (room != null) { %>
                
                 <div class="room-images">
                	<div class="room-main">
                    	<img src="<%= room.getImage() %>" alt="메인 숙소 이미지">
                    </div>
               		<div >
                    	<img src="<%= room.getImage() %>" alt="서브 숙소 이미지 1">
                    	<img src="<%= room.getImage() %>" alt="서브 숙소 이미지 2">
                    	<img src="<%= room.getImage() %>" alt="서브 숙소 이미지 3">
                    </div>
                </div>
                <div class="room-input">
                	<h2>숙소 이름 : <input type="text" value=<%= room.getRoom_name()%> ></h2>
                	<p>숙소 편의시설 :<input type="text" value=<%= room.getGoodthing()%> ></p>
                	<p>숙소 지역 :<input type="text" value=<%= room.getAddr_detail()%> ></p>
                	<p>숙소 가격<input type="text" value=<%= room.getPrice()%> >  /  박</p>
                	<p>
						<label for="room_min">인원수:</label> 
						<input type="number" id="room_min" name="room_min" min="2" required
						placeholder="최소 인원수"> ~ 
						<input type="number" id="room_max" name="room_max" min="2" required
						placeholder="최대 인원수"> 명
					<p>
                </div>
       
                <h2>후기 관리</h2>
                <%
                ArrayList<RoomDTO> arr= rdao.Review_select(idx);
                if(arr==null||arr.size()==0){
                	%><h2>등록된 후기가 없습니다.</h2><%
                }else{
                	for(int i=0;i<arr.size();i++){
					%>
					<form name="deletefm action="#"></form>
						<div class="reviews">
							<p>작성자 :<label><%=arr.get(i).getMember_id() %></label></p>
							<p>별점 :<%=arr.get(i).getRate() %></p>
							<p>내용 :<label><%=arr.get(i).getContent() %></label></p>
						</div>
						<%
						}
                }
                %>
                
            </div>
        </div>
        <div>
          	<div>
                    <input type="hidden" name="room_idx" value="<%= room.getRoom_idx() %>">
                    <input type="hidden" name="checkin" value="<%= request.getParameter("checkin") %>">
                    <input type="hidden" name="checkout" value="<%= request.getParameter("checkout") %>">
                    <input type="hidden" name="guests" value="<%= request.getParameter("guests") %>">
                    <button type="submit" class="button">예약하기</button>
               
            </div>
            <% } else { %>
                <p>해당 숙소 정보를 찾을 수 없습니다.</p>
            <% } %>
        </div>
    </main>
    <%@ include file="/footer.jsp"%>
</body>
</html>
