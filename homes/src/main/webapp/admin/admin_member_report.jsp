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
</style>
<style>
.content h2{
	text-align: center;
}
.content table {
	width: 550px;
	margin: 0px auto;
	border-top: 3px double black;
	border-bottom: 3px double black;
}
.content table th{
	background-color: #dec022;
}

.content table td{
	text-align: center;
}
.rbutton {
    width: 70px;
    background-color: #dec022;
    border: 3px solid black;
    font-family: 'SBAggroB';
    padding: 10px;
    font-size: 15px;
    text-align: center;
}
</style> -->
<script>
function openmsBlock(param) {
	location.href='/homes/admin/admin_member_report_ok.jsp?param='+param;
}
</script>
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
	
	<div class="content">
		<h2>신고 회원 관리</h2>
		<table>
			<thead>
				<tr>
					<th>이름</th>
					<th>아이디</th>
					<th>이메일</th>
					<th>번호</th>
					<th>신고횟수</th>
					<th>처리</th>
				</tr>
			</thead>
			<tbody>
			<%
			ArrayList<GuestDTO> arr=adao.getMember();
			if(arr==null||arr.size()==0){
				%>
				<tr>
					<td colspan="6" align="center">
						신고당한 회원이 없습니다
					</td>
				</tr>
				<%
			}else{
				for(int i=0;i<arr.size();i++){
					if(arr.get(i).getState()==1 && adao.memberReport(arr.get(i).getId())>=5){
						%>
						<tr>
							<td><%=arr.get(i).getName() %></td>
							<td><%=arr.get(i).getId() %></td>
							<td><%=arr.get(i).getEmail() %></td>
							<td><%=arr.get(i).getTel() %></td>
							<td><%=adao.memberReport(arr.get(i).getId()) %></td>
							<td><input type="button"  value="차단" class="rbutton" onclick="openmsBlock(<%=arr.get(i).getIdx() %>);"></td>
						</tr>
						<%
					}
				}
			}
			%>
			</tbody>
			
		</table>
	</div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>