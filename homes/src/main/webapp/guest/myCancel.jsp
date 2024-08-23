<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.guest.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/myPageLayout.css">
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myCancel" class="myPageContent_ar">
	<div id="canceled">
	<%
	int useridx = (Integer)session.getAttribute("useridx");
	ArrayList<ReservationDTO> canceledRes = gdao.getReserveHistory(useridx, "예약취소");
	if(canceledRes==null || canceledRes.size()==0){
		%>
		<h2>취소된 예약 내역이 없습니다.</h2>
		<%
	}else{
		for(int i=0;i<canceledRes.size();i++){
			%>
			<a href="res_detail.jsp?reserve_idx=<%=canceledRes.get(i).getReserve_idx() %>"> 
			<fieldset>
				<table>
					<tr>
						<td rowspan="3"><img src="<%=canceledRes.get(i).getImage() %>" style="width:150px;"></td>
						<td><%=canceledRes.get(i).getRoom_name() %></td>
					</tr>
					<tr>
						<td><%=canceledRes.get(i).getCheck_in() %> ~ <%=canceledRes.get(i).getCheck_out() %></td>
					</tr>
					<tr>
						<td><%=canceledRes.get(i).getState() %></td>
					</tr>
				</table>
			</fieldset>
			</a>	
			<%
		}	
	}
	%>
	</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>