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
function openrgUpdate(param) {
	window.open('/homes/admin/admin_region_update.jsp?param='+param,'adminrgUpdate','width=550,height=350');
}

function openrgInsert() {
	window.open('/homes/admin/admin_region_insert.jsp','adminrgInsert','width=550,height=350');
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
		<h2>지역 관리</h2>
		<table>
			<thead>
				<tr>
					<th>지역명</th>
					<th>상위지역</th>
					<th>수정</th>
				</tr>
			</thead>
			<tbody>
			<%
			ArrayList<RegionDTO> arr=adao.regionTable();
			if(arr==null||arr.size()==0){
				%>
				<tr>
					<td colspan="3" align="center">
						등록된 게시글이 없습니다
					</td>
				</tr>
				<%
			}else{
				for(int i=0;i<arr.size();i++){
					%>
					<tr>
						<td><%=arr.get(i).getRegion_name() %></td>
						<td style="text-align:center;"><%=adao.getParentName(arr.get(i).getParent_idx())  %></td>
						<td style="text-align:center;"><input type="button"  value="수정" class="rbutton" onclick="openrgUpdate(<%=arr.get(i).getRegion_idx() %>);"></td>
					</tr>
					<%
				}
			}
			%>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="3" align="right"><input type="button" value="지역 추가"  class="rbutton" style="width:95%;"onclick="openrgInsert();" ></td>
				</tr>
			</tfoot>
			
		</table>
	</div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>