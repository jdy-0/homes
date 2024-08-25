<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.homes.room.RoomDTO"%>
<%@page import="com.homes.db.HomesDB"%>
<%@page import="java.util.Date" %>
<jsp:useBean id="homedto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="homedao" class="com.homes.room.RoomDAO"></jsp:useBean>
<jsp:useBean id="scdao" class="com.homes.schedule.ScheduleDAO"></jsp:useBean>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
</head>
<%
int roomidx = Integer.parseInt(String.valueOf(session.getAttribute("useridx")));
ArrayList<RoomDTO> arr = (ArrayList<RoomDTO>) session.getAttribute("room_arr");

%>
<body>
<%@ include file="/header.jsp" %>
<section>
<%@include file="hostheader.jsp" %>
<div style="width: 100%; margin:10px auto; display:block;">
<%
		if(arr==null||arr.size()==0){
			%>
				<h3>등록된 숙소가 없습니다.</h3>
			<%
		}else{
				
			int a = arr.size();
			for(int i=0;i<arr.size();i++){
				ArrayList<RoomDTO> scarr = scdao.getScheduleByRoomidx(arr.get(i).getRoom_idx());
				
				%>
				<div class = "resByRoom" id="resByRoom<%=i%>" style="display:block; ">
				<h2 class = "roomName"><%=arr.get(i).getRoom_name() %>: <%=scarr.size() %>건 </h2> 
				
				<%
				if(scarr!=null&& scarr.size()!=0){
					
				
				%>
				
				<div>
				
<%
				for(int j=0; j<scarr.size(); j++){
					
				
%>
				<div class="contentWrapper" style="display:none; align-items: center;">				
						<article id= "main">
<%-- 							<img src ="<%=scarr.get(j).getImage()%>"> --%>
							<ul>
									<li>시작날짜:<%=scarr.get(j).getStartday()%></li>
									<li>끝 날짜:<%=scarr.get(j).getEndday()%></li>
									<li>종류:<%=scarr.get(j).getReason()%></li>
							</ul>	
						</article>
						<article id="maininfo">
							<jsp:include page="host_manage_cal.jsp">
			                    <jsp:param name="room" value="<%= arr.get(i).getRoom_idx() %>" />
			                    <jsp:param name="start" value="<%=scarr.get(j).getStartday()%>" />
			                    <jsp:param name="end" value="<%=scarr.get(j).getEndday()%>" />
			                    <jsp:param name="reason" value="<%=scarr.get(j).getReason()%>" />
			                    
			                    
			                </jsp:include>
						</article>
					</div>
				<%} %>
				</div>
				
				<%
			} 
				
				%>
								</div>
				
				<%
			}
	}
	%>
</div>
</section>
</body>
<script type="text/javascript">

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
                    contentWrapper.style.justifyContent = "space-around";

                    contentWrapper.style.display = "flex";

                } else {
                    contentWrapper.style.display = "none";
                }
            });
        }
    });
});	
</script>
</html>