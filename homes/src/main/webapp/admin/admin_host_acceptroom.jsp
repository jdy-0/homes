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

<style>
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
</style>
<!-- hostinsert.jsp css -->
<style>
#selectedImage{
	width:400px;
	height:300px;
	display:block;
	margin-bottom:10px;
}
#insert_mainImg_fs{
	border:0; 
	border-right:3px dashed black; 
	padding:20px;
}

#insert_mainImg_fs img{
	margin:10px auto;
}
#insert_room_fs{
	border:0; 
	padding:20px;
}
#insert_room_fs table{
	margin:15px auto;
	width:500px;
	font-size:20px;
}
#insert_room_fs table th{width:100px;}
#insert_room_fs table select{
	border:3px solid black;
	font-family: 'SBAggroB';
	padding:5px;
	font-size:18px;
}
.text{
	border:3px solid black;
	padding:5px;
	font-family: 'SBAggroB';
	font-size:18px;
}
.button{
	font-family: 'SBAggroB';
	font-size:20px;
	padding:5px;
	background-color:#dec022;
	border:4px solid black;
	margin:15px;
}
.button:hover{background-color:#e2dccc; transition:0.5s;}
</style>
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
<article>
<fieldset class="admin">
	<div class="sidebar">
	    <h2>관리자 메뉴</h2>
	    <nav>
	      	<ul id="ul_menu">
			    <li><a href="/homes/admin/admin.jsp">대시보드</a></li>
			    <li><a href="#">회원 관리</a></li>
			    <li><a href="#">호스트 관리</a></li>
			    <li>
			    	지역 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_region.jsp">지역 목록</a></li>
			    		<li><a href="/homes/admin/admin_regiondetail_list.jsp">지역 이미지 목록</a></li>
			    	</ul>
			    </li>		
			    <li><a href="#">후기 관리</a></li>
			    <li>
			    	숙소 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_host_accept.jsp">숙소 승인</a></li>
			    	</ul>
			    </li>	    
			    <li>
			    	예약 관리
			    	<ul>
			    		<li><a href="/homes/admin/admin_refund_accept.jsp">환불 승인</a></li>
			    	</ul>
			    </li>
		    </ul>
	    </nav>
	    
	</div>

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