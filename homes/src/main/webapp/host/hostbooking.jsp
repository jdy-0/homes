<%@page import="com.homes.guest.ReservationDTO"%>
<%@page import="com.homes.guest.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.Reservation_detailDTO" %>
<%@ page import="com.homes.room.RoomDTO" %>
<jsp:useBean id="roomdao" class="com.homes.room.RoomDAO"></jsp:useBean>
<jsp:useBean id="resdao" class="com.homes.guest.ReservationDAO"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">

</head>
<body>
<%@ include file="../header.jsp" %>
<%@ include file="hostheader.jsp" %>

<section>
<%
Object o_useridx = session.getAttribute("useridx");
int useridx = (Integer) o_useridx;
ArrayList<RoomDTO> roomArr= roomdao.HomesList(useridx);

if(roomArr==null && roomArr.size()<=0){
%>
<h3>등록된 숙소가 없습니다.</h3>
<%
} else {
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
						<table>
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
		
		<hr>
		<%

	}
}
%>	

    
	
    <div id="hr">
        <!-- hr 요소를 추가하려면 아래에 넣으세요 -->
    </div>
    <hr>
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
                    contentWrapper.style.display = "block";
                } else {
                    contentWrapper.style.display = "none";
                }
            });
        }
    });
});
	
</script>
</html>
