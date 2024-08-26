<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.homes.db.HomesDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="homedto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="homedao" class="com.homes.room.RoomDAO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
</head>
<body>
<%@ include file="/header.jsp"%>

<section>
<%@include file="hostheader.jsp" %>
<%	
Integer useridx=0 ;
useridx = session.getAttribute("useridx")==null || session.getAttribute("useridx").equals("")?0:(Integer)session.getAttribute("useridx");
if (useridx == null || useridx == 0) {

%>
    <script>
    window.location.href = '/homes/guest/login.jsp';
    </script>
<%
return;
}

ArrayList<RoomDTO> arr= homedao.HomesList(useridx);

if(useridx!=0||useridx!=null){
	
	ArrayList<RoomDTO> room_arr=homedao.RoomInfo(useridx);
	session.setAttribute("room_arr", room_arr);
}
%>
<article id="host_main_article">
		<%
		if(arr==null||arr.size()==0){
			%>
				<div id="no_room_div">
				<h3>등록된 숙소가 없습니다. 등록하시겠습니까?</h3>
				<form name="insertfm" action="hostinsert.jsp"> 
				<input type="submit" value="숙소 등록하기" class="btstyle">				
				</form>
				</div>
			<%
		}else{
			int a = arr.size();
			for(int i=0;i<arr.size();i++){
				
				%>
				
			<form name="updatefm" action="host_update_image_ok.jsp?room_idx<%=arr.get(i).getRoom_idx()%>"> 
			<div class="container">
				<div>
					<img class="selectedImage" src ="<%=arr.get(i).getImage()%>" alt="Selected Image"  onerror="this.src='/homes/img/no_image.jpg'" />
				</div>
				<div id="roomselect">
					<h2><%=arr.get(i).getRoom_name() %></h2>
					<ul>
						<li><label>지역:</label> 
						
						<label><%=arr.get(i).getParentRegionName()+" "+arr.get(i).getSelectedRegionName()%></label>
						<li>
							<label for="room_goodthing">편의 시설 : </label> 
							<label><%=arr.get(i).getGoodthing()%></label>
						</li>
						<li>
							<label for="room_addr">상세 주소:</label> 
							<label><%=arr.get(i).getAddr_detail()%></label>
						</li>
						<li>
							<label for="price">가격:</label> 
							<label><%=arr.get(i).getPrice()%> / 박</label>
						</li>
						
						
						<!-- <li>
							<label for="map_url">맵 url :</label> 
							<label>맵 쓰기</label>
						</li> -->
						<li>
							<input type="hidden" value=<%=arr.get(i).getRoom_idx() %> name="room_idx">
						<li>
						
					</ul>
				</div>
				<!-- <div>
					<h2>사진 등록</h2>
					<hr>
					<input type="file" multiple="multiple" accept="image/*" name='subpicture'>
				</div> -->
				<div>
					<input type="submit" value="수정" class="btstyle">
				</div>
			</div>
			</form>
			<%
			}
		}
		%>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>