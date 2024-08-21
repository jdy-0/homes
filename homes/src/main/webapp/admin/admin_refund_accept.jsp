<%@page import="com.homes.admin.AdminRefundDTO"%>
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
</style>
<script>
function openrfStatus(param) {
	location.href='/homes/admin/admin_refund_accept_ok.jsp?param='+param;
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

	<div class="content">
		<h2>환불 승인 관리</h2>
		<table>
			<thead>
				<tr>
					<th>예약번호</th>
					<th>숙소명</th>
					<th>예약자</th>
					<th>체크인</th>
					<th>체크아웃</th>
					<th>결제날짜</th>
					<th>환불요청날짜</th>
					<th>결제금액</th>
					<th>환불금액</th>
					<th>승인</th>
				</tr>
			</thead>
			<tbody>
			<%
			ArrayList<AdminRefundDTO> arr=adao.getRefundStatus();
			if(arr==null||arr.size()==0){
				%>
				<tr>
					<td colspan="10" align="center">
						환불 대기중인 예약이 없습니다
					</td>
				</tr>
				<%
			}else{
				for(int i=0;i<arr.size();i++){
					%>
					<tr>				
						<td><%=arr.get(i).getReserve_idx()  %></td>
						<td><%=arr.get(i).getRoom_name() %></td>
						<td><%=arr.get(i).getNickname()  %></td>
						<td><%=arr.get(i).getCheck_in()  %></td>
						<td><%=arr.get(i).getCheck_out()  %></td>
						<td><%=arr.get(i).getPayment_date()  %></td>
						<td><%=arr.get(i).getRefund_date()  %></td>
						<td><%=arr.get(i).getPrice()  %></td>
						<td><%=arr.get(i).getAmount()  %></td>
						<td><input type="button"  value="승인" class="rbutton" onclick="openrfStatus(<%=arr.get(i).getReserve_idx() %>)"></td>
					</tr>
					<%
				}
			}
			%>
			</tbody>
			<!--
			<tfoot>
				<tr>
					<td colspan="10" style="text-align: right; padding: 3px 3px 0 0; border-top: 3px dotted gray;">
					<input type="button"  value="일괄승인" class="rbutton" onclick="" style="width: 90px;">
					</td>
				</tr>
			</tfoot>
			-->
		</table>
	</div>
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>