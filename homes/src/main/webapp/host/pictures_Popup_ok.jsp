<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%
String name = (String)session.getAttribute("userid");
String savepath=wf.getHomePath()+wf.getEverypath()+name;
MultipartRequest mr= new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");//

%>
<script>
window.alert('파일 올리기 성공!');
opener.window.location.reload();
window.self.close();
</script>

