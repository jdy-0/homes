<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdto" class="com.homes.room.RoomDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="rdto" />

<%
	String room_idx=(String)session.getAttribute("room_idx");
	int count=rdao.Room_update(rdto);
	
	if(count>=1){
		
		%>
		<script>
		window.alert('수정완료');
		window.location.href='/homes/host/host_update.jsp?room_idx=<%=room_idx%>';
		</script>
		<%
	}else{
		%>
		<script>
		window.alert('수정실패');
		window.location.href='/homes/host/host_update.jsp?room_idx=<%=room_idx%>';
		</script>
		<%
	}
%>
