<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>

<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="com.oreilly.servlet.*"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>

<%
/* String homePath= request.getRealPath("/");
wf.setHomePath(homePath);
 */

String savepath=(String)session.getAttribute("room_path_img")+"/";
 

 
//String savepath=request.getParameter("room_path");
MultipartRequest mr= 
new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");
String Room_Path_Sql=mr.getParameter("room_path");
String room_idx=(String)session.getAttribute("room_idx");


Enumeration<String> paramNames = mr.getFileNames();



while (paramNames.hasMoreElements()) {
    String paramName = paramNames.nextElement();
   
     File file = mr.getFile(paramName);
	
    // 파일을 처리합니다.
    if (file != null) {
        String fileName = file.getName();
       
        String Room_Path_SqlSet = Room_Path_Sql + "/" + fileName;
         rdao.RoomDetailImg_insert(room_idx, Room_Path_SqlSet);
    } else {
    	%>
		<script>
			//window.alert('가져올 파일 null');
		</script>
		<%
    }
} 

%>

<script>

window.location.href='/homes/host/host_update.jsp?room_idx=<%=room_idx%>';
</script>