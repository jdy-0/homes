<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.homes.guest.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
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
<article id="myReserveHistory" class="myPageContent_ar">
	<h2 class="myReserve_h">지난 여행</h2>
	<div id="lastReserve">
	<%
	int useridx = (Integer)session.getAttribute("useridx");
	ArrayList<ReservationDTO> lastReserve = gdao.getReserveHistory(useridx, "이용완료");
	if(lastReserve==null || lastReserve.size()==0){
		%>
		<h2 class="alert_h">지난 예약 내역이 없습니다.</h2>
		<%
	}else{
		for(int i=0;i<lastReserve.size();i++){
			%>
			<a href="res_detail.jsp?reserve_idx=<%=lastReserve.get(i).getReserve_idx() %>"> 
			<fieldset class="reserveCard">
				<table>
					<tr>
						<td rowspan="3"><img src="<%=lastReserve.get(i).getImage() %>"></td>
						<td><%=lastReserve.get(i).getRoom_name() %></td>
					</tr>
					<tr>
						<td><%=lastReserve.get(i).getCheck_in() %> ~ <%=lastReserve.get(i).getCheck_out() %></td>
					</tr>
					<tr>
						<td><%=lastReserve.get(i).getState() %></td>
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