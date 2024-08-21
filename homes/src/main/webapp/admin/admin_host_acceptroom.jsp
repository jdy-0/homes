<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/adminLayout.css">
<link rel="stylesheet" type="text/css" href="css/hostAcceptRoom.css">
<!-- <style>
.admin{
	display: flex;
    align-items: stretch;
    padding: 0;
    margin: 0;
    border-bottom: 5px solid black;
    width: 100%;
    height: auto;
    font-family: 'SBAggroB';
}
.title{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
}
.sidebar {
    width: 200px;
    background-color: #333;
    color: white;
    padding: 20px;
}
.sidebar a {
    color: white;
    text-decoration: none;
    display: block;
    margin: 10px 0;
}
.content {
    flex-grow: 1;
    padding: 20px;
}
.card {
    background-color: #f4f4f4;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 5px;
}
</style> -->
<%
	String room_idx_s=request.getParameter("param");
	int room_idx=Integer.parseInt(room_idx_s);
%>
</head>
<body>
<%@ include file="adminheader.jsp"%>
<section>
<article>
<fieldset class="title">
<h2>관리자페이지</h2>
</fieldset>
</article>
<article class="adminContent">
<%@include file="adminSideBar.jsp" %>
<fieldset class="fs_adminContent">
	
	<div class="content" style="display: flex;">
		<%
			RoomDTO room=adao.getRoom(room_idx);
		%>
		<fieldset id="insert_mainImg_fs">
			<div>
				<h2>대표 이미지</h2>
			</div>		
			<img id="selectedImage" src="<%=room.getImage() %>" alt="Selected Image"  onerror="this.src='/homes/img/no_image.jpg'" />		
		</fieldset>
		<fieldset id="insert_room_fs" style="border:0;">
			<h2>숙소 정보</h2>
			<table>
				<tr>
					<th>숙소이름</th>
					<td>
					<%=room.getRoom_name() %>
					</td>
				</tr>
				<tr>
					<th>인원수</th>
					<td>
					<%=room.getRoom_min() %>
					<%if(room.getRoom_min()!=room.getRoom_max()) {%>
						~<%=room.getRoom_max() %>
					
					<%}%> 명 
					
					</td>
				</tr>
				<tr>
					<th>지역</th>
					<td>
					<%
					if(adao.getRegion(room.getRegion_idx()).getLev()==2){
					%>
						<%=adao.getParentName(adao.getRegion(room.getRegion_idx()).getParent_idx()) %>
					<%
					}
					%>
					<%=adao.getRegion(room.getRegion_idx()).getRegion_name() %>
					</td>
				</tr>
				<tr>
					<th>상세주소</th>
					<td>
					<%=room.getAddr_detail() %>
					</td>
				</tr>
				<tr>
					<th>편의시설</th>
					<td>
					<%=room.getGoodthing() %>
					</td>
				</tr>
				<tr>
					<th>가격</th>
					<td>
					<%=room.getPrice() %> 원
					</td>
				</tr>
			</table>
			</fieldset>
		<div style="display: flex; align-items: flex-end;">
			<input type="button" value="뒤로" class="button" onClick="location.href='admin_host_accept.jsp'">
		</div>
	</div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>