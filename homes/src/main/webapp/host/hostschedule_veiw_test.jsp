<%@page import="com.homes.guest.ReservationDTO"%>
<%@page import="com.homes.guest.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.Reservation_detailDTO" %>
<%@ page import="com.homes.room.RoomDTO" %>
<jsp:useBean id="roomdao" class="com.homes.room.RoomDAO"></jsp:useBean>
<jsp:useBean id="homedto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="resdao" class="com.homes.guest.ReservationDAO"></jsp:useBean>
<jsp:useBean id="scdao" class="com.homes.schedule.ScheduleDAO"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
<style>
#bt_complete{
	background-color:cornsilk;
	color:#cd280e;
	padding:10px;
	border-radius:10px;
	border:2px solid #cd280e;
	width:150px;
	opacity:0.7;
	font-family: 'SBAggroB';
	font-size:20px;
	margin:10px;
}
#bt_complete:hover{
	opacity:0.5;
}
#bt_waiting{
	background-color:#cd280e;
	color:cornsilk;
	padding:10px;
	border-radius:10px;
	border:2px solid #cd280e;
	width:150px;
	font-family: 'SBAggroB';
	font-size:20px;
	margin:10px;
}
#bt_waiting:hover{
	opacity:0.5;
}

</style>
</head>

<body>
<%@ include file="../header.jsp" %>
<%@ include file="hostheader.jsp" %>

<section>
<%
Object o_useridx = session.getAttribute("useridx");
int useridx = (Integer) o_useridx;

ArrayList<RoomDTO> roomArr= roomdao.HomesList(useridx);
ArrayList<RoomDTO> arr = (ArrayList<RoomDTO>) session.getAttribute("room_arr");
if(roomArr==null && roomArr.size()<=0){
%>
<h3>등록된 숙소가 없습니다.</h3>
<%
} else {
	%>
	<div style="text-align:center;">
		<input type="button" value="예약 보기" id="bt_complete" onclick="showDiv('resByRoom');">
		<input type="button" value="휴무 보기" id="bt_waiting" onclick="showDiv('waiting');">
	</div>
	<%
	int count = 0;
	
	for(RoomDTO rdto : roomArr){
		
		ArrayList<ReservationDTO> resArr =  resdao.getReserveLists(rdto.getRoom_idx());
        boolean hasReservations = (resArr != null && resArr.size() > 0);

%>		
		<div class = "resByRoom" id="resByRoom<%=count++%>">
		<!-- 예약 있을 시, 글씨색 변경 -->
			<h2 class = "roomName" style="<%= hasReservations ? "color: red;" : "" %>"><%=rdto.getRoom_name() %>: <%=resArr.size() %>개 </h2> 
		
<%					
		if(resArr!=null && resArr.size()>0){
			for(ReservationDTO resdto : resArr){
				%>	
				
				<div class="resByRoom" style="display:none">				
					<article class="booking">
						<table class="bookingTable">
							<tr>
								<th>예약번호</th>
								<td><%=resdto.getReserve_idx() %></td>
							</tr>
							<tr>
								<th>신청자</th>
								<td><%=resdto.getMember_id() %></td>
							</tr>
							<tr>
								<th>총 인원</th>
								<td><%=resdto.getCount() %></td>
							</tr>
							<tr>
								<th>체크인</th>
								<td><%=resdto.getCheck_in() %></td>
							</tr>
							<tr>
								<th>체크아웃</th>
								<td><%=resdto.getCheck_out() %></td>
							</tr>
							<tr>
								<th>가격</th>
								<td><%=resdto.getPrice() %></td>
							</tr>
							<tr>
								<th>요청 사항</th>
								<td><%= resdto.getRequest() != null ? resdto.getRequest() : "" %></td>
							</tr>
						</table>
			            
			        </article>
					 
			        <article class="calendarart">
			        <%
			        
			        request.setAttribute("resdto",resdto);
			        %>
			        
			        <jsp:include page="host_booking_cal.jsp"/>
			        </article>
			    </div>
			    				
				<%
			}
%>
<%
		} else {
%>		
		<div class="resByRoom" style="display:none">
			<h2>없음</h2>
		</div>
<%
		}
		%>
		 </div>
		
		
		<%
	}
}
%>	
<%
if (arr == null || arr.size() == 0) {
%>
    <div class="manageByRoom" id="manageByRoom0" style="display:none">
        <h2>등록된 숙소가 없습니다.</h2>
    </div>
<%
} else {
    for (int i = 0; i < arr.size(); i++) {
        ArrayList<RoomDTO> scarr = scdao.getScheduleByRoomidx(arr.get(i).getRoom_idx());
        if (scarr != null && scarr.size() != 0) {
%>
            <div class="manageByRoom" id="manageByRoom<%=i%>" style="display:none">
                <h2 class="roomName"><%= arr.get(i).getRoom_name() %>: <%= scarr.size() %>건</h2>
<%
            for (int j = 0; j < scarr.size(); j++) {
%>
                <div class="manage" style="display: flex;" >
               
                    <article id="main">
                        <img src="<%= scarr.get(j).getImage() %>">
                    </article>
                    
                    <article class="booking">
                        <table class="bookingTable">
                            <tr>
                                <th>시작 날짜:</th>
                                <td><%= scarr.get(j).getStartday() %></td>
                            </tr>
                            <tr>
                                <th>신청자</th>
                                <td>끝 날짜: <%= scarr.get(j).getEndday() %></td>
                            </tr>
                            <tr>
                                <th>총 인원</th>
                                <td>종류: <%= scarr.get(j).getReason() %></td>
                            </tr>
                        </table>
                    </article>
                    
                </div>
                
<%
            } 
%>
           </div>
<%
        }
    } 
} 
%>

