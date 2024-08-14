<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import="com.homes.room.RoomDTO" %>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>

<%
	String userid = (String)session.getAttribute("userid");
	int useridx=(Integer)session.getAttribute("useridx");
	int room_idx=Integer.parseInt(request.getParameter("room_idx"));
	String room_name="";
	ArrayList<RoomDTO> arr= (ArrayList<RoomDTO>)session.getAttribute("room_arr");
	
	String path=request.getRealPath("/");
	wf.setHomePath(path);
	
	if(arr!=null&&arr.size()!=0){
		for(int i=0;i<arr.size();i++){		
			if(room_idx==arr.get(i).getRoom_idx()){
			room_name=arr.get(i).getRoom_name();
			System.out.println(room_name);
		}
	}
	}else{
		%>
		<script>
			window.location.href='/homes/guest/login.jsp';
		</script>
		<%
	}
	
	
	
	wf.setCrpath(userid);
	String savepath=wf.getHomePath()+wf.getEverypath()+wf.getCrpath();
	System.out.println(savepath+"@#@#@#!!@!@!@");
	File f_id_rid= new File(savepath+"/"+room_name);
	if(!f_id_rid.exists()){
		f_id_rid.mkdir();
		%>
		<script>
			window.alert('<%=f_id_rid.getPath()%>에 숙소파일 생성 완료');
			window.self.close();
		</script>
		<%
	}else{
		%>
		<script>
			window.alert('<%=f_id_rid.getPath()%>숙소이름 파일 생성 안됌');
			window.self.close();
		</script>
		
		<%
	}
%>
			