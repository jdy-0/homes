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
<script>
function openhstRoom(param) {
	location.href='/homes/admin/admin_host_acceptroom.jsp?param='+param;
}

function openhstState(param) {
	location.href='/homes/admin/admin_host_accept_ok.jsp?param='+param;
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
	<div>
		<h2>숙소 승인 관리</h2>
		<table>
			<thead>
				<tr>
					<th>숙소명</th>
					<th>호스트명</th>
					<th>정보확인</th>
					<th>승인</th>
				</tr>
			</thead>
			<%
			ArrayList<RoomDTO> arr=adao.getRoomState();
			if(arr==null||arr.size()==0){
				%>
				<tbody>
					<tr>
						<td colspan="4" align="center">
							승인 대기중인 숙소가 없습니다
						</td>
					</tr>
				</tbody>
				<%
			}else{
				%>
				<tbody>
				<%
				for(int i=0;i<arr.size();i++){
					%>
					<tr>
						<td><%=arr.get(i).getRoom_name() %></td>
						<td><%=adao.memberName(arr.get(i).getHost_idx()) %></td>
						<td><input type="button"  value="확인" class="rbutton" onclick="openhstRoom(<%=arr.get(i).getRoom_idx() %>)"></td>
						<td><input type="button"  value="승인" class="rbutton" onclick="openhstState(<%=arr.get(i).getRoom_idx() %>)"></td>
					</tr>
					<%
				}
			%>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" style="text-align: right; padding: 3px 3px 0 0;">
					<input type="button"  value="일괄승인" class="rbutton" onclick="openhstState(0)" style="width: 90px;">
					</td>
				</tr>
			</tfoot>
			<% 
			}
			%>
		</table>
	</div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>