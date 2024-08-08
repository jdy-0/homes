<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%
	String folder = request.getParameter("Folder");
	File f= new File(wf.getHomePath()+wf.getEverypath()+wf.getCrpath());
	String path=f.getPath();
	File f0= new File(wf.getHomePath()+wf.getHostpath());
	
	if(!f.exists()){
		f0.mkdir();
	%>
	<script>
	window.alert('이 문구는 img파일안에 host_img폴더가 없을떄 실행됩니다.');
		window.alert('<%=folder%>파일 생성 완료');
		window.alert('<%="내가 접속하는 경로 :"+f0.getPath()%>파일 생성 완료');
		window.self.close();
	</script>
<%
}else{%>
	<script>
	window.alert("파일생성안됌");
	</script>
	<%
}
	
	if(!f.exists()){
		f.mkdir();
	%>
	<script>
	window.alert('이 문구는 host_img안에 id파일이 없을때 실행됩니다.');
		window.alert('<%=folder%>파일 생성 완료');
		window.alert('<%="homepath :"+wf.getHomePath()%>파일 생성 완료');
		window.alert('<%="내가 접속하는 경로 :"+wf.getHomePath()+wf.getEverypath()+wf.getCrpath()%>파일 생성 완료');
		
		window.self.close();
	</script>
<%
}else{%>
<script>
window.alert("파일생성안됌");
</script>
<%
}%>