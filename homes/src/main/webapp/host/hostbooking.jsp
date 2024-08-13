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
<style>
.contentWrapper ul{
	width:200px;
	height: 100px;
}

.contentWrapper {
    display: flex;
    align-items: flex-start; /* 상단 정렬 */
    margin-bottom: 20px; /* 아래쪽 여백 추가 */
}
.contenWrapper article{
   
   flex: 1; /* 모든 article이 동일한 비율로 차지하도록 설정 */
    margin-right: 20px; /* 각 article 사이의 간격 */
    height: 200px; /* 고정 높이 설정 */
    box-sizing: border-box; /* 패딩과 테두리가 요소의 전체 너비에 포함되도록 설정 */
}


</style>
</head>
<body>
<%@ include file="/header.jsp" %>
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
	for(RoomDTO rdto : roomArr){
		ArrayList<ReservationDTO> resArr =  resdao.getReserveLists(rdto.getRoom_idx());
		for(ReservationDTO resdto : resArr){
			%>	
			<div class="contentWrapper">
				<article class="booking">
		            <h2><%=rdto.getRoom_name() %></h2><!--db숙소 제목 -->
		            <ul>
		            	<li>신청자 : <%=resdto.getMember_idx() %></li>
		                <li>기준 인원 : 0명 not db</li>
		                <li>요청 사항 :
		                    <label><%= resdto.getRequest() %>
		                       	
		                    </label>
		                </li>
		            </ul>
		        </article>
				 
		        <article class="calendarart">
		        <%
		        
		        request.setAttribute("resdto",resdto);
		        %>
		        
		        <jsp:include page="host_booking_cal.jsp"/>
		        </article>
		         <article class="buttonart">
		        </article>
    	</div>
			<%
		}
		
		%>
		<hr>
		<%

	}
}
%>	

    
	
    <div id="hr">
        <!-- hr 요소를 추가하려면 아래에 넣으세요 -->
    </div>
    <hr>
    <h2>----------db연동 후 for문으로 쏴줘야 할듯----------------------------------</h2>
</section>
</body>
</html>
