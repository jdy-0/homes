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
		<input type="button" value="예약 보기" id="bt_complete" onclick="showDiv('contentWrapper');">
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
				
				<div class="contentWrapper" style="display:none">				
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
		<div class="contentWrapper" style="display:none">
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
		if(arr==null||arr.size()==0){
			%>
				<h3>등록된 숙소가 없습니다.</h3>
			<%
		}else{
			int a = arr.size();
			for(int i=0;i<arr.size();i++){
				ArrayList<RoomDTO> scarr = scdao.getScheduleByRoomidx(arr.get(i).getRoom_idx());
				if(scarr!=null&& scarr.size()!=0){
					
				
				%>
				<div class = "resByRoom" id="resByRoom<%=i%>">
				<h2 class = "roomName"><%=arr.get(i).getRoom_name() %>: <%=scarr.size() %>건 </h2> 
<%
				for(int j=0; j<scarr.size(); j++){
					
				
%>
				<div class="contentWrapper" style="display:none">				
						<article id= "main">
							<img src ="<%=scarr.get(j).getImage()%>">
						</article>
						<article id="maininfo">
							<h3><%=scarr.get(j).getRoom_name() %></h3>
				 				<ul>
									<li>시작날짜:<%=scarr.get(j).getStartday()%></li>
									<li>끝 날짜:<%=scarr.get(j).getEndday()%></li>
									<li>종류:<%=scarr.get(j).getReason()%></li>
								</ul>	
						</article>
					</div>
				<%} %>
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
        // 클릭된 roomName의 가장 가까운 resByRoom 요소를 찾습니다.
        const resbyroom = roomName.closest(".resByRoom");
        
        if (resbyroom) {
            // resByRoom 내의 모든 contentWrapper를 선택합니다.
            const contentWrappers = resbyroom.querySelectorAll(".contentWrapper");
            
            contentWrappers.forEach(function(contentWrapper) {
                // 현재 display 상태를 확인하고 토글합니다.
                if (contentWrapper.style.display === "none" || contentWrapper.style.display === "") {
                    contentWrapper.style.display = "flex";
                } else {
                    contentWrapper.style.display = "none";
                }
            });
        }
    });
});

function showDiv(divId){
	if('waiting' == divId){
		//대기버튼 눌렀을 때
		document.getElementById('booking').style.display="block";
		document.getElementById('planned').style.display="none";
		//완료버튼이 진해짐
		document.getElementById('bt_complete').style.backgroundColor="#cd280e";
		document.getElementById('bt_complete').style.color="cornsilk";
		document.getElementById('bt_complete').style.opacity="1";
		//대기버튼이 연해짐
		document.getElementById('bt_waiting').style.backgroundColor="cornsilk";
		document.getElementById('bt_waiting').style.color="#cd280e";
		document.getElementById('bt_waiting').style.opacity="0.7";
	}else{
		//완료버튼 눌렀을 때
		document.getElementById('waiting').style.display="none";
		document.getElementById('planned').style.display="block";
		//완료버튼이 연해짐
		document.getElementById('bt_complete').style.backgroundColor="cornsilk";
		document.getElementById('bt_complete').style.color="#cd280e";
		document.getElementById('bt_complete').style.opacity="0.7";
		//대기버튼이 진해짐
		document.getElementById('bt_waiting').style.backgroundColor="#cd280e";
		document.getElementById('bt_waiting').style.color="cornsilk";
		document.getElementById('bt_waiting').style.opacity="1";
	}

</script>
</html>