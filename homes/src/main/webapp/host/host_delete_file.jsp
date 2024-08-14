<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%
String img_name = (String)request.getParameter("img_name");
String room_name = (String)request.getParameter("room_name");
String user_name = (String)request.getParameter("user_name");

String roomidx= (String)session.getAttribute("room_idx");
wf.checkFile(user_name,room_name,img_name);

%>

<script>
	location.href='webFolder.jsp?cr=<%=wf.getCrpath()%>';
	location.href='host_update.jsp?room_idx=<%=roomidx%>';
</script>