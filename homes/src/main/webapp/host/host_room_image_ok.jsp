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

Enumeration<String> test = mr.getFileNames();

while(test.hasMoreElements()){
	String tt = test.nextElement();
	System.out.println(tt+"ttttt");
}


// 각 파라미터 이름을 순회합니다.
while (paramNames.hasMoreElements()) {
    String paramName = paramNames.nextElement();
    System.out.println("Processing parameter: " + paramName);
    System.out.println(mr.getOriginalFileName("images_file"));
	
    // 해당 파라미터 이름으로 파일 객체를 가져옵니다.
    File file = mr.getFile(paramName);

    // 파일을 처리합니다.
    if (file != null) {
        String fileName = file.getName();
        if (fileName != null && !fileName.isEmpty()) {
            String Room_Path_SqlSet = Room_Path_Sql + "/" + fileName;
            rdao.RoomDetailImg_insert(room_idx, Room_Path_SqlSet);
            System.out.println("File name: " + fileName);
        } else {
            System.out.println("File name is empty.");
        }
    } else {
        System.out.println("No file found for parameter: " + paramName);
    }
}
%>

<script>

window.location.href='/homes/host/hostupdate.jsp?room_idx=<%=room_idx%>';
</script>