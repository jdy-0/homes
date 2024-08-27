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
<link rel="stylesheet" type="text/css" href="/homes/css/adminLayout.css">
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
<article class="adminContent">
<%@include file="adminSideBar.jsp" %>
<fieldset class="fs_adminContent">

	<div class="content">
		<h2>환불 승인 관리</h2>
		<table id="refund_list">
			<thead style="font-size:18px; font-family: 'goorm-sans-bold';">
				<tr>
					<th>No.</th>
					<th>숙소명</th>
					<th>예약자</th>
					<th>체크인</th>
					<th>체크아웃</th>
					<th>결제일</th>
					<th>환불요청일</th>
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
					String checkin = arr.get(i).getCheck_in();
					String checkout = arr.get(i).getCheck_out();
					%>
					
					<tr>				
						<td><%=arr.get(i).getReserve_idx()  %></td>
						<td><%=arr.get(i).getRoom_name() %></td>
						<td style="text-align:center;"><%=arr.get(i).getNickname()  %></td>
						<td style="font-size:12px;"><%=checkin.substring(0,10)  %></td>
						<td style="font-size:12px;"><%=checkout.substring(0, 10)  %></td>
						<td style="font-size:12px;"><%=arr.get(i).getPayment_date()  %></td>
						<td style="font-size:12px;"><%=arr.get(i).getRefund_date()  %></td>
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