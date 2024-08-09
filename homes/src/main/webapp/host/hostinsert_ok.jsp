<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.oreilly.servlet.*"%>
    
<%
   request.setCharacterEncoding("UTF-8");
%>

<%@page import="java.io.*"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdto" class="com.homes.room.RoomDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>
<%
	String folder = request.getParameter("Folder");
	File f= new File(wf.getHomePath()+wf.getEverypath()+wf.getCrpath());
	String path=f.getPath();
	File f0= new File(wf.getHomePath()+wf.getHostpath());
	String name= request.getParameter("room_name");
	
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
			window.alert('<%=name%>@@@@@@@@@@@@@');
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
		
		//window.self.close();
	</script>
<%
}else{%>
<script>
window.alert("파일생성안됌");
</script>
<%
}%>

<!-- room insert 부분 ---------------------- -->

<%
	int result = rdao.insertRoom2(rdto);
	String msg = result > 0 ? "숙소등록 요청성공" : "숙소등록 요청실패";
%>

<script>
window.alert("<%=msg%>");
</script>


<!-- 대표 사진업로드 -->
<%
	String savepath=wf.getHomePath()+wf.getImgpath();

	MultipartRequest mr= new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");//
    Enumeration<String> fileNames = mr.getFileNames();
	
	System.out.println(fileNames.nextElement());

	
%>
<script>
	window.alert('<%=savepath%>파일 올리기 성공!');
	window.location.href='/homes/host/hostmain.jsp';
</script>

