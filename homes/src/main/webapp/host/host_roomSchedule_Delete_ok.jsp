<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="scdao" class="com.homes.host.ScheduleDAO"></jsp:useBean>
<%
String s_room = request.getParameter("room");
String s_date = request.getParameter("date");
int room = 0;
if(s_room!=null && !s_room.equals("")){
	room = Integer.parseInt(s_room);
}
long date=0;
if(s_date!=null && !s_date.equals("")){
	date = Long.parseLong(s_date);
}

int count = scdao.delSelectedRange(date, room);

if(count>0){
%>
<script>
	alert('삭제 완료');
</script>
<%	
} else{
%>
<script>
	alert('삭제 실패');
</script>
<%
}

%>
<script>
 window.location.href='host_roomSchedule.jsp';
 </script>
    