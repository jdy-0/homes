<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.homes.db.HomesDB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<jsp:useBean id="homedto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="homedao" class="com.homes.room.RoomDAO"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
</head>

<body>
<%@ include file="/header.jsp"%>
<%
	userid=(String)session.getAttribute("userid"); 
	ArrayList<RoomDTO> arr= homedao.HomesList(userid);
	
	if(userid==null||userid.isEmpty()){
		%><script>
		window.open('/homes/guest/login_popup.jsp', 'popup', 'width=400,height=300,top=100,left=100');
		</script>
		<%
		return;
		}
%>
<%@include file="hostheader.jsp" %>
<section>
		<%
		if(arr==null||arr.size()==0){
			%>
				<h3>등록된 숙소가 없습니다. 등록하시겠습니까?</h3>
				<form name="insertfm" action="hostinsert.jsp"> 
				<input type="submit" value="숙소 등록하기">
				</form>
			<%
		}else{
			int a = arr.size();
			for(int i=0;i<arr.size();i++){
				%>
				
		<div id="div111">
		<article id= "main">
			<img src ="<%=arr.get(i).getImage()%>">
		</article>
		<article id="maininfo">
			<h3><%=arr.get(i).getRoom_name() %></h3>
				<ul>
					<li>지역 번호 :<%=arr.get(i).getRegion_idx()%></li>
					<li>편의 시설 :<%=arr.get(i).getGoodthing()%></li>
					<li>주소 :<%=arr.get(i).getAddr_detail()%></li>
					<li>가격 :<%=arr.get(i).getPrice()%></li>
				</ul>
		</article>
	</div>
		<div id="hr">
		<hr>
		</div>
				<%
			}
		}
	%>

</section>
</body>
</html>