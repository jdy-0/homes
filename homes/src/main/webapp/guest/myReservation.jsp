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
<style>
#bt_complete{
	background-color:cornsilk;
	color:#cd280e;
	padding:10px;
	border-radius:10px;
	border:2px solid #cd280e;
	width:150px;
	opacity:0.7;
	font-family: 'SBAggroB';
	font-size:20px;
	margin:10px;
}
#bt_complete:hover{
	opacity:0.5;
}
#bt_waiting{
	background-color:#cd280e;
	color:cornsilk;
	padding:10px;
	border-radius:10px;
	border:2px solid #cd280e;
	width:150px;
	font-family: 'SBAggroB';
	font-size:20px;
	margin:10px;
}
#bt_waiting:hover{
	opacity:0.5;
}

</style>
</head>
<body>
<%@include file="/header.jsp" %>
<section>
<%@include file="/guest/myPageNav.jsp" %>
<article id="myReserve" class="myPageContent_ar">
	<div style="text-align:center;">
		<input type="button" value="예약완료" id="bt_complete" onclick="showDiv('planned');">
		<input type="button" value="예약대기" id="bt_waiting" onclick="showDiv('waiting');">
	</div>
	<div id="planned">
	<%
	int useridx = (Integer)session.getAttribute("useridx");
	ArrayList<ReservationDTO> plannedRes = gdao.getReserveHistory(useridx, "예약완료");
	if(plannedRes==null || plannedRes.size()==0){
		%>
		<h2 class="alert_h">예약 내역이 없습니다.</h2>
		<%
	}else{
		for(int i=0;i<plannedRes.size();i++){
			%>
			<a href="res_detail.jsp?reserve_idx=<%=plannedRes.get(i).getReserve_idx() %>"> 
			<fieldset class="reserveCard">
				<table>
					<tr>
						<td rowspan="3"><img src="<%=plannedRes.get(i).getImage() %>"></td>
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
		<h2 class="alert_h">대기 중인 예약 내역이 없습니다.</h2>
		<%
	}else{
		for(int i=0;i<waitingList.size();i++){
			%>
			<a href="res_detail.jsp?reserve_idx=<%=waitingList.get(i).getReserve_idx() %>"> 
			<fieldset class="reserveCard">
				<table>
					<tr>
						<td rowspan="3"><img src="<%=waitingList.get(i).getImage() %>"></td>
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
		//대기버튼 눌렀을 때
		document.getElementById('waiting').style.display="block";
		document.getElementById('planned').style.display="none";
		//완료버튼이 진해짐
		document.getElementById('bt_complete').style.backgroundColor="#cd280e";
		document.getElementById('bt_complete').style.color="cornsilk";
		document.getElementById('bt_complete').style.opacity="1";
		//대기버튼이 연해짐
		document.getElementById('bt_waiting').style.backgroundColor="cornsilk";
		document.getElementById('bt_waiting').style.color="#cd280e";
		document.getElementById('bt_waiting').style.opacity="0.7";
	}else{
		//완료버튼 눌렀을 때
		document.getElementById('waiting').style.display="none";
		document.getElementById('planned').style.display="block";
		//완료버튼이 연해짐
		document.getElementById('bt_complete').style.backgroundColor="cornsilk";
		document.getElementById('bt_complete').style.color="#cd280e";
		document.getElementById('bt_complete').style.opacity="0.7";
		//대기버튼이 진해짐
		document.getElementById('bt_waiting').style.backgroundColor="#cd280e";
		document.getElementById('bt_waiting').style.color="cornsilk";
		document.getElementById('bt_waiting').style.opacity="1";
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