<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%@page import="com.oreilly.servlet.*"%>
    
<!-- 대표 사진업로드 -->
<%
	String savepath=wf.getHomePath()+wf.getImgpath();
	MultipartRequest mr= new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");//
	
%>
<script>
	window.alert('<%=request%>파일 올리기 성공!'');
	opener.window.location.reload();
	window.self.close();
</script>