</section>
</body>

<script>
const roomNames = document.querySelectorAll(".roomName");

roomNames.forEach(function(roomName) {
    roomName.addEventListener("click", function() {
        const resbyroom = roomName.closest(".resByRoom");
        const manageByRoom = roomName.closest(".manageByRoom");

        if (resbyroom) {
            const resByRooms = resbyroom.querySelectorAll(".resByRoom");
            resByRooms.forEach(function(resByRoom) {
                if (resByRoom.style.display === "none" || resByRoom.style.display === "") {
                    resByRoom.style.display = "flex";
                } else {
                    resByRoom.style.display = "none";
                }
            });
        }

        if (manageByRoom) {
            const manageSections = manageByRoom.querySelectorAll(".manage");
            manageSections.forEach(function(manage) {
                if (manage.style.display === "none" || manage.style.display === "") {
                    manage.style.display = "flex";
                } else {
                    manage.style.display = "none";
                }
            });
        }
    });
});

function showDiv(divId){
    if ('waiting' === divId) {
        // 대기 버튼 눌렀을 때
        document.querySelectorAll('.resByRoom').forEach(function(div) {
            div.style.display = "none";
        });
        document.querySelectorAll('.manageByRoom').forEach(function(div) {
            div.style.display = "block";
        });

        // 완료 버튼이 연해짐
        document.getElementById('bt_complete').style.backgroundColor = "cornsilk";
        document.getElementById('bt_complete').style.color = "#cd280e";
        document.getElementById('bt_complete').style.opacity = "0.7";
        
        // 대기 버튼이 진해짐
        document.getElementById('bt_waiting').style.backgroundColor = "#cd280e";
        document.getElementById('bt_waiting').style.color = "cornsilk";
        document.getElementById('bt_waiting').style.opacity = "1";
    } else {
        // 완료 버튼 눌렀을 때
        document.querySelectorAll('.resByRoom').forEach(function(div) {
            div.style.display = "block";
        });
        document.querySelectorAll('.manageByRoom').forEach(function(div) {
            div.style.display = "none";
        });

        // 완료 버튼이 진해짐
        document.getElementById('bt_complete').style.backgroundColor = "#cd280e";
        document.getElementById('bt_complete').style.color = "cornsilk";
        document.getElementById('bt_complete').style.opacity = "1";
        
        // 대기 버튼이 연해짐
        document.getElementById('bt_waiting').style.backgroundColor = "cornsilk";
        document.getElementById('bt_waiting').style.color = "#cd280e";
        document.getElementById('bt_waiting').style.opacity = "0.7";
    }
}

</script>
</html>