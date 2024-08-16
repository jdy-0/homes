<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
    
<%request.setCharacterEncoding("UTF-8");%>

<%@page import="java.io.*"%>
<%@page import="java.nio.file.*"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.room.RoomDAO" scope="session"></jsp:useBean>
<jsp:useBean id="rdto" class="com.homes.room.RoomDTO" scope="session"></jsp:useBean>
<jsp:setProperty property="*" name="rdto"/>

<%
	String savepath=wf.getHomePath()+wf.getImgpath();
	MultipartRequest mr= new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");
	
	String roompath= mr.getParameter("room_name");
	roompath.replaceAll(" ", "");
	System.out.println(roompath+"!@#!@#");
	String folder = request.getParameter("Folder");
	File f= new File(wf.getHomePath()+wf.getEverypath()+wf.getCrpath());
	String path=f.getPath();
	File f0= new File(wf.getHomePath()+wf.getHostpath());
	
	//File f2= new File(wf.getHomePath()+wf.getEverypath()+wf.getCrpath()+"/"+roompath);
	
	//File imgFile= new File(wf.getHomePath()+wf.getImgpath());
	
	if(!f0.exists()){
		f0.mkdir();
	%>
	<script>
		window.alert('<%=folder%>에 host_img파일 생성 완료');
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
		window.alert('<%=folder%>파일 생성 완료');
		
		window.alert('<%="내가 접속하는 경로 :"+wf.getHomePath()+wf.getEverypath()+wf.getCrpath()%>파일 생성 완료');
		
		//window.self.close();
	</script>
<%
}else{
%>
<script>
window.alert("파일생성안됌");
</script>

<%
}
%>

<%-- <%
			if(!f.exists()){
				f2.mkdir();
				System.out.println(f2.getPath()+"@#@#@#@#");
			}else{
				%>
				<script>
				window.alert('<%=f2.getPath() %>+@@@@@@@@@');
				</script>
				<%
			}
%> --%>

<!-- 대표 사진업로드 -->
<!-- room insert 부분 ---------------------- -->

<%
	//
	
	//insert 문
	String roomName = mr.getParameter("room_name");
	roomName.replaceAll(" ", "");
	int roomMin = Integer.parseInt(mr.getParameter("room_min"));
	int roomMax = Integer.parseInt(mr.getParameter("room_max"));
	int regionIdx = Integer.parseInt(mr.getParameter("region_idx"));
	String goodthing = mr.getParameter("goodthing");
	String addrDetail = mr.getParameter("addr_detail");
	int price = Integer.parseInt(mr.getParameter("price"));
	String mapUrl = mr.getParameter("map_url");
	int hostIdx = Integer.parseInt(mr.getParameter("host_idx"));
	String img = wf.getImgFile()+roomName+".jpg";
	//
	
	int result = rdao.insertRoom2(hostIdx,regionIdx,roomName,goodthing,addrDetail,price,mapUrl,img,roomMin,roomMax);
	String msg = result > 0 ? "숙소등록 요청성공" : "숙소등록 요청실패";
	
	//보내는 input file의 이름
	String getmainName = mr.getOriginalFileName("mainPiceture");
	//String setmainName = roomName;
	
	
	File oldFile = new File(savepath+getmainName);
	File newFile = new File(savepath+roomName+".jpg");
	
	if(oldFile.renameTo(newFile)){
		%>
		 
		<script>
		window.alert('파일 이름 변경 완료');
		</script>
		<%
	}else{
		%>
		<script>
		window.alert('파일 이름 변경 실패');
		</script>
		<%
	}
	%>
	

<script>
window.alert("<%=msg%>");
</script>
<script>
	window.alert('<%=savepath%>파일 올리기 성공!');
	window.location.href='/homes/host/hostinsert.jsp';
</script>

