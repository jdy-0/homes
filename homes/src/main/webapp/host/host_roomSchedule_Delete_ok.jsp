<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="scdao" class="com.homes.host.ScheduleDAO"></jsp:useBean>
<jsp:useBean id="rfdao" class="com.homes.refund.refundDAO"></jsp:useBean>
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
int type = 0;
String s_type = request.getParameter("type");
if(s_type!=null && !s_type.equals("")){
	type = Integer.parseInt(s_type);
}
int count = -1;
if(type==1){
	count = scdao.delSelectedRange(date, room);
} else if(type==2){
	int reserve_idx = scdao.checkDelSelectedRes(date, room);
	if(reserve_idx>0){
		count = rfdao.commitedResToCancle(reserve_idx);
	}
}

if(count>0){
%>
<script>
	alert('선택한 예약 및 휴무가 삭제되었습니다.');
</script>
<%	
} else{
%>
<script>
	alert('선택한 예약 및 휴무의 삭제에 실패하였습니다.');
</script>
<%
}

%>
<script>
 window.location.href='host_roomSchedule.jsp';
 </script>
    