<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.region.RegionDTO" %>
<jsp:useBean id="rdto" class="com.homes.region.RegionDTO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>    
<%@ page import="com.homes.region.Region_DetailDTO" %>
<jsp:useBean id="rddto" class="com.homes.region.Region_DetailDTO"></jsp:useBean>
<jsp:useBean id="rddao" class="com.homes.region.Region_DetailDAO"></jsp:useBean>
<%@ page import="com.homes.room.RoomDTO" %>
<jsp:useBean id="rmdto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="rmdao" class="com.homes.room.RoomDAO"></jsp:useBean>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mainLayout.css">
<style>
#admin_box_fs{
	height: 600px;
	border-bottom:5px solid black;
	border-right:0px;
	border-left:0px;
	border-top:0px;
	margin:0px;
	display:flex;
}
.index_label_fs{
	background-color:#dec022;
	color:black;
	border-bottom:5px solid black;
	margin:0px;
	font-family: 'SBAggroB';
}
</style>
</head>
<%%>
<body>
<%@ include file="../header.jsp"%>
<section>
<article id="admin_box">
<fieldset class="index_label_fs">
<h2>관리자페이지</h2>
</fieldset>
<fieldset id="admin_box_fs">
	<div id="sidebar">
		<nav>
			<ul>
			    <li><a href="#">대시보드</a></li>
			    <li><a href="#">회원관리</a></li>
			    <li><a href="#">숙소관리</a></li>
			    <li><a href="#">후기관리</a></li>
			    <li><a href="#">QNA</a></li>
			</ul>
	     </nav>
     </div>
     <div id="content" style="width: auto">
     	<h1>콘텐츠 들어감</h1>
     </div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>