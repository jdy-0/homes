<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>

<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%
//String room_idx=(String)request.getParameter("room_idx");
//String room_path=(String)request.getParameter("room_path");
wf.setHomePath(request.getRealPath("/"));
String savepath=wf.getHomePath()+wf.getImgpath();

MultipartRequest mr= 
new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");

String room_idx=(String)session.getAttribute("room_idx");
String room_path=(String)mr.getParameter("room_path");//비교할 경로
String room_name=(String)mr.getParameter("room_name");//가져온 room의 이름(이미지 이름으로 사용할것)

Enumeration<String> room_Imgname=mr.getFileNames();

String paramName=room_Imgname.nextElement();//넘어온 파일의 이름(update재료)

String room_imgname = mr.getOriginalFileName(paramName);

String setPath= wf.getImgFile()+room_imgname;

System.out.println("///////////////////////////");
System.out.println(setPath+"  set할 경로");
System.out.println(room_idx+"  룸의 idx");
System.out.println(room_path+"  등록할 room_경로");

int count = rdao.RoomMainImg_update(setPath,room_idx);

if(count>=1){
	%>
		<script>
			window.alert('숙소 대표화면 변경 성공');
			window.location.href='/homes/host/host_update.jsp?room_idx=<%=room_idx%>';
		</script>
	<%
}else{
	%>
	<script>
		window.alert('변경실패');
		window.location.href='/homes/host/host_update.jsp?room_idx=<%=room_idx%>';
	</script>
<%
	
}
 %>