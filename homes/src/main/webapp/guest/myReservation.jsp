<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.homes.guest.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
if(session.getAttribute("useridx")==null || session.getAttribute("useridx")==""){
	%>
	<script>
	window.alert('로그인 후 이용 가능한 서비스입니다.');
	locatin.href='/homes';
	</script>
	<%
	return;
}
%>
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
<article id="myReserve" class="myPageContent_ar">
	<fieldset class="label_fs">
		<h3><%=session.getAttribute("usernickname") %>님 예약 내역</h3>
	</fieldset>
	<div style="text-align:center;">
		<input type="button" value="예약완료" class="button" onclick="showDiv('planned');">
		<input type="button" value="예약대기" class="button" onclick="showDiv('waiting');">
	</div>
	<div id="planned">
	<%
	int useridx = (Integer)session.getAttribute("useridx");
	ArrayList<ReservationDTO> plannedRes = gdao.getReserveHistory(useridx, "예약완료");
	if(plannedRes==null || plannedRes.size()==0){
		%>
		<h2>예약 내역이 없습니다.</h2>
		<%
	}else{
		for(int i=0;i<plannedRes.size();i++){
			%>
			<a href="res_detail.jsp?reserve_idx=<%=plannedRes.get(i).getReserve_idx() %>"> 
			<fieldset>
				<table>
					<tr>
						<td rowspan="3"><img src="<%=plannedRes.get(i).getImage() %>" style="width:150px;"></td>
						<td><%=plannedRes.get(i).getRoom_name() %></td>
					</tr>
					<tr>
						<td><%=plannedRes.get(i).getCheck_in() %> ~ <%=plannedRes.get(i).getCheck_out() %></td>
					</tr>
					<tr>
						<td><%=plannedRes.get(i).getState() %></td>
					</tr>
				</table>
			</fieldset>
			</a>	
			<%
		}	
	}
	%>
	</div>
	<div id="waiting" style="display:none;">
	<%
	ArrayList<ReservationDTO> waitingList = gdao.getReserveHistory(useridx, "예약대기중");
	if(waitingList==null || waitingList.size()==0){
		%>
		<h2 style="text-align:center;">대기 중인 예약 내역이 없습니다.</h2>
		<%
	}else{
		for(int i=0;i<waitingList.size();i++){
			%>
			<a href="res_detail.jsp?reserve_idx=<%=waitingList.get(i).getReserve_idx() %>"> 
			<fieldset>
				<table>
					<tr>
						<td rowspan="3"><img src="<%=waitingList.get(i).getImage() %>" style="width:150px;"></td>
						<td><%=waitingList.get(i).getRoom_name() %></td>
					</tr>
					<tr>
						<td><%=waitingList.get(i).getCheck_in() %> - <%=waitingList.get(i).getCheck_out() %></td>
					</tr>
					<tr>
						<td><%=waitingList.get(i).getState() %></td>
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
<script>
function showDiv(divId){
	if('waiting' == divId){
		document.getElementById('waiting').style.display="block";
		document.getElementById('planned').style.display="none";
	}else{
		document.getElementById('waiting').style.display="none";
		document.getElementById('planned').style.display="block";
	}
	/* var articles = ['waiting', 'planned'];
	
	for(var i=0;i<articles.length;i++){
		var article = document.getElementById(articles[i]);
		if(article){
			if(articles[i] == articleId){
				article.style.display="block";
			}else{
				article.style.display="none";
			}
		}
	} */
}
</script>
</body>
</html>