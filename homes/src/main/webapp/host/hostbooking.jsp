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
	for(RoomDTO rdto : roomArr){

		ArrayList<ReservationDTO> resArr =  resdao.getReserveLists(rdto.getRoom_idx());
%>
		<div class = "resByRoom">
		<h2 class = "roomName"><%=rdto.getRoom_name() %></h2> 
<%					
		if(resArr!=null && resArr.size()>0){

			for(ReservationDTO resdto : resArr){
				%>	
				<div class="contentWrapper" style="display:none">
					<article class="booking">
			            <ul>
			            	<li>신청자 : <%=resdto.getMember_id() %></li>
			                <li>총 인원 : <%=resdto.getCount() %></li>
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
			</div>
<%
		} else {
%>		
		<div class="contentWrapper" style="display:none">
			<h2>없음</h2>
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
</section>
</body>

<script>

const roomNames = document.querySelectorAll(".resByRoom > .roomName");
let check = true;

roomNames.forEach(function(roomName) {
    roomName.addEventListener("click", function() {
        const parent = roomName.parentElement;
        const contentWrappers = parent.querySelectorAll(".contentWrapper");
        
        if(contentWrappers.length > 0){  // contentWrappers가 비어있지 않은지 확인
            contentWrappers.forEach(function(contentWrapper) {
                // check가 true일 때만 display 속성을 block으로 설정하고, check를 false로 변경
                if(check){
                    contentWrapper.style.display = "block";
                } else {
                    contentWrapper.style.display = "none";
                }
            });
            // check 변수 토글
            check = !check;
        }
    });
});
	
</script>
</html>
