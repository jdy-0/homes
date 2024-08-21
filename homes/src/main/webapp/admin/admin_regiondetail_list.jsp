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
<link rel="stylesheet" type="text/css" href="../css/adminLayout.css">
<script>
function openrgProfile(param) {
	location.href='/homes/admin/admin_region_profile.jsp?param='+param;
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
<fieldset>
	<div class="content">
		<h2>지역 관리</h2>
		<table>
			<thead>
				<tr>
					<th>지역명</th>
					<th>이미지</th>
					<th>이미지 변경</th>
					<th>클릭수</th>
				</tr>
			</thead>
			<tbody>
			<%
			ArrayList<Region_DetailDTO> arr=adao.regionDetailTable();
			if(arr==null||arr.size()==0){
				%>
				<tr>
					<td colspan="4" align="center">
						등록된 지역이 없습니다
					</td>
				</tr>
				<%
			}else{
				for(int i=0;i<arr.size();i++){
					%>
					<tr>
						<td><%=adao.getParentName(arr.get(i).getRegion_idx()) %></td>
						<td><img class="region_img" src="<%=arr.get(i).getImg()  %>" onerror="this.src='/homes/img/no_image.jpg'"></td>
						<td>
							<input type="button" value="수정" class="rbutton" onclick="openrgProfile(<%=arr.get(i).getRegion_idx() %>);">	
						</td>		
						<td><%=arr.get(i).getClick()  %></td>
					</tr>
					<%
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