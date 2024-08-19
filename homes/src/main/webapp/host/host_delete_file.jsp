<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>

<%
//실제 경로에서 이미지 삭제 로직(웹폴더)
String img_name = (String)request.getParameter("img_name");
String room_name = (String)request.getParameter("room_name");
String user_name = (String)request.getParameter("user_name");
String room_path= (String)request.getParameter("room_path");

String roomidx= (String)session.getAttribute("room_idx");


String Room_Path_SqlSet= room_path+"/"+img_name;

wf.checkFile(user_name,room_name,img_name);

%>

<%
//sql문 삭제 로직
int count=rdao.RoomDetailImg_delete(Room_Path_SqlSet);
if(count>=1){
	%>
<script>
	
	location.href='host_update.jsp?room_idx=<%=roomidx%>';
</script>
<%
}else{
	%>
<script>
	window.alert('<%=Room_Path_SqlSet%>삭제 실패');
	location.href='host_update.jsp?room_idx=<%=roomidx%>';
</script>
<%
}
%>